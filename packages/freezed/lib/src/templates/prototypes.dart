import 'package:analyzer/dart/element/element.dart';
import 'package:freezed/src/freezed_generator.dart';
import 'package:meta/meta.dart';
import 'parameter_template.dart';

final redirectedConstructorNameRegexp =
    RegExp(r'^[^;]+?=[\s\n\t]*([^<>]+?)(?:<.+?>)*?;', dotAll: true);

List<String> parseDecorators(List<ElementAnnotation> metadata) {
  return [
    for (final meta in metadata) if (!meta.isRequired) meta.toSource(),
  ];
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
          isAnnotatedWithRequired: false,
          decorators: const [],
          nullable: false,
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
      Iterable<Parameter> unrequire(List<Parameter> p) {
        return p.map((p) => Parameter(
              decorators: p.decorators,
              name: p.name,
              isAnnotatedWithRequired: false,
              type: p.type,
              nullable: p.nullable,
            ));
      }

      return ParametersTemplate([
        ...unrequire(constructor.parameters.positionalParameters),
        ...unrequire(constructor.parameters.optionalPositionalParameters),
        ...unrequire(constructor.parameters.namedParameters),
      ]);
    },
  );
}

String _unionPrototype(
  List<ConstructorDetails> allConstructors, {
  @required bool areCallbacksRequired,
  @required String name,
  @required ParametersTemplate ctor2parameters(ConstructorDetails ctor),
}) {
  final buffer =
      StringBuffer('@optionalTypeArgs Result $name<Result extends Object>(');

  final parameters = <CallbackParameter>[];
  for (final constructor in allConstructors) {
    var template = CallbackParameter(
      name: constructorNameToCallbackName(constructor.name),
      type: 'Result',
      isAnnotatedWithRequired: !constructor.isDefault && areCallbacksRequired,
      parameters: ctor2parameters(constructor),
      decorators: const [],
      nullable: false,
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
