import 'package:analyzer/dart/element/element.dart';
import 'package:freezed/src/templates/parameter_template.dart';
import 'package:freezed/src/templates/prototypes.dart';
import 'package:meta/meta.dart';

import 'parse_generator.dart';
import 'templates/abstract_template.dart';
import 'templates/concrete_template.dart';
import 'templates/from_json_template.dart';

@immutable
class ConstructorDetails {
  ConstructorDetails({
    @required this.name,
    @required this.isDefault,
    @required this.redirectedName,
    @required this.parameters,
    @required this.impliedProperties,
    @required this.fullName,
  });

  final String name;
  final String redirectedName;
  final ParametersTemplate parameters;
  final List<Property> impliedProperties;
  final bool isDefault;
  final String fullName;

  String get callbackName => constructorNameToCallbackName(name);

  @override
  String toString() {
    return '''

    $runtimeType(
      name: $name,
      isDefault: $isDefault,
      redirectedName: $redirectedName,
      parameters: $parameters,
      impliedProperties: $impliedProperties,
      fullName: $fullName,
    )
''';
  }
}

@immutable
class Data {
  Data({
    @required this.name,
    @required this.needsJsonSerializable,
    @required this.constructors,
    @required this.genericsDefinitionTemplate,
    @required this.genericsParameterTemplate,
    @required this.commonProperties,
  }) : assert(constructors.isEmpty);

  final String name;
  final bool needsJsonSerializable;
  final List<ConstructorDetails> constructors;
  final GenericsDefinitionTemplate genericsDefinitionTemplate;
  final GenericsParameterTemplate genericsParameterTemplate;
  final List<Property> commonProperties;

  @override
  String toString() {
    return '''
$runtimeType(
  name: $name,
  needsJsonSerializable: $needsJsonSerializable,
  constructors: $constructors,
  genericsDefinitionTemplate: $genericsDefinitionTemplate,
  genericsParameterTemplate: $genericsParameterTemplate,
  commonProperties: $commonProperties,
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
class FreezedGenerator extends ParsserGenerator<ClassElement, _GlobalData, Data, Immutable> {
  @override
  Data parseElement(_GlobalData globalData, ClassElement element) {
    // TODO: verify _$name is mixed-in

    final constructrorsNeedsGeneration = _parseConstructorsNeedsGeneration(element);
    if (constructrorsNeedsGeneration.isEmpty) return null;

    // TODO: parse late finals with an initializer and copy-paste them to the concrete class + toString/debugFillProperties

    return Data(
      name: element.name,
      // TODO: test can write manual fromJson ctor
      commonProperties: element.constructors.first.parameters
          .where((parameter) {
            return element.constructors.every((constructor) {
              return constructor.parameters.any((p) {
                return p.name == parameter.name && p.type == parameter.type;
              });
            });
          })
          .map((property) => Property.fromParameter(property))
          .toList(),
      needsJsonSerializable: globalData.hasJson &&
          element.constructors.any((element) {
            return element.isFactory && element.name == 'fromJson';
          }),
      constructors: constructrorsNeedsGeneration,
      genericsDefinitionTemplate: GenericsDefinitionTemplate(element.typeParameters),
      genericsParameterTemplate: GenericsParameterTemplate(element.typeParameters),
    );
  }

  List<ConstructorDetails> _parseConstructorsNeedsGeneration(ClassElement element) {
    final result = <ConstructorDetails>[];
    for (final constructor in element.constructors) {
      if (!constructor.isFactory || constructor.redirectedConstructor != null || constructor.name == 'fromJson') {
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

      result.add(
        ConstructorDetails(
          name: constructor.name,
          fullName: fullName,
          impliedProperties: [
            for (final parameter in constructor.parameters)
              Property(name: parameter.name, type: parameter.type?.getDisplayString())
          ],
          isDefault: isDefaultConstructor(constructor),
          parameters: ParametersTemplate.fromParameterElements(constructor.parameters),
          redirectedName: redirectedName,
        ),
      );
    }
    return result;
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

    yield Abstract(
      name: data.name,
      genericsDefinition: data.genericsDefinitionTemplate,
      genericsParameter: data.genericsParameterTemplate,
      shouldGenerateJson: globalData.hasJson && data.needsJsonSerializable,
      abstractProperties: data.commonProperties.asGetters(),
      allConstructors: data.constructors,
    );

    for (final constructor in data.constructors) {
      yield Concrete(
        name: data.name,
        hasDiagnosticable: globalData.hasDiagnostics,
        shouldGenerateJson: globalData.hasJson && data.needsJsonSerializable,
        constructor: constructor,
        allConstructors: data.constructors,
        commonProperties: data.commonProperties,
        genericsDefinition: data.genericsDefinitionTemplate,
        genericsParameter: data.genericsParameterTemplate,
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

  bool _libraryHasElement(LibraryElement library, String pathStartsWith, bool matcher(Element element)) {
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
      (element) => element.displayName.contains('Diagnosticable') && element.kind == ElementKind.CLASS,
    );
  }

  bool _libraryHasJson(LibraryElement library) {
    return _libraryHasElement(
      library,
      '/json_annotation/',
      (element) => element.displayName.contains('JsonSerializable') && element.kind == ElementKind.CLASS,
    );
  }
}
