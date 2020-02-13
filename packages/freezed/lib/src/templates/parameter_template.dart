import 'package:analyzer/dart/element/element.dart';
import 'package:freezed/src/templates/prototypes.dart';
import 'package:freezed/src/templates/concrete_template.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';
class GenericsDefinitionTemplate {
  final List<TypeParameterElement> typeParameters;

  GenericsDefinitionTemplate(this.typeParameters);

  @override
  String toString() {
    if (typeParameters.isEmpty) return '';

    return '<${typeParameters.join(',')}>';
  }
}

class GenericsParameterTemplate {
  final List<TypeParameterElement> typeParameters;

  GenericsParameterTemplate(this.typeParameters);

  @override
  String toString() {
    if (typeParameters.isEmpty) return '';

    return '<${typeParameters.map((e) => e.name).join(', ')}>';
  }
}

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
          type: e.type?.getDisplayString(),
          name: e.name,
          isRequired: e.hasRequired,
          decorators: parseDecorators(e.metadata),
          nullable: e.isNullable,
        );
      }
      return Parameter(
          name: e.name,
          isRequired: e.hasRequired,
          type: e.type?.getDisplayString(),
          decorators: parseDecorators(e.metadata),
          nullable: e.isNullable);
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

  List<Parameter> get allParameters => [
        ...positionalParameters,
        ...optionalPositionalParameters,
        ...namedParameters,
      ];

  ParametersTemplate asThis() {
    List<Parameter> asThis(List<Parameter> parameters) {
      return parameters
          .map(
            (e) => LocalParameter(
              isRequired: e.isRequired,
              name: e.name,
              type: e.type,
              decorators: e.decorators,
              nullable: e.nullable,
            ),
          )
          .toList();
    }

    return ParametersTemplate(
      asThis(positionalParameters),
      optionalPositionalParameters: asThis(optionalPositionalParameters),
      namedParameters: asThis(namedParameters),
    );
  }

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

  ParametersTemplate get asExpandedDefinition {
    return ParametersTemplate(
      positionalParameters
          .map((e) => Parameter(
                name: e.name,
                type: e.type,
                isRequired: e.isRequired,
                decorators: e.decorators,
                nullable: e.nullable,
              ))
          .toList(),
      namedParameters: namedParameters
          .map((e) => Parameter(
                name: e.name,
                type: e.type,
                isRequired: e.isRequired,
                decorators: e.decorators,
                nullable: e.nullable,
              ))
          .toList(),
      optionalPositionalParameters: optionalPositionalParameters
          .map((e) => Parameter(
                name: e.name,
                type: e.type,
                isRequired: e.isRequired,
                decorators: e.decorators,
                nullable: e.nullable,
              ))
          .toList(),
    );
  }
}

class Parameter {
  Parameter({
    @required this.type,
    @required this.name,
    @required this.isRequired,
    @required this.decorators,
    @required this.nullable,
  });

  final String type;
  final String name;
  final bool isRequired;
  final bool nullable;
  final List<String> decorators;

  @override
  String toString() {
    var res = '${decorators.join()}  ${type ?? 'dynamic'} $name';
    return isRequired ? '@required $res' : res;
  }
}

class LocalParameter extends Parameter {
  LocalParameter({
    @required String name,
    @required String type,
    @required bool isRequired,
    @required bool nullable,
    @required List<String> decorators,
  }) : super(
          name: name,
          type: type,
          isRequired: isRequired,
          decorators: decorators,
          nullable: nullable,
        );

  @override
  String toString() {
    var res = '${decorators.join()} this.$name';
    return isRequired ? '@required $res' : res;
  }
}

class CallbackParameter extends Parameter {
  CallbackParameter({
    @required String name,
    @required String type,
    @required bool isRequired,
    @required bool nullable,
    @required List<String> decorators,
    @required this.parameters,
  }) : super(
          name: name,
          type: type,
          isRequired: isRequired,
          decorators: decorators,
          nullable: nullable,
        );

  final ParametersTemplate parameters;

  @override
  String toString() {
    var res = '${decorators.join()} $type $name($parameters)';
    return isRequired ? '@required $res' : res;
  }
}
