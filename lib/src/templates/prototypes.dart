import 'package:analyzer/dart/element/element.dart';
import 'package:meta/meta.dart';

import 'parameter_template.dart';

final redirectedConstructorNameRegexp = RegExp(r'([^\s \t\n=<]+)(?:<.+>)?;');

String getRedirectedConstructorName(ConstructorElement constructor) {
  if (constructor.redirectedConstructor != null) {
    return null;
  }
  final location = constructor.nameOffset;
  final source = constructor.source.contents.data;

  return redirectedConstructorNameRegexp.firstMatch(source.substring(location))?.group(1);
}

String whenPrototype(List<ConstructorElement> allConstructors) {
  return _whenPrototype(allConstructors, areCallbacksRequired: true, name: 'when');
}

String maybeWhenPrototype(List<ConstructorElement> allConstructors) {
  return _whenPrototype(allConstructors, areCallbacksRequired: false, name: 'maybeWhen');
}

String mapPrototype(List<ConstructorElement> allConstructors) {
  return _mapPrototype(allConstructors, areCallbacksRequired: true, name: 'map');
}

String maybeMapPrototype(List<ConstructorElement> allConstructors) {
  return _mapPrototype(allConstructors, areCallbacksRequired: false, name: 'maybeMap');
}

String _mapPrototype(
  List<ConstructorElement> allConstructors, {
  @required bool areCallbacksRequired,
  @required String name,
}) {
  return _unionPrototype(
    allConstructors,
    areCallbacksRequired: areCallbacksRequired,
    name: name,
    ctor2parameters: (constructor) {
      return ParametersTemplate([
        Parameter(name: 'value', type: getRedirectedConstructorName(constructor)),
      ]);
    },
  );
}

String _whenPrototype(
  List<ConstructorElement> allConstructors, {
  @required bool areCallbacksRequired,
  @required String name,
}) {
  return _unionPrototype(
    allConstructors,
    areCallbacksRequired: areCallbacksRequired,
    name: name,
    ctor2parameters: (constructor) {
      final constructorParameters = ParametersTemplate.fromParameterElements(constructor.parameters);
      return ParametersTemplate([
        ...constructorParameters.positionalParameters,
        ...constructorParameters.optionalPositionalParameters,
        ...constructorParameters.namedParameters,
      ]);
    },
  );
}

String _unionPrototype(
  List<ConstructorElement> allConstructors, {
  @required bool areCallbacksRequired,
  @required String name,
  @required ParametersTemplate ctor2parameters(ConstructorElement ctor),
}) {
  final buffer = StringBuffer('@optionalTypeArgs Result $name<Result extends Object>(');

  final parameters = <CallbackParameter>[];
  for (final constructor in allConstructors) {
    var template = CallbackParameter(
      name: constructorNameToCallbackName(constructor.name),
      type: 'Result',
      isRequired: !isDefaultConstructor(constructor) && areCallbacksRequired,
      parameters: ctor2parameters(constructor),
    );

    if (isDefaultConstructor(constructor)) {
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
  return constructorName == null || constructorName.isEmpty ? '\$default' : constructorName;
}
