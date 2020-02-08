import 'package:analyzer/dart/element/element.dart';

class ParametersTemplate {
  ParametersTemplate(
    this.positionalParameters, {
    this.optionalPositionalParameters = const [],
    this.namedParameters = const [],
  });

  factory ParametersTemplate.fromParameterElements(
    List<ParameterElement> parameters, {
    bool isAssignedToThis = false,
  }) {
    Parameter asParameter(ParameterElement e) {
      if (isAssignedToThis) {
        return LocalParameter(
          type: e.type?.displayName,
          name: e.name,
          isRequired: e.hasRequired,
        );
      }
      return Parameter(
        name: e.name,
        isRequired: e.hasRequired,
        type: e.type?.displayName,
      );
    }

    return ParametersTemplate(
      parameters.where((p) => p.isRequiredPositional).map(asParameter).toList(),
      optionalPositionalParameters: parameters.where((p) => p.isOptionalPositional).map(asParameter).toList(),
      namedParameters: parameters.where((p) => p.isNamed).map(asParameter).toList(),
    );
  }

  final List<Parameter> positionalParameters;
  final List<Parameter> optionalPositionalParameters;
  final List<Parameter> namedParameters;

  @override
  String toString() {
    final buffer = StringBuffer()..writeAll(positionalParameters, ', ');

    if (buffer.isNotEmpty && (optionalPositionalParameters.isNotEmpty || namedParameters.isNotEmpty)) {
      buffer.write(', ');
    }
    if (optionalPositionalParameters.isNotEmpty) {
      buffer
        ..write('[')
        ..writeAll(optionalPositionalParameters, ', ')
        ..write(']');
    }
    if (namedParameters.isNotEmpty) {
      buffer
        ..write('{')
        ..writeAll(namedParameters, ', ')
        ..write('}');
    }

    return buffer.toString();
  }

  ParametersTemplate get asExpandedDefinition {
    return ParametersTemplate(
      positionalParameters
          .map((e) => Parameter(
                name: e.name,
                type: e.type,
                isRequired: e.isRequired,
              ))
          .toList(),
      namedParameters: namedParameters
          .map((e) => Parameter(
                name: e.name,
                type: e.type,
                isRequired: e.isRequired,
              ))
          .toList(),
      optionalPositionalParameters: optionalPositionalParameters
          .map((e) => Parameter(
                name: e.name,
                type: e.type,
                isRequired: e.isRequired,
              ))
          .toList(),
    );
  }
}

class Parameter {
  Parameter({
    this.type,
    this.name,
    this.isRequired = false,
  });

  final String type;
  final String name;
  final bool isRequired;

  @override
  String toString() {
    var res = '${type ?? 'dynamic'} $name';
    return isRequired ? '@required $res' : res;
  }
}

class LocalParameter extends Parameter {
  LocalParameter({
    String name,
    String type,
    bool isRequired = false,
  }) : super(name: name, type: type, isRequired: isRequired);

  @override
  String toString() {
    var res = 'this.$name';
    return isRequired ? '@required $res' : res;
  }
}

class CallbackParameter extends Parameter {
  CallbackParameter({
    String name,
    String type,
    bool isRequired = false,
    this.parameters,
  }) : super(name: name, type: type, isRequired: isRequired);

  final ParametersTemplate parameters;

  @override
  String toString() {
    var res = '$type $name($parameters)'; 
    return isRequired ? '@required $res' : res;
  }
}
