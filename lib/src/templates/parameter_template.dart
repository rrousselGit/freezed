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
        );
      }
      return Parameter(
        name: e.name,
        type: e.type?.displayName,
      );
    }

    return ParametersTemplate(
      parameters.where((p) => p.isRequiredPositional).map(asParameter).toList(),
      optionalPositionalParameters: parameters
          .where((p) => p.isOptionalPositional)
          .map(asParameter)
          .toList(),
      namedParameters:
          parameters.where((p) => p.isNamed).map(asParameter).toList(),
    );
  }

  final List<Parameter> positionalParameters;
  final List<Parameter> optionalPositionalParameters;
  final List<Parameter> namedParameters;

  @override
  String toString() {
    final buffer = StringBuffer()..writeAll(positionalParameters, ', ');

    if (buffer.isNotEmpty &&
        (optionalPositionalParameters.isNotEmpty ||
            namedParameters.isNotEmpty)) {
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
}

class Parameter {
  Parameter({
    this.type,
    this.name,
  });

  final String type;
  final String name;

  @override
  String toString() {
    return '${type ?? 'dynamic'} $name';
  }
}

class LocalParameter extends Parameter {
  LocalParameter({String name, String type}) : super(name: name, type: type);

  @override
  String toString() {
    return 'this.$name';
  }
}
