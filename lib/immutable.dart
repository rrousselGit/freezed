import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:immutable/concrete_template.dart';
import 'package:source_gen/source_gen.dart';
import 'abstract_template.dart';
import 'parameter_template.dart';

/// Builds generators for `build_runner` to run
Builder immutable(BuilderOptions options) {
  return SharedPartBuilder([ImmutableGenerator()], 'immutable');
}

class ImmutableGenerator extends GeneratorForAnnotation<Immutable> {
  @override
  Iterable<String> generateForAnnotatedElement(
    covariant ClassElement element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) sync* {
    final defaultConstructor = element.constructors
        .firstWhere((e) => e.name.isEmpty, orElse: () => null);
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
      '_${element.name}Base',
      defaultConstructor?.parameters?.map((p) {
        return Getter(name: p.name, type: p.type?.name);
      })?.toList(),
    ).toString();
  }
}

class Immutable {
  const Immutable();
}
