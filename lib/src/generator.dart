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
    final defaultConstructor = element.constructors.firstWhere((e) => e.name.isEmpty, orElse: () => null);

    String generatedClassName;
    if (defaultConstructor.isFactory && defaultConstructor.redirectedConstructor == null) {
      final location = defaultConstructor.nameOffset;
      final source = defaultConstructor.source.contents.data;

      final match = redirectedConstructorName.stringMatch(source.substring(location));

      generatedClassName = match.substring(0, match.length - 1);
    }
    assert(generatedClassName != null);

    yield Concrete(
      generatedClassName,
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
      name: '_\$${element.name}',
      interface: element.name,
      properties: defaultConstructor?.parameters?.map((p) {
        return Getter(name: p.name, type: p.type?.name);
      })?.toList(),
    ).toString();
  }
}
