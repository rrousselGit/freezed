import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

import 'templates/abstract_template.dart';
import 'templates/concrete_template.dart';
import 'templates/parameter_template.dart';

class ImmutableGenerator extends GeneratorForAnnotation<Immutable> {
  @override
  Iterable<String> generateForAnnotatedElement(
    covariant ClassElement element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) sync* {
    File.fromUri(Uri.parse('./log.txt')).writeAsStringSync('hello world');
    final defaultConstructor = element.constructors.firstWhere((e) => e.name.isEmpty, orElse: () => null);

    yield Concrete(
      '_${element.name}',
      element.name,
      ParametersTemplate.fromParameterElements(
        defaultConstructor?.parameters ?? [],
        isAssignedToThis: true,
      ),
      defaultConstructor?.parameters?.map((p) {
        return Property(name: p.name, type: p.type?.name);
      })?.toList(),
    ).toString();

    yield Abstract(
      name: '_${element.name}Base',
      interface: element.name,
      properties: defaultConstructor?.parameters?.map((p) {
        return Getter(name: p.name, type: p.type?.name);
      })?.toList(),
    ).toString();
  }
}
