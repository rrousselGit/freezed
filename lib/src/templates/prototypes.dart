import 'package:analyzer/dart/element/element.dart';
import 'package:meta/meta.dart';

import 'parameter_template.dart';

String whenPrototype(List<ConstructorElement> allConstructors) {
  return _whenPrototype(allConstructors, areCallbacksRequired: true, name: 'when');
}

String maybeWhenPrototype(List<ConstructorElement> allConstructors) {
  return _whenPrototype(allConstructors, areCallbacksRequired: false, name: 'maybeWhen');
}

String _whenPrototype(
  List<ConstructorElement> allConstructors, {
  @required bool areCallbacksRequired,
  @required String name,
}) {
  final buffer = StringBuffer('@optionalTypeArgs Result $name<Result extends Object>(');

  final parameters = <CallbackParameter>[];
  for (final constructor in allConstructors) {
    final constructorParameters = ParametersTemplate.fromParameterElements(constructor.parameters);

    var template = CallbackParameter(
      name: constructorNameToCallbackName(constructor.name),
      type: 'Result',
      isRequired: !isDefaultConstructor(constructor) && areCallbacksRequired,
      parameters: ParametersTemplate([
        ...constructorParameters.positionalParameters,
        ...constructorParameters.optionalPositionalParameters,
        ...constructorParameters.namedParameters,
      ]),
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
