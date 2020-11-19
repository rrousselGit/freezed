import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:freezed/src/templates/assert.dart';
import 'package:freezed/src/templates/copy_with.dart';
import 'package:freezed/src/templates/parameter_template.dart';
import 'package:freezed/src/templates/properties.dart';
import 'package:freezed/src/templates/prototypes.dart';
import 'package:freezed/src/templates/tear_off.dart';
import 'package:freezed/src/tools/recursive_import_locator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

import 'models.dart';
import 'parse_generator.dart';
import 'templates/abstract_template.dart';
import 'templates/concrete_template.dart';
import 'templates/from_json_template.dart';

@immutable
class FreezedGenerator extends ParserGenerator<GlobalData, Data, Freezed> {
  FreezedGenerator(this.configs);

  final Map<String, Object> configs;
  final _computeElementDataCache = <ClassElement, Data>{};
  final _parsedElementCheckSet = <ClassElement>{};

  Data _computeElementDataFor(ParameterElement parameter) {
    final parameterTypeElement = parameter?.type?.element;
    if (parameterTypeElement == null) return null;
    if (parameterTypeElement is! ClassElement) return null;

    final classElement = parameterTypeElement as ClassElement;

    return _computeElementDataCache.putIfAbsent(classElement, () {
      if (!typeChecker.hasAnnotationOf(classElement)) return null;
      if (_parsedElementCheckSet.contains(classElement)) return null;
      _parsedElementCheckSet.add(classElement);
      return parseElement(
        GlobalData(hasDiagnostics: false, hasJson: false),
        classElement,
      );
    });
  }

  @override
  Data parseElement(GlobalData globalData, Element rawElement) {
    final configs = _parseConfig(rawElement);

    if (rawElement is! ClassElement) {
      throw InvalidGenerationSourceError(
        '@freezed can only be applied on classes. Failing element: ${rawElement.name}',
        element: rawElement,
      );
    }
    final element = rawElement as ClassElement;

    if (!element.isAbstract) {
      throw InvalidGenerationSourceError(
        'Marked ${element.name} with @freezed, but the class is not abstract',
        element: rawElement,
      );
    }

    // Invalid constructors check
    for (final constructor in element.constructors) {
      if (constructor.isFactory) continue;
      if (constructor.name != '_' || constructor.parameters.isNotEmpty) {
        throw InvalidGenerationSourceError(
          'Classes decorated with @freezed can only have a single non-factory'
          ', without parameters, and named MyClass._()',
          element: element,
        );
      }
    }

    // TODO: verify _$name is mixed-in

    final constructorsNeedsGeneration =
        _parseConstructorsNeedsGeneration(element);

    if (constructorsNeedsGeneration.isEmpty) {
      throw InvalidGenerationSourceError(
        'Marked ${element.name} with @freezed, but freezed has nothing to generate',
        element: rawElement,
      );
    }

    if (constructorsNeedsGeneration.length > 1 &&
        constructorsNeedsGeneration.any((c) => c.name.startsWith('_'))) {
      throw InvalidGenerationSourceError(
        'A freezed union cannot have private constructors',
        element: rawElement,
      );
    }

    final shouldUseExtends = element.constructors.any((ctor) {
      return ctor.name == '_' && !ctor.isFactory && !ctor.isAbstract;
    });

    final lateGetters = <LateGetter>[];

    for (final field in element.fields) {
      if (field.isStatic) continue;
      if (field.setter != null) {
        throw InvalidGenerationSourceError(
          'Classes decorated with @freezed cannot have mutable properties',
          element: element,
        );
      }
      if (field.getter != null && !field.getter.isSynthetic) {
        if (!field.hasLate) {
          if (!shouldUseExtends) {
            throw InvalidGenerationSourceError(
              'Getters not decorated with @late requires a MyClass._() constructor',
              element: rawElement,
            );
          }
          continue;
        }
        if (element.constructors.any((element) => element.isConst)) {
          throw InvalidGenerationSourceError(
            '@late cannot be used in combination with const constructors',
            element: rawElement,
          );
        }
        final source = parseLateGetterSource(
          field.getter.source.contents.data.substring(
            field.getter.nameOffset + field.getter.nameLength,
          ),
        );

        if (source == null) {
          throw InvalidGenerationSourceError(
            '@late can only be used on getters with using =>',
            element: rawElement,
          );
        }
        lateGetters.add(
          LateGetter(
            type: parseTypeSource(field),
            name: field.name,
            decorators: field.metadata.map((e) => e.toSource()).toList(),
            source: source,
          ),
        );
        continue;
      }

      throw InvalidGenerationSourceError(
        '@freezed cannot be used on classes with unimplemented getters',
        element: rawElement,
      );
    }

    // TODO: parse late finals with an initializer and copy-paste them to the concrete class + toString/debugFillProperties

    final commonParameters = constructorsNeedsGeneration
        .first.parameters.allParameters
        .where((parameter) {
      return constructorsNeedsGeneration.every((constructor) {
        return constructor.parameters.allParameters.any((p) {
          return p.name == parameter.name && p.type == parameter.type;
        });
      });
    }).toList();

    final needsJsonSerializable = globalData.hasJson &&
        element.constructors.any((element) {
          if (element.isFactory && element.name == 'fromJson') {
            final ast = element.session
                .getParsedLibraryByElement(element.library)
                .getElementDeclaration(element)
                ?.node;
            return ast.endToken.stringValue == ';';
          }
          return false;
        });

    return Data(
      name: element.name,
      shouldUseExtends: shouldUseExtends,
      lateGetters: lateGetters,
      commonCloneableProperties: [
        for (final cloneableProperty
            in constructorsNeedsGeneration.first.cloneableProperties)
          for (final commonParameter in commonParameters)
            if (cloneableProperty.name == commonParameter.name)
              cloneableProperty,
      ],
      // TODO: test can write manual fromJson ctor
      commonProperties: [
        for (final commonParameter in commonParameters)
          Property(
            decorators: commonParameter.decorators,
            name: commonParameter.name,
            doc: commonParameter.doc,
            type: commonParameter.type,
            nullable: commonParameter.nullable,
            defaultValueSource: commonParameter.defaultValueSource,
            // TODO: support hasJsonKey
            hasJsonKey: false,
          ),
      ],
      needsJsonSerializable: needsJsonSerializable,
      unionKey: configs.unionKey,
      constructors: constructorsNeedsGeneration,
      genericsDefinitionTemplate:
          GenericsDefinitionTemplate.fromGenericElement(element.typeParameters),
      genericsParameterTemplate:
          GenericsParameterTemplate.fromGenericElement(element.typeParameters),
    );
  }

  List<ConstructorDetails> _parseConstructorsNeedsGeneration(
    ClassElement element,
  ) {
    final result = <ConstructorDetails>[];
    for (final constructor in element.constructors) {
      if (!constructor.isFactory || constructor.name == 'fromJson') {
        continue;
      }
      final location = constructor.nameOffset;
      final source = constructor.source.contents.data;

      final redirectedName =
          getRedirectedConstructorName(source.substring(location));
      if (redirectedName == null) continue;

      var generics = element.typeParameters.map((e) {
        return '\$${e.name}';
      }).join(', ');
      if (generics.isNotEmpty) {
        generics = '<$generics>';
      }

      final fullName = constructor.name == null || constructor.name.isEmpty
          ? '${element.name}$generics'
          : '${element.name}$generics.${constructor.name}';

      Iterable<CloneableProperty> cloneableProperties() sync* {
        for (final parameter in constructor.parameters) {
          final type = parseTypeSource(parameter);
          final data = _computeElementDataFor(parameter);
          if (data == null) continue;

          yield CloneableProperty(
            name: parameter.name,
            type: type,
            children: data.commonCloneableProperties,
            associatedData: data,
            genericParameters: GenericsParameterTemplate(
              (parameter.type as InterfaceType)
                  .typeArguments
                  .map((e) => e.getDisplayString(withNullability: false))
                  .toList(),
            ),
          );
        }
      }

      MethodElement userDefinedToString;
      for (final type in [
        element,
        ...element.allSupertypes
            .map((e) => e.element)
            .where((e) => !e.isDartCoreObject)
      ]) {
        for (final method in type.methods) {
          if (method.name == 'toString') {
            userDefinedToString = method;
            break;
          }
        }
      }

      Iterable<String> withDecorationTypes() sync* {
        for (final metadata in constructor.metadata) {
          if (!metadata.isWith) continue;
          final object = metadata.computeConstantValue();
          var type = object.getField('type');
          if (type.isNull) {
            type = object.getField('stringType');
            yield type.toStringValue();
          } else {
            yield type.toTypeValue().getDisplayString(withNullability: false);
          }
        }
      }

      Iterable<String> implementsDecorationTypes() sync* {
        for (final metadata in constructor.metadata) {
          if (!metadata.isImplements) continue;
          final object = metadata.computeConstantValue();
          var type = object.getField('type');
          if (type.isNull) {
            type = object.getField('stringType');
            yield type.toStringValue();
          } else {
            yield type.toTypeValue().getDisplayString(withNullability: false);
          }
        }
      }

      result.add(
        ConstructorDetails(
          asserts: _parseAsserts(constructor).toList(),
          name: constructor.name,
          canOverrideToString: userDefinedToString == null,
          isConst: constructor.isConst,
          fullName: fullName,
          impliedProperties: [
            for (final parameter in constructor.parameters)
              Property.fromParameter(parameter),
          ],
          decorators: constructor.metadata
              .map((e) => e.toSource())
              .where((e) => !e.startsWith('@Assert('))
              .toList(),
          withDecorators: withDecorationTypes().toSet().toList(),
          implementsDecorators: implementsDecorationTypes().toSet().toList(),
          isDefault: isDefaultConstructor(constructor),
          hasJsonSerializable: constructor.hasJsonSerializable,
          cloneableProperties: cloneableProperties().toList(),
          parameters:
              ParametersTemplate.fromParameterElements(constructor.parameters),
          redirectedName: redirectedName,
        ),
      );
    }
    return result;
  }

  Freezed _parseConfig(Element element) {
    final annotation = const TypeChecker.fromRuntime(Freezed)
        .firstAnnotationOf(element, throwOnUnresolved: false);

    final rawUnionKey = annotation.getField('unionKey')?.toStringValue() ??
        configs['union_key']?.toString() ??
        'runtimeType';

    return Freezed(
      unionKey: rawUnionKey.replaceAll("'", r"\'").replaceAll(r'$', r'\$'),
    );
  }

  Iterable<AssertTemplate> _parseAsserts(ConstructorElement constructor) sync* {
    for (final meta
        in const TypeChecker.fromRuntime(Assert).annotationsOf(constructor)) {
      yield AssertTemplate(
        eval: meta.getField('eval').toStringValue(),
        message: meta.getField('message').toStringValue(),
      );
    }
  }

  @override
  Iterable<Object> generateForAll(GlobalData globalData) sync* {
    yield r'T _$identity<T>(T value) => value;';
  }

  @override
  Iterable<Object> generateForData(
    GlobalData globalData,
    Data data,
  ) sync* {
    if (globalData.hasJson && data.needsJsonSerializable) {
      yield FromJson(
        name: data.name,
        unionKey: data.unionKey,
        constructors: data.constructors,
        genericParameters: data.genericsParameterTemplate,
        genericDefinitions: data.genericsDefinitionTemplate,
      );
    }

    yield TearOff(
      name: data.name,
      serializable: globalData.hasJson && data.needsJsonSerializable,
      genericsParameter: data.genericsParameterTemplate,
      genericsDefinition: data.genericsDefinitionTemplate,
      allConstructors: data.constructors,
    );

    final commonCopyWith = CopyWith(
      clonedClassName: data.name,
      cloneableProperties: data.commonCloneableProperties,
      genericsDefinition: data.genericsDefinitionTemplate,
      genericsParameter: data.genericsParameterTemplate,
      allProperties: data.commonProperties,
    );
    yield Abstract(
      name: data.name,
      genericsDefinition: data.genericsDefinitionTemplate,
      genericsParameter: data.genericsParameterTemplate,
      shouldGenerateJson: globalData.hasJson && data.needsJsonSerializable,
      abstractProperties: data.commonProperties.asGetters(),
      allConstructors: data.constructors,
      copyWith: commonCopyWith,
    );

    for (final constructor in data.constructors) {
      yield Concrete(
        name: data.name,
        unionKey: data.unionKey,
        shouldUseExtends: data.shouldUseExtends,
        lateGetters: data.lateGetters,
        hasDiagnosticable: globalData.hasDiagnostics,
        shouldGenerateJson: globalData.hasJson && data.needsJsonSerializable,
        constructor: constructor,
        allConstructors: data.constructors,
        commonProperties: data.commonProperties,
        genericsDefinition: data.genericsDefinitionTemplate,
        genericsParameter: data.genericsParameterTemplate,
        copyWith: CopyWith(
          clonedClassName: constructor.redirectedName,
          cloneableProperties: constructor.cloneableProperties,
          genericsDefinition: data.genericsDefinitionTemplate,
          genericsParameter: data.genericsParameterTemplate,
          allProperties: constructor.impliedProperties,
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
}

extension on FieldElement {
  bool get hasLate {
    return TypeChecker.fromRuntime(late.runtimeType).hasAnnotationOf(
      getter,
      throwOnUnresolved: false,
    );
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

String parseLateGetterSource(String source) {
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
