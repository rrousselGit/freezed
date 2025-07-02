import 'package:analyzer/dart/ast/ast.dart';
import 'package:collection/collection.dart';
import 'package:freezed/src/templates/copy_with.dart';
import 'package:freezed/src/tools/type.dart';
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

import 'models.dart';
import 'parse_generator.dart';
import 'templates/abstract_template.dart';
import 'templates/concrete_template.dart';
import 'templates/from_json_template.dart';

extension StringX on String {
  String get public {
    if (startsWith('_')) return substring(1);
    return this;
  }
}

@immutable
class FreezedGenerator extends ParserGenerator<Freezed> {
  FreezedGenerator(this._buildYamlConfigs, {required this.format});

  final Freezed _buildYamlConfigs;

  @override
  Future<Data> parseDeclaration(
    BuildStep buildStep,
    GlobalData globalData,
    Declaration declaration,
    DartObject annotation,
  ) async {
    if (declaration is! ClassDeclaration) {
      throw InvalidGenerationSourceError(
        '@freezed can only be applied on classes.',
        element: declaration.declaredElement,
      );
    }

    final shouldUseExtends = declaration.constructors.any((ctor) {
      return ctor.name?.lexeme == '_' && ctor.factoryKeyword == null;
    });

    final configs = _parseConfig(annotation);

    for (final field in declaration.declaredElement!.fields) {
      _assertValidFieldUsage(field, shouldUseExtends: shouldUseExtends);
    }

    final constructorsNeedsGeneration = await _parseConstructorsNeedsGeneration(
      buildStep,
      declaration,
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
      declaration,
    );

    return Data(
      name: declaration.name.lexeme,
      shouldUseExtends: shouldUseExtends,
      unionKey: configs.unionKey!,
      generateToString:
          configs.toStringOverride ?? !declaration.hasCustomToString,
      generateCopyWith: configs.copyWith!,
      generateEqual: configs.equal ?? !declaration.hasCustomEquals,
      generateFromJson: configs.fromJson ?? await needsJsonSerializable,
      generateToJson: configs.toJson ?? await needsJsonSerializable,
      genericArgumentFactories: configs.genericArgumentFactories,
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
        for (final p in declaration.declaredElement!.fields)
          if (!p.isStatic) p.name,
      ],
      genericsDefinitionTemplate: GenericsDefinitionTemplate.fromGenericElement(
        declaration.declaredElement!.typeParameters,
      ),
      genericsParameterTemplate: GenericsParameterTemplate.fromGenericElement(
        declaration.declaredElement!.typeParameters,
      ),
    );
  }

  void _assertValidNormalConstructorUsage(
    ConstructorDeclaration constructor, {
    required String className,
  }) {
    if (constructor.factoryKeyword == null &&
        (constructor.name?.lexeme != '_' ||
            constructor.parameters.parameters.isNotEmpty)) {
      throw InvalidGenerationSourceError(
        'Classes decorated with @freezed can only have a single non-factory'
        ', without parameters, and named MyClass._()',
        element: constructor.declaredElement,
      );
    }
  }

  void _assertValidFreezedConstructorUsage(
    ConstructorDeclaration constructor, {
    required String className,
  }) {
    for (final parameter in constructor.parameters.parameters) {
      final parameterElement = parameter.declaredElement;
      if (parameterElement == null) continue;

      if (parameterElement.type.nullabilitySuffix !=
              NullabilitySuffix.question &&
          parameterElement.isOptional &&
          parameterElement.defaultValue == null &&
          !parameterElement.type.isDynamic2) {
        final ctorName = constructor.name == null ? '' : '.${constructor.name}';

        throw InvalidGenerationSourceError(
          'The parameter `${parameter.name}` of `$className$ctorName` is non-nullable but is neither required nor marked with @Default',
          element: parameter.declaredElement,
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
    ClassDeclaration declaration,
  ) async {
    if (!globalData.hasJson) return false;

    for (final constructor in declaration.constructors) {
      if (constructor.factoryKeyword != null &&
          constructor.name?.lexeme == 'fromJson') {
        return constructor.body is ExpressionFunctionBody;
      }
    }

    return false;
  }

  CommonProperties _commonParametersBetweenAllConstructors(
    List<ConstructorDetails> constructorsNeedsGeneration,
  ) {
    final result = CommonProperties();
    if (constructorsNeedsGeneration.length == 1) {
      result.readableProperties.addAll(
        constructorsNeedsGeneration.first.parameters.allParameters.map(
          Property.fromParameter,
        ),
      );
      result.cloneableProperties.addAll(result.readableProperties);
      return result;
    }

    parameterLoop:
    for (final parameter
        in constructorsNeedsGeneration.first.parameters.allParameters) {
      final library = parameter.parameterElement!.library!;

      var commonTypeBetweenAllUnionConstructors =
          parameter.parameterElement!.type;

      for (final constructor in constructorsNeedsGeneration) {
        final matchingParameter = constructor.parameters.allParameters
            .firstWhereOrNull((p) => p.name == parameter.name);
        // The property is not present in one of the union cases, so shouldn't
        // be present in the abstract class.
        if (matchingParameter == null) continue parameterLoop;

        commonTypeBetweenAllUnionConstructors = library.typeSystem
            .leastUpperBound(
              commonTypeBetweenAllUnionConstructors,
              matchingParameter.parameterElement!.type,
            );
      }

      final matchingParameters = constructorsNeedsGeneration
          .expand((element) => element.parameters.allParameters)
          .where((element) => element.name == parameter.name)
          .toList();

      final isFinal = matchingParameters.any(
        (element) =>
            element.isFinal ||
            element.parameterElement?.type !=
                commonTypeBetweenAllUnionConstructors,
      );

      final nonNullableCommonType = library.typeSystem.promoteToNonNull(
        commonTypeBetweenAllUnionConstructors,
      );

      final didDowncast = matchingParameters.any(
        (element) =>
            element.parameterElement?.type !=
            commonTypeBetweenAllUnionConstructors,
      );
      final didNonNullDowncast = matchingParameters.any(
        (element) =>
            element.parameterElement?.type !=
                commonTypeBetweenAllUnionConstructors &&
            element.parameterElement?.type != nonNullableCommonType,
      );
      final didNullDowncast = !didNonNullDowncast && didDowncast;

      final commonTypeString = resolveFullTypeStringFrom(
        library,
        commonTypeBetweenAllUnionConstructors,
      );

      final commonProperty = Property(
        isFinal: isFinal,
        type: commonTypeString,
        isNullable: commonTypeBetweenAllUnionConstructors.isNullable,
        isDartList: commonTypeBetweenAllUnionConstructors.isDartCoreList,
        isDartMap: commonTypeBetweenAllUnionConstructors.isDartCoreMap,
        isDartSet: commonTypeBetweenAllUnionConstructors.isDartCoreSet,
        isPossiblyDartCollection:
            commonTypeBetweenAllUnionConstructors.isPossiblyDartCollection,
        name: parameter.name,
        decorators: parameter.decorators,
        defaultValueSource: parameter.defaultValueSource,
        doc: parameter.doc,
        // TODO support JsonKey
        hasJsonKey: false,
      );

      result.readableProperties.add(commonProperty);

      // For {int a, int b, int c} | {int a, int? b, double c}, allows:
      // copyWith({int a, int b})
      // - int? b is not allowed because `null` is not compatible with the
      //   first union case.
      // - num c is not allowed because num is not assignable int/double
      if (!didNonNullDowncast) {
        final copyWithType = didNullDowncast
            ? nonNullableCommonType
            : commonTypeBetweenAllUnionConstructors;

        result.cloneableProperties.add(
          Property(
            isFinal: isFinal,
            type: resolveFullTypeStringFrom(library, copyWithType),
            isNullable: copyWithType.isNullable,
            isDartList: copyWithType.isDartCoreList,
            isDartMap: copyWithType.isDartCoreMap,
            isDartSet: copyWithType.isDartCoreSet,
            isPossiblyDartCollection: copyWithType.isPossiblyDartCollection,
            name: parameter.name,
            decorators: parameter.decorators,
            defaultValueSource: parameter.defaultValueSource,
            doc: parameter.doc,
            // TODO support JsonKey
            hasJsonKey: false,
          ),
        );
      }
    }

    return result;
  }

  Future<List<ConstructorDetails>> _parseConstructorsNeedsGeneration(
    BuildStep buildStep,
    ClassDeclaration declaration,
    Freezed options,
  ) async {
    final result = <ConstructorDetails>[];
    for (final constructor in declaration.constructors) {
      if (constructor.factoryKeyword == null ||
          constructor.name?.lexeme == 'fromJson') {
        _assertValidNormalConstructorUsage(
          constructor,
          className: declaration.name.lexeme,
        );
        continue;
      }

      final redirectedName =
          constructor.redirectedConstructor?.type.name2.lexeme;

      if (redirectedName == null) {
        _assertValidNormalConstructorUsage(
          constructor,
          className: declaration.name.lexeme,
        );
        continue;
      }

      _assertValidFreezedConstructorUsage(
        constructor,
        className: declaration.name.lexeme,
      );

      result.add(
        ConstructorDetails(
          asserts: _parseAsserts(constructor).toList(),
          name: constructor.name?.lexeme ?? '',
          unionValue: constructor.declaredElement!.unionValue(
            options.unionValueCase,
          ),
          isConst: constructor.constKeyword != null,
          fullName: constructor.fullName,
          escapedName: constructor.escapedName,
          impliedProperties: [
            for (final parameter in constructor.parameters.parameters)
              await Property.fromFormalParameter(
                parameter,
                buildStep,
                addImplicitFinal: options.addImplicitFinal,
              ),
          ],
          decorators: constructor.metadata
              .where((element) {
                final elementSourceUri =
                    element.element?.declaration?.librarySource?.uri;

                final isFreezedAnnotation =
                    elementSourceUri != null &&
                    elementSourceUri.scheme == 'package' &&
                    elementSourceUri.pathSegments.isNotEmpty &&
                    elementSourceUri.pathSegments.first == 'freezed_annotation';

                return !isFreezedAnnotation;
              })
              .map((e) => e.toSource())
              .toList(),
          withDecorators: _withDecorationTypes(
            constructor.declaredElement!,
          ).toSet().toList(),
          implementsDecorators: _implementsDecorationTypes(
            constructor.declaredElement!,
          ).toSet().toList(),
          isDefault: isDefaultConstructor(constructor.declaredElement!),
          hasJsonSerializable: constructor.declaredElement!.hasJsonSerializable,
          isFallback: constructor.declaredElement!.isFallbackUnion(
            options.fallbackUnion,
          ),
          cloneableProperties: _cloneableProperties(
            buildStep,
            declaration.declaredElement!,
            constructor.declaredElement!,
          ).toList(),
          parameters: await ParametersTemplate.fromParameterList(
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
        'Marked ${declaration.name} with @freezed, but freezed has nothing to generate',
        element: declaration.declaredElement,
      );
    }

    if (result.length > 1 && result.any((c) => c.name.startsWith('_'))) {
      throw InvalidGenerationSourceError(
        'A freezed union cannot have private constructors',
        element: declaration.declaredElement,
      );
    }

    if (options.fallbackUnion != null && result.none((c) => c.isFallback)) {
      throw InvalidGenerationSourceError(
        'Fallback union was specified but no ${options.fallbackUnion} constructor exists.',
        element: declaration.declaredElement,
      );
    }

    return result;
  }

  Iterable<String> _withDecorationTypes(ConstructorElement constructor) sync* {
    for (final metadata in constructor.metadata) {
      if (!metadata.isWith) continue;
      final object = metadata.computeConstantValue()!;

      final stringType = object.getField('stringType');
      if (stringType?.isNull == false) {
        yield stringType!.toStringValue()!;
      } else {
        yield resolveFullTypeStringFrom(
          constructor.library,
          (object.type! as InterfaceType).typeArguments.single,
        );
      }
    }
  }

  Iterable<String> _implementsDecorationTypes(
    ConstructorElement constructor,
  ) sync* {
    for (final metadata in constructor.metadata) {
      if (!metadata.isImplements) continue;
      final object = metadata.computeConstantValue()!;

      final stringType = object.getField('stringType');
      if (stringType?.isNull == false) {
        yield stringType!.toStringValue()!;
      } else {
        yield resolveFullTypeStringFrom(
          constructor.library,
          (object.type! as InterfaceType).typeArguments.single,
        );
      }
    }
  }

  Iterable<DeepCloneableProperty> _cloneableProperties(
    BuildStep buildStep,
    ClassElement element,
    ConstructorElement constructor,
  ) sync* {
    for (final parameter in constructor.parameters) {
      final type = parseTypeSource(parameter);

      final parameterType = parameter.type;
      if (parameterType is! InterfaceType) continue;
      final typeElement = parameterType.element;
      if (typeElement is! ClassElement) continue;

      final freezedAnnotation = typeChecker.firstAnnotationOf(
        typeElement,
        throwOnUnresolved: false,
      );

      /// Handles classes annotated with Freezed
      if (freezedAnnotation == null) continue;

      final configs = _parseConfig(freezedAnnotation);
      // copyWith not enabled, so the property is not cloneable
      if (configs.copyWith != true) continue;

      yield DeepCloneableProperty(
        name: parameter.name,
        type: type!,
        nullable: parameter.type.isNullable,
        typeName: typeElement.name,
        genericParameters: GenericsParameterTemplate(
          (parameter.type as InterfaceType).typeArguments
              .map((e) => e.getDisplayString())
              .toList(),
        ),
      );
    }
  }

  Iterable<DeepCloneableProperty> _getCommonDeepCloneableProperties(
    List<ConstructorDetails> constructors,
    PropertyList commonProperties,
  ) sync* {
    for (final commonProperty in commonProperties.cloneableProperties) {
      final commonGetter = commonProperties.readableProperties.firstWhereOrNull(
        (e) => e.name == commonProperty.name,
      );
      final deepCopyProperty = constructors.firstOrNull?.deepCloneableProperties
          .firstWhereOrNull((e) => e.name == commonProperty.name);

      if (deepCopyProperty == null || commonGetter == null) continue;

      yield deepCopyProperty.copyWith(
        nullable:
            deepCopyProperty.nullable ||
            commonProperty.type.isNullable ||
            commonGetter.type.isNullable,
      );
    }
  }

  Freezed _parseConfig(DartObject annotation) {
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
      genericArgumentFactories: annotation.decodeField(
        'genericArgumentFactories',
        decode: (obj) => obj.toBoolValue()!,
        orElse: () => _buildYamlConfigs.genericArgumentFactories,
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

  Iterable<AssertTemplate> _parseAsserts(
    ConstructorDeclaration constructor,
  ) sync* {
    for (final meta in const TypeChecker.fromRuntime(
      Assert,
    ).annotationsOf(constructor.declaredElement!)) {
      yield AssertTemplate(
        eval: meta.getField('eval')!.toStringValue(),
        message: meta.getField('message')!.toStringValue(),
      );
    }
  }

  Iterable<Object> _generateForAll(Library globalData) sync* {
    yield r'T _$identity<T>(T value) => value;';
  }

  @override
  Iterable<Object> generateAll(
    List<CompilationUnit> units,
    List<AnnotationMeta> annotations,
  ) sync* {
    if (annotations.isEmpty) return;

    if (!format) yield '// dart format off';

    final library = Library.from(units);
    for (final value in _generateForAll(library)) {
      yield value;
    }

    final userDefinedClasses = Class.parseAll(
      units,
      annotations,
      library,
      globalConfigs: _buildYamlConfigs,
    );

    for (final data in userDefinedClasses) {
      for (final value in _generateForData(library, data)) {
        yield value;
      }
    }

    if (!format) yield '// dart format on';
  }

  Iterable<Object> _generateForData(Library globalData, Class data) sync* {
    if (data.options.fromJson) yield FromJson(data);

    final commonCopyWith = data.options.annotation.copyWith ?? true
        ? CopyWith(
            parents: data.parents,
            clonedClassName: data.name,
            readableProperties: data.properties.readableProperties,
            cloneableProperties: data.properties.cloneableProperties,
            deepCloneableProperties: _getCommonDeepCloneableProperties(
              data.constructors,
              data.properties,
            ).toList(),
            genericsDefinition: data.genericsDefinitionTemplate,
            genericsParameter: data.genericsParameterTemplate,
            data: data,
          )
        : null;

    yield Abstract(
      data: data,
      copyWith: commonCopyWith,
      commonProperties: data.properties.readableProperties,
      globalData: globalData,
    );

    for (final constructor in data.constructors) {
      yield Concrete(
        data: data,
        constructor: constructor,
        commonProperties: data.properties.readableProperties,
        globalData: globalData,
        copyWith:
            data.options.annotation.copyWith ??
                constructor.parameters.allParameters.isNotEmpty
            ? CopyWith(
                parents: {},
                clonedClassName: constructor.redirectedName,
                cloneableProperties: constructor.properties.toList(),
                readableProperties: constructor.properties
                    .where((e) => e.isSynthetic)
                    .toList(),
                deepCloneableProperties: constructor.deepCloneableProperties,
                genericsDefinition: data.genericsDefinitionTemplate,
                genericsParameter: data.genericsParameterTemplate,
                data: data,
                parent: commonCopyWith,
              )
            : null,
      );
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
