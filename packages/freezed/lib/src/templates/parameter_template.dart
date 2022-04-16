import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:freezed/src/templates/concrete_template.dart';
import 'package:freezed/src/templates/properties.dart';
import 'package:freezed/src/templates/prototypes.dart';
import 'package:freezed/src/utils.dart';

class GenericsDefinitionTemplate {
  GenericsDefinitionTemplate(this.typeParameters);

  factory GenericsDefinitionTemplate.fromGenericElement(
      List<TypeParameterElement> generics) {
    return GenericsDefinitionTemplate(
      generics.map((e) => e.getDisplayString(withNullability: true)).toList(),
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
    List<TypeParameterElement> generics,
  ) {
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

  static Future<ParametersTemplate> fromParameterElements(
    BuildStep buildStep,
    List<ParameterElement> parameters, {
    bool isAssignedToThis = false,
    required bool addImplicitFinal,
  }) async {
    Future<Parameter> asParameter(ParameterElement e) async {
      if (isAssignedToThis) {
        return LocalParameter(
          type: parseTypeSource(e),
          name: e.name,
          defaultValueSource: e.defaultValue,
          isRequired: e.isRequiredNamed,
          isFinal: addImplicitFinal || e.isFinal,
          decorators: parseDecorators(e.metadata),
          doc: await documentationOfParameter(e, buildStep),
          isPossiblyDartCollection: e.type.isPossiblyDartCollection,
        );
      }
      return Parameter(
        name: e.name,
        defaultValueSource: e.defaultValue,
        isRequired: e.isRequiredNamed,
        isFinal: addImplicitFinal || e.isFinal,
        type: parseTypeSource(e),
        decorators: parseDecorators(e.metadata),
        doc: await documentationOfParameter(e, buildStep),
        isPossiblyDartCollection: e.type.isPossiblyDartCollection,
      );
    }

    return ParametersTemplate(
      await Future.wait(
        parameters.where((p) => p.isRequiredPositional).map(asParameter),
      ),
      optionalPositionalParameters: await Future.wait(
        parameters.where((p) => p.isOptionalPositional).map(asParameter),
      ),
      namedParameters: await Future.wait(
        parameters.where((p) => p.isNamed).map(asParameter),
      ),
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
              isFinal: e.isFinal,
              name: e.name,
              type: e.type,
              decorators: e.decorators,
              defaultValueSource: e.defaultValueSource,
              doc: e.doc,
              isPossiblyDartCollection: e.isPossiblyDartCollection,
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
              isFinal: e.isFinal,
              name: e.name,
              type: e.type,
              decorators: e.decorators,
              defaultValueSource: e.defaultValueSource,
              showDefaultValue: showDefaultValue,
              doc: e.doc,
              isPossiblyDartCollection: e.isPossiblyDartCollection,
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
                isFinal: e.isFinal,
                decorators: e.decorators,
                defaultValueSource: e.defaultValueSource,
                doc: e.doc,
                isPossiblyDartCollection: e.isPossiblyDartCollection,
              ))
          .toList(),
      namedParameters: namedParameters
          .map((e) => Parameter(
                name: e.name,
                type: e.type,
                isRequired: e.isRequired,
                isFinal: e.isFinal,
                decorators: e.decorators,
                defaultValueSource: e.defaultValueSource,
                doc: e.doc,
                isPossiblyDartCollection: e.isPossiblyDartCollection,
              ))
          .toList(),
      optionalPositionalParameters: optionalPositionalParameters
          .map((e) => Parameter(
                name: e.name,
                type: e.type,
                isRequired: e.isRequired,
                isFinal: e.isFinal,
                decorators: e.decorators,
                defaultValueSource: e.defaultValueSource,
                doc: e.doc,
                isPossiblyDartCollection: e.isPossiblyDartCollection,
              ))
          .toList(),
    );
  }
}

class Parameter {
  Parameter({
    required this.type,
    required this.name,
    required this.defaultValueSource,
    required this.isRequired,
    required this.decorators,
    required this.doc,
    required this.isFinal,
    required this.isPossiblyDartCollection,
    this.showDefaultValue = false,
  });

  final String? type;
  final String name;
  final String? defaultValueSource;
  final bool isRequired;
  final List<String> decorators;
  final bool showDefaultValue;
  final bool isPossiblyDartCollection;
  final bool isFinal;
  final String doc;

  Parameter copyWith({
    String? type,
    String? name,
    String? defaultValueSource,
    bool? isRequired,
    bool? nullable,
    List<String>? decorators,
    bool? showDefaultValue,
    bool? isPossiblyDartCollection,
    String? doc,
    bool? isFinal,
  }) =>
      Parameter(
        type: type ?? this.type,
        name: name ?? this.name,
        defaultValueSource: defaultValueSource ?? this.defaultValueSource,
        isRequired: isRequired ?? this.isRequired,
        decorators: decorators ?? this.decorators,
        showDefaultValue: showDefaultValue ?? this.showDefaultValue,
        doc: doc ?? this.doc,
        isFinal: isFinal ?? this.isFinal,
        isPossiblyDartCollection:
            isPossiblyDartCollection ?? this.isPossiblyDartCollection,
      );

  @override
  String toString() {
    var res = ' ${type ?? 'dynamic'} $name';
    if (isFinal) {
      res = 'final $res';
    }
    if (isRequired) {
      res = 'required $res';
    }
    if (decorators.isNotEmpty) {
      res = '${decorators.join()} $res';
    }
    if (showDefaultValue && defaultValueSource != null) {
      res = '$res = $defaultValueSource';
    }
    return res;
  }
}

class LocalParameter extends Parameter {
  LocalParameter({
    required String name,
    required String? type,
    required String? defaultValueSource,
    required bool isFinal,
    required bool isRequired,
    required List<String> decorators,
    required String doc,
    required bool isPossiblyDartCollection,
  }) : super(
          name: name,
          type: type,
          isFinal: isFinal,
          showDefaultValue: true,
          isRequired: isRequired,
          decorators: decorators,
          defaultValueSource: defaultValueSource,
          doc: doc,
          isPossiblyDartCollection: isPossiblyDartCollection,
        );

  @override
  String toString() {
    var res = 'this.$name';
    if (isRequired) {
      res = 'required $res';
    }
    if (decorators.isNotEmpty) {
      res = '${decorators.join()} $res';
    }
    if (showDefaultValue && defaultValueSource != null) {
      res = '$res = $defaultValueSource';
    }
    return res;
  }
}

class CallbackParameter extends Parameter {
  CallbackParameter({
    required String name,
    required String defaultValueSource,
    required String type,
    required bool isRequired,
    required bool isFinal,
    required this.isNullable,
    required List<String> decorators,
    required this.parameters,
    required String doc,
    required bool isPossiblyDartCollection,
  }) : super(
          name: name,
          type: type,
          showDefaultValue: false,
          isRequired: isRequired,
          isFinal: isFinal,
          decorators: decorators,
          defaultValueSource: defaultValueSource,
          doc: doc,
          isPossiblyDartCollection: isPossiblyDartCollection,
        );

  final ParametersTemplate parameters;
  final bool isNullable;

  @override
  String toString() {
    var res = '$type Function($parameters)';

    if (isRequired) {
      res = 'required $res';
    }
    if (decorators.isNotEmpty) {
      res = '${decorators.join()} $res';
    }
    if (isNullable) {
      res = '$res?';
    }

    return '$res  $name';
  }
}
