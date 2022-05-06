import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:freezed/src/templates/assert.dart';
import 'package:freezed/src/templates/copy_with.dart';
import 'package:freezed/src/templates/parameter_template.dart';
import 'package:freezed/src/templates/properties.dart';
import 'package:freezed/src/templates/prototypes.dart';
import 'package:freezed/src/tools/type.dart';
import 'package:freezed/src/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart'
    show
        Assert,
        Freezed,
        FreezedMapOptions,
        FreezedUnionCase,
        FreezedUnionValue,
        FreezedWhenOptions;
import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

import 'models.dart';
import 'parse_generator.dart';
import 'templates/abstract_template.dart';
import 'templates/concrete_template.dart';
import 'templates/from_json_template.dart';
import 'tools/recursive_import_locator.dart';

extension on DartObject {
  T decodeField<T>(
    String fieldName, {
    required T Function(DartObject obj) decode,
    required T Function() orElse,
  }) {
    final field = getField(fieldName);
    if (field == null || field.isNull) return orElse();
    return decode(field);
  }
}

@immutable
class FreezedGenerator extends ParserGenerator<GlobalData, Data, Freezed> {
  FreezedGenerator(this._buildYamlConfigs);

  final Freezed _buildYamlConfigs;

  @override
  Future<Data> parseElement(
    BuildStep buildStep,
    GlobalData globalData,
    Element element,
  ) async {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '@freezed can only be applied on classes. Failing element: ${element.name}',
        element: element,
      );
    }

    final shouldUseExtends = element.constructors.any((ctor) {
      return ctor.name == '_' && !ctor.isFactory && !ctor.isAbstract;
    });

    final configs = _parseConfig(element);

    _assertValidClassUsage(element);
    for (final field in element.fields) {
      _assertValidFieldUsage(field, shouldUseExtends: shouldUseExtends);
    }

    final constructorsNeedsGeneration = await _parseConstructorsNeedsGeneration(
      buildStep,
      element,
      configs,
    );

    final shouldGenerateUnions = constructorsNeedsGeneration
        .where(
          (element) => element.name.isNotEmpty && !element.name.startsWith('_'),
        )
        .isNotEmpty;

    late final needsJsonSerializable = _needsJsonSerializable(
      buildStep,
      globalData,
      element,
    );

    return Data(
      name: element.name,
      shouldUseExtends: shouldUseExtends,
      unionKey: configs.unionKey!,
      generateToString:
          configs.toStringOverride ?? !_hasCustomToString(element),
      generateCopyWith: configs.copyWith!,
      generateEqual: configs.equal ?? !_hasCustomEquals(element),
      generateFromJson: configs.fromJson ?? await needsJsonSerializable,
      generateToJson: configs.toJson ?? await needsJsonSerializable,
      map: MapConfig(
        map: configs.map?.map ?? shouldGenerateUnions,
        mapOrNull: configs.map?.mapOrNull ?? shouldGenerateUnions,
        maybeMap: configs.map?.maybeMap ?? shouldGenerateUnions,
      ),
      when: WhenConfig(
        when: configs.when?.when ?? shouldGenerateUnions,
        whenOrNull: configs.when?.whenOrNull ?? shouldGenerateUnions,
        maybeWhen: configs.when?.maybeWhen ?? shouldGenerateUnions,
      ),
      makeCollectionsImmutable: configs.makeCollectionsUnmodifiable!,
      constructors: constructorsNeedsGeneration,
      concretePropertiesName: [
        for (final p in element.fields)
          if (!p.isStatic) p.name,
      ],
      genericsDefinitionTemplate:
          GenericsDefinitionTemplate.fromGenericElement(element.typeParameters),
      genericsParameterTemplate:
          GenericsParameterTemplate.fromGenericElement(element.typeParameters),
    );
  }

  List<Property> _commonProperties(
    List<ConstructorDetails> constructorsNeedsGeneration,
  ) {
    final commonParameters =
        _commonParametersBetweenAllConstructors(constructorsNeedsGeneration);

    return [
      for (final commonParameter in commonParameters)
        Property(
          decorators: commonParameter.decorators,
          name: commonParameter.name,
          isFinal: commonParameter.isFinal,
          doc: commonParameter.doc,
          type: commonParameter.type,
          defaultValueSource: commonParameter.defaultValueSource,
          isNullable: commonParameter.isNullable,
          isDartList: commonParameter.isDartList,
          isDartMap: commonParameter.isDartMap,
          isDartSet: commonParameter.isDartSet,
          isPossiblyDartCollection: commonParameter.isPossiblyDartCollection,
          // TODO: support hasJsonKey
          hasJsonKey: false,
        ),
    ];
  }

  void _assertValidClassUsage(ClassElement element) {
    // TODO: verify _$name is mixed-in
    if (element.isAbstract) {
      log.warning(
        '''
The class ${element.name} was declared as abstract, but it is not need anymore.
Read here: https://github.com/rrousselGit/freezed/tree/master/packages/freezed#the-abstract-keyword
''',
      );
    }
  }

  void _assertValidNormalConstructorUsage(
    ConstructorElement constructor, {
    required String className,
  }) {
    if (!constructor.isFactory &&
        (constructor.name != '_' || constructor.parameters.isNotEmpty)) {
      throw InvalidGenerationSourceError(
        'Classes decorated with @freezed can only have a single non-factory'
        ', without parameters, and named MyClass._()',
        element: constructor,
      );
    }
  }

  void _assertValidFreezedConstructorUsage(
    ConstructorElement constructor, {
    required String className,
  }) {
    for (final parameter in constructor.parameters) {
      if (parameter.type.nullabilitySuffix != NullabilitySuffix.question &&
          parameter.isOptional &&
          parameter.defaultValue == null &&
          !parameter.type.isDynamic) {
        final ctorName =
            constructor.isDefaultConstructor ? '' : '.${constructor.name}';

        throw InvalidGenerationSourceError(
          'The parameter `${parameter.name}` of `$className$ctorName` is non-nullable but is neither required nor marked with @Default',
          element: parameter,
        );
      }
    }
  }

  void _assertValidFieldUsage(
    FieldElement field, {
    required bool shouldUseExtends,
  }) {
    if (field.isStatic) return;

    if (field.setter != null) {
      throw InvalidGenerationSourceError(
        'Classes decorated with @freezed cannot have mutable properties',
        element: field,
      );
    }

    // The field is a "Type get name => "
    if (!shouldUseExtends &&
        field.getter != null &&
        !field.getter!.isAbstract &&
        !field.getter!.isSynthetic) {
      throw InvalidGenerationSourceError(
        'Getters require a MyClass._() constructor',
        element: field,
      );
    }

    // The field is a "final name = "
    if (!shouldUseExtends && field.isFinal && field.hasInitializer) {
      throw InvalidGenerationSourceError(
        'Final variables require a MyClass._() constructor',
        element: field,
      );
    }
  }

  Future<bool> _needsJsonSerializable(
    BuildStep buildStep,
    GlobalData globalData,
    ClassElement element,
  ) async {
    if (!globalData.hasJson) return false;

    for (final constructor in element.constructors) {
      if (constructor.isFactory && constructor.name == 'fromJson') {
        final ast = await tryGetAstNodeForElement(constructor, buildStep);
        return ast.endToken.stringValue == ';';
      }
    }

    return false;
  }

  List<Parameter> _commonParametersBetweenAllConstructors(
    List<ConstructorDetails> constructorsNeedsGeneration,
  ) {
    return constructorsNeedsGeneration.first.parameters.allParameters
        .where((parameter) {
      return constructorsNeedsGeneration.every((constructor) {
        return constructor.parameters.allParameters.any((p) {
          return p.name == parameter.name && p.type == parameter.type;
        });
      });
    }).toList();
  }

  Future<List<ConstructorDetails>> _parseConstructorsNeedsGeneration(
    BuildStep buildStep,
    ClassElement element,
    Freezed options,
  ) async {
    final result = <ConstructorDetails>[];
    for (final constructor in element.constructors) {
      if (!constructor.isFactory || constructor.name == 'fromJson') {
        _assertValidNormalConstructorUsage(
          constructor,
          className: element.name,
        );
        continue;
      }

      final redirectedName =
          await _getConstructorRedirectedName(constructor, buildStep);

      if (redirectedName == null) {
        _assertValidNormalConstructorUsage(
          constructor,
          className: element.name,
        );
        continue;
      }

      _assertValidFreezedConstructorUsage(constructor, className: element.name);

      result.add(
        ConstructorDetails(
          asserts: _parseAsserts(constructor).toList(),
          name: constructor.name,
          unionValue: constructor.unionValue(options.unionValueCase),
          isConst: constructor.isConst,
          fullName: _fullName(element, constructor),
          escapedName: _escapedName(element, constructor),
          impliedProperties: [
            for (final parameter in constructor.parameters)
              await Property.fromParameter(
                parameter,
                buildStep,
                addImplicitFinal: options.addImplicitFinal,
              ),
          ],
          decorators: constructor.metadata
              .where((element) {
                final elementSourceUri =
                    element.element?.declaration?.librarySource?.uri;

                final isFreezedAnnotation = elementSourceUri != null &&
                    elementSourceUri.scheme == 'package' &&
                    elementSourceUri.pathSegments.isNotEmpty &&
                    elementSourceUri.pathSegments.first == 'freezed_annotation';

                return !isFreezedAnnotation;
              })
              .map((e) => e.toSource())
              .toList(),
          withDecorators: _withDecorationTypes(constructor).toSet().toList(),
          implementsDecorators:
              _implementsDecorationTypes(constructor).toSet().toList(),
          isDefault: isDefaultConstructor(constructor),
          hasJsonSerializable: constructor.hasJsonSerializable,
          isFallback: constructor.isFallbackUnion(options.fallbackUnion),
          cloneableProperties: await _cloneableProperties(
            buildStep,
            element,
            constructor,
          ).toList(),
          parameters: await ParametersTemplate.fromParameterElements(
            buildStep,
            constructor.parameters,
            addImplicitFinal: options.addImplicitFinal,
          ),
          redirectedName: redirectedName,
        ),
      );
    }

    if (result.isEmpty) {
      throw InvalidGenerationSourceError(
        'Marked ${element.name} with @freezed, but freezed has nothing to generate',
        element: element,
      );
    }

    if (result.length > 1 && result.any((c) => c.name.startsWith('_'))) {
      throw InvalidGenerationSourceError(
        'A freezed union cannot have private constructors',
        element: element,
      );
    }

    if (options.fallbackUnion != null && result.none((c) => c.isFallback)) {
      throw InvalidGenerationSourceError(
        'Fallback union was specified but no ${options.fallbackUnion} constructor exists.',
        element: element,
      );
    }

    return result;
  }

  Iterable<String> _withDecorationTypes(ConstructorElement constructor) sync* {
    for (final metadata in constructor.metadata) {
      if (!metadata.isWith) continue;
      final object = metadata.computeConstantValue()!;

      yield resolveFullTypeStringFrom(
        constructor.library,
        (object.type! as InterfaceType).typeArguments.single,
        withNullability: false,
      );
    }
  }

  Iterable<String> _implementsDecorationTypes(
    ConstructorElement constructor,
  ) sync* {
    for (final metadata in constructor.metadata) {
      if (!metadata.isImplements) continue;
      final object = metadata.computeConstantValue()!;

      yield resolveFullTypeStringFrom(
        constructor.library,
        (object.type! as InterfaceType).typeArguments.single,
        withNullability: false,
      );
    }
  }

  Stream<CloneableProperty> _cloneableProperties(
    BuildStep buildStep,
    ClassElement element,
    ConstructorElement constructor,
  ) async* {
    for (final parameter in constructor.parameters) {
      final type = parseTypeSource(parameter);

      final parameterTypeElement = parameter.type.element;
      if (parameterTypeElement == null) continue;
      if (parameterTypeElement is! ClassElement) continue;

      final classElement = parameterTypeElement;

      if (!typeChecker.hasAnnotationOf(classElement)) continue;

      yield CloneableProperty(
        name: parameter.name,
        type: type!,
        nullable:
            parameter.type.nullabilitySuffix == NullabilitySuffix.question,
        typeName: parameter.type.element!.name!,
        genericParameters: GenericsParameterTemplate(
          (parameter.type as InterfaceType)
              .typeArguments
              .map((e) => e.getDisplayString(withNullability: true))
              .toList(),
        ),
      );
    }
  }

  Iterable<CloneableProperty> _commonCloneableProperties(
    List<ConstructorDetails> constructors,
    List<Property> commonProperties,
  ) sync* {
    for (final cloneableProperty in constructors.first.cloneableProperties) {
      for (final commonProperty in commonProperties) {
        if (cloneableProperty.name == commonProperty.name) {
          yield cloneableProperty;
        }
      }
    }
  }

  Freezed _parseConfig(Element element) {
    final annotation = const TypeChecker.fromRuntime(Freezed)
        .firstAnnotationOf(element, throwOnUnresolved: false)!;

    return Freezed(
      copyWith: annotation.decodeField(
        'copyWith',
        decode: (obj) => obj.toBoolValue(),
        orElse: () => _buildYamlConfigs.copyWith,
      ),
      makeCollectionsUnmodifiable: annotation.decodeField(
        'makeCollectionsUnmodifiable',
        decode: (obj) => obj.toBoolValue(),
        orElse: () => _buildYamlConfigs.makeCollectionsUnmodifiable,
      ),
      equal: annotation.decodeField(
        'equal',
        decode: (obj) => obj.toBoolValue(),
        orElse: () => _buildYamlConfigs.equal,
      ),
      fallbackUnion: annotation.decodeField(
        'fallbackUnion',
        decode: (obj) => obj.toStringValue(),
        orElse: () => _buildYamlConfigs.fallbackUnion,
      ),
      fromJson: annotation.decodeField(
        'fromJson',
        decode: (obj) => obj.toBoolValue(),
        orElse: () => _buildYamlConfigs.fromJson,
      ),
      addImplicitFinal: annotation.getField('addImplicitFinal')!.toBoolValue()!,
      map: annotation.decodeField(
        'map',
        decode: (obj) {
          return FreezedMapOptions(
            map: obj.decodeField(
              'map',
              decode: (obj) => obj.toBoolValue(),
              orElse: () => _buildYamlConfigs.map?.map,
            ),
            maybeMap: obj.decodeField(
              'maybeMap',
              decode: (obj) => obj.toBoolValue(),
              orElse: () => _buildYamlConfigs.map?.maybeMap,
            ),
            mapOrNull: obj.decodeField(
              'mapOrNull',
              decode: (obj) => obj.toBoolValue(),
              orElse: () => _buildYamlConfigs.map?.mapOrNull,
            ),
          );
        },
        orElse: () => _buildYamlConfigs.map,
      ),
      toJson: annotation.decodeField(
        'toJson',
        decode: (obj) => obj.toBoolValue(),
        orElse: () => _buildYamlConfigs.toJson,
      ),
      toStringOverride: annotation.decodeField(
        'toStringOverride',
        decode: (obj) => obj.toBoolValue(),
        orElse: () => _buildYamlConfigs.toStringOverride,
      ),
      unionKey: annotation
          .decodeField(
            'unionKey',
            decode: (obj) => obj.toStringValue(),
            orElse: () => _buildYamlConfigs.unionKey,
          )
          ?.replaceAll("'", r"\'")
          .replaceAll(r'$', r'\$'),
      unionValueCase: annotation.decodeField(
        'unionValueCase',
        decode: (obj) {
          final enumIndex = obj.getField('index')?.toIntValue();
          if (enumIndex == null) return null;
          return FreezedUnionCase.values[enumIndex];
        },
        orElse: () => _buildYamlConfigs.unionValueCase,
      ),
      when: annotation.decodeField(
        'when',
        decode: (obj) {
          return FreezedWhenOptions(
            when: obj.decodeField(
              'when',
              decode: (obj) => obj.toBoolValue(),
              orElse: () => _buildYamlConfigs.when?.when,
            ),
            maybeWhen: obj.decodeField(
              'maybeWhen',
              decode: (obj) => obj.toBoolValue(),
              orElse: () => _buildYamlConfigs.when?.maybeWhen,
            ),
            whenOrNull: obj.decodeField(
              'whenOrNull',
              decode: (obj) => obj.toBoolValue(),
              orElse: () => _buildYamlConfigs.when?.whenOrNull,
            ),
          );
        },
        orElse: () => _buildYamlConfigs.when,
      ),
    );
  }

  Iterable<AssertTemplate> _parseAsserts(ConstructorElement constructor) sync* {
    for (final meta
        in const TypeChecker.fromRuntime(Assert).annotationsOf(constructor)) {
      yield AssertTemplate(
        eval: meta.getField('eval')!.toStringValue(),
        message: meta.getField('message')!.toStringValue(),
      );
    }
  }

  @override
  Iterable<Object> generateForAll(GlobalData globalData) sync* {
    yield r'T _$identity<T>(T value) => value;';
    yield '\n\nfinal $privConstUsedErrorVarName = UnsupportedError(\'$privConstUsedErrorString\');\n';
  }

  @override
  Iterable<Object> generateForData(
    GlobalData globalData,
    Data data,
  ) sync* {
    if (data.generateFromJson) {
      yield FromJson(
        name: data.name,
        unionKey: data.unionKey,
        constructors: data.constructors,
        genericParameters: data.genericsParameterTemplate,
        genericDefinitions: data.genericsDefinitionTemplate,
      );
    }

    final commonProperties = _commonProperties(data.constructors);

    final commonCopyWith = !data.generateCopyWith
        ? null
        : CopyWith(
            clonedClassName: data.name,
            cloneableProperties: _commonCloneableProperties(
              data.constructors,
              commonProperties,
            ).toList(),
            genericsDefinition: data.genericsDefinitionTemplate,
            genericsParameter: data.genericsParameterTemplate,
            allProperties: commonProperties,
            data: data,
          );

    yield Abstract(
      data: data,
      copyWith: commonCopyWith,
      commonProperties: commonProperties,
    );

    for (final constructor in data.constructors) {
      yield Concrete(
        data: data,
        constructor: constructor,
        commonProperties: commonProperties,
        globalData: globalData,
        copyWith: !data.generateCopyWith
            ? null
            : CopyWith(
                clonedClassName: '_\$${constructor.redirectedName}',
                cloneableProperties: constructor.cloneableProperties,
                genericsDefinition: data.genericsDefinitionTemplate,
                genericsParameter: data.genericsParameterTemplate,
                allProperties: constructor.impliedProperties,
                data: data,
                parent: commonCopyWith,
              ),
      );
    }
  }

  @override
  GlobalData parseGlobalData(LibraryElement library) {
    return GlobalData(
      hasJson: library.importsJsonSerializable,
      hasDiagnostics: library.importsDiagnosticable,
    );
  }

  bool _hasCustomToString(ClassElement element) {
    for (final type in [
      element,
      ...element.allSupertypes
          .map((e) => e.element)
          .where((e) => !e.isDartCoreObject)
    ]) {
      for (final method in type.methods) {
        if (method.name == 'toString') {
          return true;
        }
      }
    }

    return false;
  }

  bool _hasCustomEquals(ClassElement element) {
    for (final type in [
      element,
      ...element.allSupertypes
          .map((e) => e.element)
          .where((e) => !e.isDartCoreObject)
    ]) {
      for (final method in type.methods.where((e) => e.isOperator)) {
        if (method.name == '==') {
          return true;
        }
      }
    }
    return false;
  }

  String _fullName(ClassElement element, ConstructorElement constructor) {
    var generics = element.typeParameters.map((e) {
      return '\$${e.name}';
    }).join(', ');
    if (generics.isNotEmpty) {
      generics = '<$generics>';
    }

    return constructor.name.isEmpty
        ? '${element.name}$generics'
        : '${element.name}$generics.${constructor.name}';
  }

  String _escapedName(ClassElement element, ConstructorElement constructor) {
    var generics = element.typeParameters.map((e) {
      return '\$${e.name}';
    }).join(', ');
    if (generics.isNotEmpty) {
      generics = '<$generics>';
    }

    final escapedElementName = element.name.replaceAll(r'$', r'\$');

    return constructor.name.isEmpty
        ? '$escapedElementName$generics'
        : '$escapedElementName$generics.${constructor.name}';
  }

  /// For:
  ///
  /// ```dart
  /// Constructor.named() = _Redirection<T>;
  /// ```
  ///
  /// returns `_Redirection`;
  Future<String?> _getConstructorRedirectedName(
    ConstructorElement constructor,
    BuildStep buildStep,
  ) async {
    final ast = await tryGetAstNodeForElement(constructor, buildStep);

    if (ast.endToken.stringValue != ';') return null;

    Token? equalToken = ast.endToken;
    while (true) {
      if (equalToken == null ||
          equalToken.charOffset < constructor.nameOffset) {
        return null;
      }
      if (equalToken.stringValue == '=>') return null;
      if (equalToken.stringValue == '=') {
        break;
      }

      equalToken = equalToken.previous;
    }

    var genericOrEndToken = equalToken;
    while (genericOrEndToken.stringValue != '<' &&
        genericOrEndToken.stringValue != ';') {
      genericOrEndToken = genericOrEndToken.next!;
    }

    final source = constructor.source.contents.data;
    final redirectedName = source
        .substring(equalToken.charOffset + 1, genericOrEndToken.charOffset)
        .trim();

    if (redirectedName.isEmpty) return null;

    return redirectedName;
  }
}

extension on LibraryElement {
  bool get importsJsonSerializable => const RecursiveImportLocator().hasImport(
        root: this,
        where: isClass('JsonSerializable'),
        whereLibrary: isWithin('json_annotation'),
      );

  bool get importsDiagnosticable => const RecursiveImportLocator().hasImport(
        root: this,
        where: isClass('Diagnosticable'),
        whereLibrary: isWithin('flutter'),
      );
}

extension on Element {
  bool get hasJsonSerializable {
    return const TypeChecker.fromRuntime(JsonSerializable).hasAnnotationOf(
      this,
      throwOnUnresolved: false,
    );
  }
}

extension on ConstructorElement {
  bool isFallbackUnion(String? fallbackConstructorName) {
    final constructorName = isDefaultConstructor(this) ? 'default' : name;
    return constructorName == fallbackConstructorName;
  }

  String unionValue(FreezedUnionCase? unionCase) {
    final annotation = const TypeChecker.fromRuntime(FreezedUnionValue)
        .firstAnnotationOf(this, throwOnUnresolved: false);
    if (annotation != null) {
      return annotation.getField('value')!.toStringValue()!;
    }

    final constructorName = isDefaultConstructor(this) ? 'default' : name;
    switch (unionCase) {
      case null:
      case FreezedUnionCase.none:
        return constructorName;
      case FreezedUnionCase.kebab:
        return kebabCase(constructorName);
      case FreezedUnionCase.pascal:
        return pascalCase(constructorName);
      case FreezedUnionCase.snake:
        return snakeCase(constructorName);
      case FreezedUnionCase.screamingSnake:
        return screamingSnake(constructorName);
    }
  }
}

String? parseLateGetterSource(String source) {
  var parenthesis = 0;

  for (var i = 0; i < source.length; i++) {
    final char = source[i];
    switch (char) {
      case '(':
        parenthesis++;
        break;
      case ')':
        parenthesis--;
        break;
      case ';':
        if (parenthesis == 0) {
          final reg = RegExp(r'^[\s\t\n]*=>[\s\t\n]*(.+)', dotAll: true);
          return reg.firstMatch(source.substring(0, i))?.group(1);
        }
        break;
      default:
        break;
    }
  }
  return null;
}
