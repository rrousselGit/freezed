import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

import 'templates/abstract_template.dart';
import 'templates/concrete_template.dart';
import 'templates/parameter_template.dart';
import 'templates/prototypes.dart';

bool _libraryHasDiagnosticable(LibraryElement library) {
  if (library.librarySource.fullName.startsWith('/flutter/')) {
    for (final element in library.topLevelElements) {
      if (element.displayName.contains('Diagnosticable') && element.kind == ElementKind.CLASS) {
        return true;
      }
    }
  }

  return library.exportedLibraries.any((library) {
    return library.librarySource.fullName.startsWith('/flutter/') && _libraryHasDiagnosticable(library);
  });
}

class FreezedGenerator extends GeneratorForAnnotation<Immutable> {
  bool hasDiagnosticable = false;

  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    hasDiagnosticable = library.element.importedLibraries.any(_libraryHasDiagnosticable);
    return super.generate(library, buildStep);
  }

  @override
  Iterable<String> generateForAnnotatedElement(
    covariant ClassElement element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) sync* {
    final constructors = [
      for (final element in element.constructors)
        if (element.isFactory && getRedirectedConstructorName(element) != null) element
    ];

    if (constructors.isEmpty) return;

    final commonProperties = constructors.first.parameters.where((parameter) {
      return constructors.every((constructor) {
        return constructor.parameters.any((p) {
          return p.name == parameter.name && p.type == parameter.type;
        });
      });
    }).toList();

    yield Abstract(
      name: '_\$${element.name}',
      interface: element.name,
      typeParameters: element.typeParameters,
      allConstructors: constructors,
      properties: [
        for (final property in commonProperties) Getter(name: property.name, type: property.type?.getDisplayString()),
      ],
    ).toString();

    for (final constructor in constructors) {
      final redirectedConstructorName = getRedirectedConstructorName(constructor);
      if (redirectedConstructorName == null) {
        continue;
      }

      if (redirectedConstructorName == 'itionalMixedParam') {
        print(
          redirectedConstructorNameRegexp
              .stringMatch(constructor.source.contents.data.substring(constructor.nameOffset)),
        );
      }

      yield Concrete(
        name: redirectedConstructorName,
        allConstructors: constructors,
        typeParameters: element.typeParameters,
        hasDiagnosticable: hasDiagnosticable,
        interface: element.name,
        constructorName: constructor.name,
        constructorParameters: ParametersTemplate.fromParameterElements(
          constructor?.parameters ?? [],
          isAssignedToThis: true,
        ),
        superProperties: [
          for (final property in commonProperties)
            Property(name: property.name, type: property.type?.getDisplayString())
        ],
        properties: constructor?.parameters?.map((p) {
          return Property(name: p.name, type: p.type?.getDisplayString());
        })?.toList(),
      ).toString();
    }
  }
}
