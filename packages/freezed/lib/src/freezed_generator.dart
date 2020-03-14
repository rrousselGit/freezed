import 'package:analyzer/dart/element/element.dart';
import 'package:freezed/src/templates/copy_with.dart';
import 'package:freezed/src/templates/parameter_template.dart';
import 'package:freezed/src/templates/prototypes.dart';
import 'package:freezed/src/templates/tear_off.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

import 'parse_generator.dart';
import 'templates/abstract_template.dart';
import 'templates/concrete_template.dart';
import 'templates/from_json_template.dart';

/// A generated property that has for type a class generated using Freezed
///
/// This allows Freezed to support deep copy of the object.
/// This does include primitives like [int] and [List].
@immutable
class CloneableProperty {
  CloneableProperty({
    @required this.name,
    @required this.type,
    @required this.children,
    @required this.associatedData,
  });

  final String name;
  final String type;
  final List<CloneableProperty> children;
  final Data associatedData;

  @override
  String toString() {
    return '''
$runtimeType(
  name: $name,
  type: $type,
  children: $children,
  associatedData: $associatedData,
)
''';
  }
}

/// The informations of a specific constructor of a class tagged with `@freezed`.
///
/// This only includes constructors where Freezed needs to generate something.
@immutable
class ConstructorDetails {
  ConstructorDetails({
    @required this.name,
    @required this.isConst,
    @required this.isDefault,
    @required this.redirectedName,
    @required this.parameters,
    @required this.impliedProperties,
    @required this.fullName,
    @required this.decorators,
    @required this.hasJsonSerializable,
    @required this.cloneableProperties,
  });

  final String name;
  final bool isConst;
  final String redirectedName;
  final ParametersTemplate parameters;
  final List<Property> impliedProperties;
  final bool isDefault;
  final bool hasJsonSerializable;
  final String fullName;
  final List<String> decorators;
  final List<CloneableProperty> cloneableProperties;

  String get callbackName => constructorNameToCallbackName(name);

  @override
  String toString() {
    return '''
$runtimeType(
  name: $name,
  isConst: $isConst,
  isDefault: $isDefault,
  redirectedName: $redirectedName,
  parameters: $parameters,
  impliedProperties: $impliedProperties,
  fullName: $fullName,
  decorators: $decorators,
  hasJsonSerializable: $hasJsonSerializable,
  cloneableProperties: $cloneableProperties,
)
''';
  }
}

@immutable
class Data {
  Data({
    @required this.name,
    @required this.lateGetters,
    @required this.needsJsonSerializable,
    @required this.constructors,
    @required this.genericsDefinitionTemplate,
    @required this.genericsParameterTemplate,
    @required this.commonProperties,
    @required this.commonCloneableProperties,
  }) : assert(constructors.isNotEmpty);

  final String name;
  final List<LateGetter> lateGetters;
  final bool needsJsonSerializable;
  final List<ConstructorDetails> constructors;
  final GenericsDefinitionTemplate genericsDefinitionTemplate;
  final GenericsParameterTemplate genericsParameterTemplate;
  final List<Property> commonProperties;
  final List<CloneableProperty> commonCloneableProperties;

  @override
  String toString() {
    return '''
$runtimeType(
  name: $name,
  lateGetters: $lateGetters,
  needsJsonSerializable: $needsJsonSerializable,
  constructors: $constructors,
  genericsDefinitionTemplate: $genericsDefinitionTemplate,
  genericsParameterTemplate: $genericsParameterTemplate,
  commonProperties: $commonProperties,
  commonCloneableProperties: $commonCloneableProperties,
)''';
  }
}

@immutable
class _GlobalData {
  _GlobalData({
    @required this.hasDiagnostics,
    @required this.hasJson,
  });

  final bool hasJson;
  final bool hasDiagnostics;

  @override
  String toString() {
    return '''
$runtimeType(
  hasJson: $hasJson,
  hasDiagnostics: $hasDiagnostics,
)''';
  }
}

@immutable
class FreezedGenerator extends ParserGenerator<_GlobalData, Data, Freezed> {
  final _computeElementDataCache = <ClassElement, Data>{};

  Data _computeElementDataFor(ParameterElement parameter) {
    final parameterTypeElement = parameter?.type?.element;
    if (parameterTypeElement == null) return null;
    if (parameterTypeElement is! ClassElement) return null;

    final classElement = parameterTypeElement as ClassElement;

    return _computeElementDataCache.putIfAbsent(classElement, () {
      if (!typeChecker.hasAnnotationOf(classElement)) return null;
      return parseElement(
        _GlobalData(hasDiagnostics: false, hasJson: false),
        classElement,
      );
    });
  }

  @override
  Data parseElement(_GlobalData globalData, Element rawElement) {
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

    final lateGetters = <LateGetter>[];

    for (final field in element.fields) {
      if (field.isStatic) continue;
      if (field.getter != null && !field.getter.isSynthetic && field.hasLate) {
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

    // TODO: verify _$name is mixed-in

    final constructorsNeedsGeneration =
        _parseConstructorsNeedsGeneration(element);
    if (constructorsNeedsGeneration.isEmpty) {
      throw InvalidGenerationSourceError(
        'Marked ${element.name} with @freezed, but freezed has nothing to generate',
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

    return Data(
      name: element.name,
      lateGetters: lateGetters,
      commonCloneableProperties: [
        for (final cloneableProperty
            in constructorsNeedsGeneration.first.cloneableProperties)
          for (final commonParameter in commonParameters)
            if (cloneableProperty.name == commonParameter.name)
              cloneableProperty,
      ],
      // TODO: test can write manual fromJson ctor
      commonProperties: commonParameters
          .map((p) => Property(
                decorators: p.decorators,
                name: p.name,
                type: p.type,
                nullable: p.nullable,
                defaultValueSource: p.defaultValueSource,
                // TODO: support hasJsonKey
                hasJsonKey: false,
              ))
          .toList(),
      needsJsonSerializable: globalData.hasJson &&
          element.constructors.any((element) {
            return element.isFactory && element.name == 'fromJson';
          }),
      constructors: constructorsNeedsGeneration,
      genericsDefinitionTemplate:
          GenericsDefinitionTemplate.fromGenericElement(element.typeParameters),
      genericsParameterTemplate:
          GenericsParameterTemplate.fromGenericElement(element.typeParameters),
    );
  }

  List<ConstructorDetails> _parseConstructorsNeedsGeneration(
      ClassElement element) {
    final result = <ConstructorDetails>[];
    for (final constructor in element.constructors) {
      if (!constructor.isFactory || constructor.name == 'fromJson') {
        continue;
      }
      final redirectedName = getRedirectedConstructorName(constructor);
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
          final data = _computeElementDataFor(parameter);
          if (data == null) continue;
          yield CloneableProperty(
            name: parameter.name,
            type: parseTypeSource(parameter),
            children: data.commonCloneableProperties,
            associatedData: data,
          );
        }
      }

      result.add(
        ConstructorDetails(
          name: constructor.name,
          isConst: constructor.isConst,
          fullName: fullName,
          impliedProperties: [
            for (final parameter in constructor.parameters)
              Property.fromParameter(parameter),
          ],
          decorators: constructor.metadata.map((e) => e.toSource()).toList(),
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

  @override
  Iterable<Object> generateForAll(_GlobalData globalData) sync* {
    yield r'T _$identity<T>(T value) => value;';
  }

  @override
  Iterable<Object> generateForData(_GlobalData globalData, Data data) sync* {
    if (globalData.hasJson && data.needsJsonSerializable) {
      yield FromJson(
        name: data.name,
        constructors: data.constructors,
        genericParameters: data.genericsParameterTemplate,
        genericDefinitions: data.genericsDefinitionTemplate,
      );
    }

    yield TearOff(
      name: data.name,
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
  _GlobalData parseGlobalData(LibraryElement library) {
    return _GlobalData(
      hasJson: library.importedLibraries.any(_libraryHasJson),
      hasDiagnostics: library.importedLibraries.any(_libraryHasDiagnosticable),
    );
  }

  bool _libraryHasElement(
    LibraryElement library,
    String pathStartsWith,
    bool Function(Element) matcher,
  ) {
    if (library.librarySource.fullName.startsWith(pathStartsWith)) {
      for (final element in library.topLevelElements) {
        if (matcher(element)) {
          return true;
        }
      }
    }

    return library.exportedLibraries.any((library) {
      return library.librarySource.fullName.startsWith(pathStartsWith) &&
          _libraryHasElement(library, pathStartsWith, matcher);
    });
  }

  bool _libraryHasDiagnosticable(LibraryElement library) {
    return _libraryHasElement(
      library,
      '/flutter/',
      (element) =>
          element.displayName.contains('Diagnosticable') &&
          element.kind == ElementKind.CLASS,
    );
  }

  bool _libraryHasJson(LibraryElement library) {
    return _libraryHasElement(
      library,
      '/json_annotation/',
      (element) =>
          element.displayName.contains('JsonSerializable') &&
          element.kind == ElementKind.CLASS,
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

extension on Element {
  bool get hasJsonSerializable {
    return const TypeChecker.fromRuntime(JsonSerializable).hasAnnotationOf(
      this,
      throwOnUnresolved: false,
    );
  }
}

class LateGetter {
  final String type;
  final String name;
  final List<String> decorators;
  final String source;

  LateGetter({
    @required this.type,
    @required this.name,
    @required this.decorators,
    @required this.source,
  });

  @override
  String toString() {
    return '''
bool _did$name = false;
${type ?? 'dynamic'} _$name;

@override
${decorators.join()}
${type ?? 'dynamic'} get $name {
  if (_did$name == false) {
    _did$name = true;
    _$name = $source;
  }
  return _$name;
}''';
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
