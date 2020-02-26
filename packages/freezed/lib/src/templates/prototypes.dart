import 'package:analyzer/dart/element/element.dart';
import 'package:freezed/src/freezed_generator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';
import 'parameter_template.dart';

final redirectedConstructorNameRegexp =
    RegExp(r'^[^;]+?=[\s\n\t]*([^<>(){}]+?)(?:<.+?>)*?;', dotAll: true);

List<String> parseDecorators(List<ElementAnnotation> metadata) {
  return [
    for (final meta in metadata)
      if (!meta.isRequired && !meta.isDefault) meta.toSource(),
  ];
}

extension on ElementAnnotation {
  /// if the element is decorated with `@Default(value)`
  bool get isDefault {
    return const TypeChecker.fromRuntime(Default).isExactlyType(computeConstantValue().type);
  }
}

String getRedirectedConstructorName(ConstructorElement constructor) {
  final location = constructor.nameOffset;
  final source = constructor.source.contents.data;

  return redirectedConstructorNameRegexp
      .firstMatch(source.substring(location))
      ?.group(1);
}

String whenPrototype(List<ConstructorDetails> allConstructors) {
  return _whenPrototype(allConstructors,
      areCallbacksRequired: true, name: 'when');
}

String maybeWhenPrototype(List<ConstructorDetails> allConstructors) {
  return _whenPrototype(allConstructors,
      areCallbacksRequired: false, name: 'maybeWhen');
}

String mapPrototype(List<ConstructorDetails> allConstructors,
    GenericsParameterTemplate genericParameters) {
  return _mapPrototype(allConstructors, genericParameters,
      areCallbacksRequired: true, name: 'map');
}

String maybeMapPrototype(List<ConstructorDetails> allConstructors,
    GenericsParameterTemplate genericParameters) {
  return _mapPrototype(allConstructors, genericParameters,
      areCallbacksRequired: false, name: 'maybeMap');
}

String _mapPrototype(
  List<ConstructorDetails> allConstructors,
  GenericsParameterTemplate genericParameters, {
  @required bool areCallbacksRequired,
  @required String name,
}) {
  return _unionPrototype(
    allConstructors,
    areCallbacksRequired: areCallbacksRequired,
    name: name,
    ctor2parameters: (constructor) {
      return ParametersTemplate([
        Parameter(
          name: 'value',
          type: '${constructor.redirectedName}$genericParameters',
          isRequired: false,
          decorators: const [],
          nullable: false,
          defaultValueSource: '',
        ),
      ]);
    },
  );
}

String _whenPrototype(
  List<ConstructorDetails> allConstructors, {
  @required bool areCallbacksRequired,
  @required String name,
}) {
  return _unionPrototype(
    allConstructors,
    areCallbacksRequired: areCallbacksRequired,
    name: name,
    ctor2parameters: (constructor) {
      return ParametersTemplate([
        ...constructor.parameters.requiredPositionalParameters,
        ...constructor.parameters.optionalPositionalParameters,
        ...constructor.parameters.namedParameters,
      ]);
    },
  );
}

String _unionPrototype(
  List<ConstructorDetails> allConstructors, {
  @required bool areCallbacksRequired,
  @required String name,
  @required ParametersTemplate Function(ConstructorDetails) ctor2parameters,
}) {
  final buffer =
      StringBuffer('@optionalTypeArgs Result $name<Result extends Object>(');

  final parameters = <CallbackParameter>[];
  for (final constructor in allConstructors) {
    var template = CallbackParameter(
      name: constructorNameToCallbackName(constructor.name),
      type: 'Result',
      isRequired: !constructor.isDefault && areCallbacksRequired,
      parameters: ctor2parameters(constructor),
      decorators: const [],
      nullable: false,
      defaultValueSource: '',
    );

    if (constructor.isDefault) {
      buffer..write(template)..write(',');
    } else {
      parameters.add(template);
    }
  }

  buffer
    ..write('{')
    ..writeAll(parameters, ',')
    ..write(',');

  if (!areCallbacksRequired) {
    buffer.write('@required Result orElse(),');
  }
  buffer.write('})');
  return buffer.toString();
}

bool isDefaultConstructor(ConstructorElement constructor) {
  return constructor.name == null || constructor.name.isEmpty;
}

String constructorNameToCallbackName(String constructorName) {
  return constructorName == null || constructorName.isEmpty
      ? '\$default'
      : constructorName;
}
