import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:freezed/src/templates/from_json_template.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

import 'templates/abstract_template.dart';
import 'templates/concrete_template.dart';
import 'templates/parameter_template.dart';
import 'templates/prototypes.dart';

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

class FreezedGenerator extends GeneratorForAnnotation<Immutable> {
  bool hasDiagnosticable = false;
  bool hasJson = false;

  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    hasDiagnosticable = library.element.importedLibraries.any(_libraryHasDiagnosticable);
    hasJson = library.element.importedLibraries.any(_libraryHasJson);
    return super.generate(library, buildStep);
  }

  @override
  Iterable<String> generateForAnnotatedElement(
    covariant ClassElement element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) sync* {
    if (!_implementsGeneratedInterface(element)) return;

    var hasJson = false;

    final constructors = [
      for (final element in element.constructors)
        if (element.isFactory && element.name != 'fromJson' && getRedirectedConstructorName(element) != null) element
    ];

    if (constructors.isEmpty) return;

    if (element.constructors.any((element) => element.name == 'fromJson')) {
      hasJson = this.hasJson;
      if (hasJson) {
        // yield FromJson(
        //   name: element.name,
        //   constructors: constructors,
        //   typeParameters: element.typeParameters,
        // ).toString();
      }
    }

    final commonProperties = constructors.first.parameters.where((parameter) {
      return constructors.every((constructor) {
        return constructor.parameters.any((p) {
          return p.name == parameter.name && p.type == parameter.type;
        });
      });
    }).toList();

    // yield Abstract(
    //   name: '_\$${element.name}',
    //   interface: element.name,
    //   typeParameters: element.typeParameters,
    //   hasJson: hasJson,
    //   allConstructors: constructors,
    //   properties: [
    //     for (final property in commonProperties) Getter(name: property.name, type: property.type?.getDisplayString()),
    //   ],
    // ).toString();

    for (final constructor in constructors) {
      final redirectedConstructorName = getRedirectedConstructorName(constructor);

      // yield Concrete(
      //   name: redirectedConstructorName,
      //   allConstructors: constructors,
      //   typeParameters: element.typeParameters,
      //   hasDiagnosticable: hasDiagnosticable,
      //   hasJson: hasJson,
      //   interface: element.name,
      //   constructorName: constructor.name,
      //   constructorParameters: ParametersTemplate.fromParameterElements(
      //     constructor?.parameters ?? [],
      //     isAssignedToThis: true,
      //   ),
      //   superProperties: [
      //     for (final property in commonProperties)
      //       Property(name: property.name, type: property.type?.getDisplayString())
      //   ],
      //   properties: constructor?.parameters?.map((p) {
      //     return Property(name: p.name, type: p.type?.getDisplayString());
      //   })?.toList(),
      // ).toString();
    }
  }
}

bool _implementsGeneratedInterface(ClassElement classElement) {
  return classElement.fields.isEmpty;
}
