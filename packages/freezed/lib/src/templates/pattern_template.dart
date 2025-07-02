import 'package:freezed/src/models.dart';
import 'package:freezed/src/templates/prototypes.dart';

class Pattern {}

String _maybeMap(Class data) {
  if (!data.map.maybeMap) return '';

  return '''
@override
${maybeMapPrototype(data.constructors, data.genericsParameterTemplate)} {
  if (${constructor.callbackName} != null) {
    return ${constructor.callbackName}(this);
  }
  return orElse();
}''';
}

String _map(Class data) {
  if (!data.map.map) return '';

  return '''
@override
${mapPrototype(data.constructors, data.genericsParameterTemplate)} {
  return ${constructor.callbackName}(this);
}''';
}

String _mapOrNull(Class data) {
  if (!data.map.mapOrNull) return '';

  return '''
@override
${mapOrNullPrototype(data.constructors, data.genericsParameterTemplate)} {
  return ${constructor.callbackName}?.call(this);
}''';
}

String _maybeWhen(Class data) {
  if (!data.when.maybeWhen) return '';

  var callbackParameters = constructor.impliedProperties.map((e) {
    if (data.constructors.any((c) => c.callbackName == e.name)) {
      return 'this.${e.name}';
    }
    return e.name;
  }).join(',');

  return '''
@override
${maybeWhenPrototype(data.constructors)} {
  if (${constructor.callbackName} != null) {
    return ${constructor.callbackName}($callbackParameters);
  }
  return orElse();
}''';
}

String _when(Class data) {
  if (!data.when.when) return '';

  var callbackParameters = constructor.impliedProperties.map((e) {
    if (data.constructors.any((c) => c.callbackName == e.name)) {
      return 'this.${e.name}';
    }
    return e.name;
  }).join(',');

  return '''
@override
${whenPrototype(data.constructors)} {
  return ${constructor.callbackName}($callbackParameters);
}''';
}

String _whenOrNull(Class data) {
  if (!data.when.whenOrNull) return '';

  var callbackParameters = constructor.impliedProperties.map((e) {
    if (data.constructors.any((c) => c.callbackName == e.name)) {
      return 'this.${e.name}';
    }
    return e.name;
  }).join(',');

  return '''
@override
${whenOrNullPrototype(data.constructors)} {
  return ${constructor.callbackName}?.call($callbackParameters);
}''';
}

String whenPrototype(List<ConstructorDetails> allConstructors) {
  return _whenPrototype(
    allConstructors,
    areCallbacksRequired: true,
    isReturnTypeNullable: false,
    name: 'when',
  );
}

String whenOrNullPrototype(List<ConstructorDetails> allConstructors) {
  return _whenPrototype(
    allConstructors,
    areCallbacksRequired: false,
    isReturnTypeNullable: true,
    name: 'whenOrNull',
  );
}

String maybeWhenPrototype(List<ConstructorDetails> allConstructors) {
  return _whenPrototype(
    allConstructors,
    areCallbacksRequired: false,
    isReturnTypeNullable: false,
    name: 'maybeWhen',
  );
}

String mapPrototype(
  List<ConstructorDetails> allConstructors,
  GenericsParameterTemplate genericParameters,
) {
  return _mapPrototype(
    allConstructors,
    genericParameters,
    areCallbacksRequired: true,
    isReturnTypeNullable: false,
    name: 'map',
  );
}

String mapOrNullPrototype(
  List<ConstructorDetails> allConstructors,
  GenericsParameterTemplate genericParameters,
) {
  return _mapPrototype(
    allConstructors,
    genericParameters,
    areCallbacksRequired: false,
    isReturnTypeNullable: true,
    name: 'mapOrNull',
  );
}

String maybeMapPrototype(
  List<ConstructorDetails> allConstructors,
  GenericsParameterTemplate genericParameters,
) {
  return _mapPrototype(
    allConstructors,
    genericParameters,
    areCallbacksRequired: false,
    isReturnTypeNullable: false,
    name: 'maybeMap',
  );
}

String _mapPrototype(
  List<ConstructorDetails> allConstructors,
  GenericsParameterTemplate genericParameters, {
  required bool areCallbacksRequired,
  required bool isReturnTypeNullable,
  required String name,
}) {
  return _unionPrototype(
    allConstructors,
    areCallbacksRequired: areCallbacksRequired,
    isReturnTypeNullable: isReturnTypeNullable,
    name: name,
    ctor2parameters: (constructor) {
      return ParametersTemplate([
        Parameter(
          name: 'value',
          type: null,
          typeDisplayString: '${constructor.redirectedName}$genericParameters',
          isRequired: false,
          isFinal: false,
          decorators: const [],
          defaultValueSource: '',
          doc: '',
          showDefaultValue: false,
          parameterElement: null,
        ),
      ]);
    },
  );
}

String _whenPrototype(
  List<ConstructorDetails> allConstructors, {
  required bool areCallbacksRequired,
  required bool isReturnTypeNullable,
  required String name,
}) {
  return _unionPrototype(
    allConstructors,
    areCallbacksRequired: areCallbacksRequired,
    isReturnTypeNullable: isReturnTypeNullable,
    name: name,
    ctor2parameters: (constructor) {
      return ParametersTemplate([
        ...constructor.parameters.requiredPositionalParameters
            .map((e) => e.copyWith(isFinal: false)),
        ...constructor.parameters.optionalPositionalParameters
            .map((e) => e.copyWith(
                  isFinal: false,
                  showDefaultValue: false,
                )),
        ...constructor.parameters.namedParameters.map((e) => e.copyWith(
              isRequired: false,
              isFinal: false,
              showDefaultValue: false,
            )),
      ]);
    },
  );
}

String _unionPrototype(
  List<ConstructorDetails> allConstructors, {
  required bool areCallbacksRequired,
  required bool isReturnTypeNullable,
  required String name,
  required ParametersTemplate Function(ConstructorDetails) ctor2parameters,
}) {
  final returnType = isReturnTypeNullable ? 'TResult?' : 'TResult';

  final buffer = StringBuffer(
      '@optionalTypeArgs $returnType $name<TResult extends Object?>(');

  final parameters = <CallbackParameter>[];
  for (final constructor in allConstructors) {
    var template = CallbackParameter(
      name: constructorNameToCallbackName(constructor.name),
      type: null,
      typeDisplayString: returnType,
      isFinal: false,
      isRequired: !constructor.isDefault && areCallbacksRequired,
      parameters: ctor2parameters(constructor),
      decorators: const [],
      defaultValueSource: '',
      doc: '',
      parameterElement: null,
    );

    if (constructor.isDefault) {
      buffer
        ..write(template)
        ..write(',');
    } else {
      parameters.add(template);
    }
  }

  final hasOrElse = !areCallbacksRequired && !isReturnTypeNullable;

  if (parameters.isNotEmpty || hasOrElse) {
    buffer.write('{');
    if (parameters.isNotEmpty) {
      buffer
        ..writeAll(parameters, ',')
        ..write(',');
    }

    if (hasOrElse) {
      buffer.write('required $returnType orElse(),');
    }

    buffer.write('}');
  }
  buffer.write(')');
  return buffer.toString();
}