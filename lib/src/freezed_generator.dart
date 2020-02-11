import 'package:analyzer/dart/element/element.dart';
import 'package:freezed/src/templates/parameter_template.dart';
import 'package:freezed/src/templates/prototypes.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

import 'parse_generator.dart';
import 'templates/from_json_template.dart';

@immutable
class _ConstructorDetails {
  _ConstructorDetails({
    @required this.name,
    @required this.redirectedName,
    @required this.parametersTemplate,
  });

  final String name;
  final String redirectedName;
  final ParametersTemplate parametersTemplate;

  @override
  String toString() {
    return '''

    $runtimeType(
      name: $name,
      redirectedName: $redirectedName,
      parametersTemplate: $parametersTemplate,
    )
''';
  }
}

@immutable
class _Data {
  _Data({
    @required this.name,
    @required this.needsJsonSerializable,
    @required this.constructors,
    @required this.genericsDefinitionTemplate,
    @required this.genericsParameterTemplate,
  }) : assert(constructors.isEmpty);

  final String name;
  final bool needsJsonSerializable;
  final List<_ConstructorDetails> constructors;
  final GenericsDefinitionTemplate genericsDefinitionTemplate;
  final GenericsParameterTemplate genericsParameterTemplate;

  @override
  String toString() {
    return '''
$runtimeType(
  name: $name,
  needsJsonSerializable: $needsJsonSerializable,
  constructors: $constructors,
  genericsDefinitionTemplate: $genericsDefinitionTemplate,
  genericsParameterTemplate: $genericsParameterTemplate,
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
class FreezedGenerator extends ParsserGenerator<ClassElement, _GlobalData, _Data> {
  @override
  _Data parseElement(_GlobalData globalData, ClassElement element) {
    // TODO: verify _$name is mixed-in

    final constructrorsNeedsGeneration = _parseConstructorsNeedsGeneration(element);
    if (constructrorsNeedsGeneration.isEmpty) return null;

    // TODO: parse late finals with an initializer and copy-paste them to the concrete class + toString/debugFillProperties

    return _Data(
      name: element.name,
      // TODO: test can write manual fromJson ctor
      needsJsonSerializable: globalData.hasJson &&
          element.constructors.any((element) {
            return !constructrorsNeedsGeneration.contains(element) && element.isFactory && element.name == 'fromJson';
          }),
      constructors: constructrorsNeedsGeneration,
      genericsDefinitionTemplate: GenericsDefinitionTemplate(element.typeParameters),
      genericsParameterTemplate: GenericsParameterTemplate(element.typeParameters),
    );
  }

  List<_ConstructorDetails> _parseConstructorsNeedsGeneration(ClassElement element) {
    final result = <_ConstructorDetails>[];
    for (final constructor in element.constructors) {
      if (!constructor.isFactory || constructor.redirectedConstructor != null) continue;
      final redirectedName = getRedirectedConstructorName(constructor);
      if (redirectedName == null) continue;

      result.add(
        _ConstructorDetails(
          name: constructor.name,
          parametersTemplate: ParametersTemplate.fromParameterElements(constructor.parameters),
          redirectedName: redirectedName,
        ),
      );
    }
    return result;
  }

  @override
  Iterable<Object> generateForData(_GlobalData globalData, _Data data) sync* {
    yield '/*';

    yield globalData;

    yield data;

    if (globalData.hasJson && data.needsJsonSerializable) {
      // yield FromJson(
      //   name: data.name,
      //   constructors: constructors,
      //   typeParameters: element.typeParameters,
      // );
    }

    yield '*/';
  }

  @override
  Iterable<ClassElement> libraryToElements(LibraryReader library) {
    return library.classes.where((e) {
      return e.hasSealed || e.metadata.any((element) => element.isImmutable);
    });
  }

  @override
  _GlobalData parseGlobalData(LibraryReader library) {
    return _GlobalData(
      hasDiagnostics: _libraryHasElement(
        library.element,
        '/flutter/',
        (element) => element.displayName.contains('Diagnosticable') && element.kind == ElementKind.CLASS,
      ),
      hasJson: _libraryHasElement(
        library.element,
        '/json_annotation/',
        (element) => element.displayName.contains('JsonSerializable') && element.kind == ElementKind.CLASS,
      ),
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
}
