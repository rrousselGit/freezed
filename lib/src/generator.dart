import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

import 'templates/abstract_template.dart';
import 'templates/concrete_template.dart';
import 'templates/parameter_template.dart';

final redirectedConstructorName = RegExp('[^ =\t\n]+;');

class ImmutableGenerator extends GeneratorForAnnotation<Immutable> {
  @override
  Iterable<String> generateForAnnotatedElement(
    covariant ClassElement element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) sync* {
    yield* element.interfaces.map((e) => '// $e');

    final constructors = [
      for (final element in element.constructors)
        if (element.isFactory && _getRedirectedConstructorName(element) != null) element
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
      properties: [
        for (final property in commonProperties) Getter(name: property.name, type: property.type?.name),
      ],
    ).toString();

    for (final constructor in constructors) {
      final redirectedConstructorName = _getRedirectedConstructorName(constructor);
      if (redirectedConstructorName == null) {
        continue;
      }

      yield Concrete(
        name: redirectedConstructorName,
        interface: element.name,
        constructorName: constructor.name,
        constructorParameters: ParametersTemplate.fromParameterElements(
          constructor?.parameters ?? [],
          isAssignedToThis: true,
        ),
        superProperties: [
          for (final property in commonProperties) Property(name: property.name, type: property.type?.name)
        ],
        properties: constructor?.parameters?.map((p) {
          return Property(name: p.name, type: p.type?.name);
        })?.toList(),
      ).toString();
    }
  }
}

String _getRedirectedConstructorName(ConstructorElement constructor) {
  if (constructor.redirectedConstructor != null) {
    return null;
  }
  final location = constructor.nameOffset;
  final source = constructor.source.contents.data;

  final match = redirectedConstructorName.stringMatch(source.substring(location));

  return match.substring(0, match.length - 1);
}
