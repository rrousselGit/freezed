import 'package:analyzer/dart/element/element.dart';
import 'package:freezed/src/templates/prototypes.dart';
import 'package:freezed/src/templates/concrete_template.dart';
import 'package:freezed/src/utils.dart';
import 'package:meta/meta.dart';

class GenericsDefinitionTemplate {
  GenericsDefinitionTemplate(this.typeParameters);

  factory GenericsDefinitionTemplate.fromGenericElement(
      List<TypeParameterElement> generics) {
    return GenericsDefinitionTemplate(
      generics.map((e) => e.toString()).toList(),
    );
  }

  final List<String> typeParameters;

  @override
  String toString() {
    if (typeParameters.isEmpty) return '';

    return '<${typeParameters.join(',')}>';
  }

  GenericsDefinitionTemplate append(String generic) {
    return GenericsDefinitionTemplate([...typeParameters, generic]);
  }
}

class GenericsParameterTemplate {
  GenericsParameterTemplate(this.typeParameters);

  factory GenericsParameterTemplate.fromGenericElement(
      List<TypeParameterElement> generics) {
    return GenericsParameterTemplate(
      generics.map((e) => e.name).toList(),
    );
  }
  final List<String> typeParameters;

  @override
  String toString() {
    if (typeParameters.isEmpty) return '';

    return '<${typeParameters.join(', ')}>';
  }

  GenericsParameterTemplate append(String generic) {
    return GenericsParameterTemplate([...typeParameters, generic]);
  }
}

class ParametersTemplate {
  ParametersTemplate(
    this.requiredPositionalParameters, {
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
          type: parseTypeSource(e),
          name: e.name,
          defaultValueSource: e.defaultValue,
          isRequired: e.hasRequired,
          decorators: parseDecorators(e.metadata),
          nullable: e.isNullable,
          doc: documentationOfParameter(e),
        );
      }
      return Parameter(
        name: e.name,
        defaultValueSource: e.defaultValue,
        isRequired: e.hasRequired,
        type: parseTypeSource(e),
        decorators: parseDecorators(e.metadata),
        nullable: e.isNullable,
        doc: documentationOfParameter(e),
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

  final List<Parameter> requiredPositionalParameters;
  final List<Parameter> optionalPositionalParameters;
  final List<Parameter> namedParameters;

  Iterable<Parameter> get allPositionalParameters sync* {
    yield* requiredPositionalParameters;
    yield* optionalPositionalParameters;
  }

  Iterable<Parameter> get allParameters sync* {
    yield* requiredPositionalParameters;
    yield* optionalPositionalParameters;
    yield* namedParameters;
  }

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
              defaultValueSource: e.defaultValueSource,
              doc: e.doc,
            ),
          )
          .toList();
    }

    return ParametersTemplate(
      asThis(requiredPositionalParameters),
      optionalPositionalParameters: asThis(optionalPositionalParameters),
      namedParameters: asThis(namedParameters),
    );
  }

  ParametersTemplate asExpanded({bool showDefaultValue = false}) {
    List<Parameter> asExpanded(List<Parameter> parameters) {
      return parameters
          .map(
            (e) => Parameter(
              isRequired: e.isRequired,
              name: e.name,
              type: e.type,
              decorators: e.decorators,
              nullable: e.nullable,
              defaultValueSource: e.defaultValueSource,
              showDefaultValue: showDefaultValue,
              doc: e.doc,
            ),
          )
          .toList();
    }

    return ParametersTemplate(
      asExpanded(requiredPositionalParameters),
      optionalPositionalParameters: asExpanded(optionalPositionalParameters),
      namedParameters: asExpanded(namedParameters),
    );
  }

  @override
  String toString() {
    final buffer = StringBuffer()..writeAll(requiredPositionalParameters, ', ');

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
      requiredPositionalParameters
          .map((e) => Parameter(
                name: e.name,
                type: e.type,
                isRequired: e.isRequired,
                decorators: e.decorators,
                nullable: e.nullable,
                defaultValueSource: e.defaultValueSource,
                doc: e.doc,
              ))
          .toList(),
      namedParameters: namedParameters
          .map((e) => Parameter(
                name: e.name,
                type: e.type,
                isRequired: e.isRequired,
                decorators: e.decorators,
                nullable: e.nullable,
                defaultValueSource: e.defaultValueSource,
                doc: e.doc,
              ))
          .toList(),
      optionalPositionalParameters: optionalPositionalParameters
          .map((e) => Parameter(
                name: e.name,
                type: e.type,
                isRequired: e.isRequired,
                decorators: e.decorators,
                nullable: e.nullable,
                defaultValueSource: e.defaultValueSource,
                doc: e.doc,
              ))
          .toList(),
    );
  }
}

class Parameter {
  Parameter({
    @required this.type,
    @required this.name,
    @required this.defaultValueSource,
    @required this.isRequired,
    @required this.decorators,
    @required this.nullable,
    @required this.doc,
    this.showDefaultValue = false,
  });

  final String type;
  final String name;
  final String defaultValueSource;
  final bool isRequired;
  final bool nullable;
  final List<String> decorators;
  final bool showDefaultValue;
  final String doc;

  Parameter copyWith({
    String type,
    String name,
    String defaultValueSource,
    bool isRequired,
    bool nullable,
    List<String> decorators,
    bool showDefaultValue,
    String doc,
  }) =>
      Parameter(
        type: type ?? this.type,
        name: name ?? this.name,
        defaultValueSource: defaultValueSource ?? this.defaultValueSource,
        isRequired: isRequired ?? this.isRequired,
        nullable: nullable ?? this.nullable,
        decorators: decorators ?? this.decorators,
        showDefaultValue: showDefaultValue ?? this.showDefaultValue,
        doc: doc ?? this.doc,
      );

  @override
  String toString() {
    var res = '${decorators.join()}  ${type ?? 'dynamic'} $name';
    if (showDefaultValue && defaultValueSource != null) {
      res = '$res = $defaultValueSource';
    }
    return isRequired ? '@required $res' : res;
  }
}

class LocalParameter extends Parameter {
  LocalParameter({
    @required String name,
    @required String type,
    @required String defaultValueSource,
    @required bool isRequired,
    @required bool nullable,
    @required List<String> decorators,
    @required String doc,
  }) : super(
          name: name,
          type: type,
          showDefaultValue: true,
          isRequired: isRequired,
          decorators: decorators,
          nullable: nullable,
          defaultValueSource: defaultValueSource,
          doc: doc,
        );

  @override
  String toString() {
    var res = '${decorators.join()} this.$name';
    if (showDefaultValue && defaultValueSource != null) {
      res = '$res = $defaultValueSource';
    }
    return isRequired ? '@required $res' : res;
  }
}

class CallbackParameter extends Parameter {
  CallbackParameter({
    @required String name,
    @required String defaultValueSource,
    @required String type,
    @required bool isRequired,
    @required bool nullable,
    @required List<String> decorators,
    @required this.parameters,
    @required String doc,
  }) : super(
          name: name,
          type: type,
          showDefaultValue: false,
          isRequired: isRequired,
          decorators: decorators,
          nullable: nullable,
          defaultValueSource: defaultValueSource,
          doc: doc,
        );

  final ParametersTemplate parameters;

  @override
  String toString() {
    var res = '${decorators.join()} $type $name($parameters)';
    return isRequired ? '@required $res' : res;
  }
}
