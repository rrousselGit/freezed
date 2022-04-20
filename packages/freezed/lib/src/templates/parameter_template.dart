import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
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
      final value = Parameter(
        name: e.name,
        isNullable: e.type.nullabilitySuffix == NullabilitySuffix.question,
        isDartList: e.type.isDartCoreList,
        isDartMap: e.type.isDartCoreMap,
        isDartSet: e.type.isDartCoreSet,
        defaultValueSource: e.defaultValue,
        isRequired: e.isRequiredNamed,
        isFinal: addImplicitFinal || e.isFinal,
        type: parseTypeSource(e),
        decorators: parseDecorators(e.metadata),
        doc: await documentationOfParameter(e, buildStep),
        isPossiblyDartCollection: e.type.isPossiblyDartCollection,
        showDefaultValue: true,
      );

      if (isAssignedToThis) return LocalParameter.fromParameter(value);
      return value;
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
    return mapParameters((e) => LocalParameter.fromParameter(e));
  }

  ParametersTemplate asExpanded({bool showDefaultValue = false}) {
    return mapParameters((parameter) {
      return Parameter.fromParameter(parameter)
          .copyWith(showDefaultValue: showDefaultValue);
    });
  }

  ParametersTemplate mapParameters(Parameter Function(Parameter parameter) cb) {
    return ParametersTemplate(
      requiredPositionalParameters.map(cb).toList(),
      optionalPositionalParameters:
          optionalPositionalParameters.map(cb).toList(),
      namedParameters: namedParameters.map(cb).toList(),
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
    return mapParameters(
      (parameter) =>
          Parameter.fromParameter(parameter).copyWith(showDefaultValue: false),
    );
  }
}

class Parameter {
  Parameter({
    required this.type,
    required this.name,
    required this.defaultValueSource,
    required this.isRequired,
    required this.isNullable,
    required this.isDartList,
    required this.isDartMap,
    required this.isDartSet,
    required this.decorators,
    required this.doc,
    required this.isFinal,
    required this.isPossiblyDartCollection,
    required this.showDefaultValue,
  });

  Parameter.fromParameter(Parameter p)
      : this(
          name: p.name,
          type: p.type,
          isNullable: p.isNullable,
          defaultValueSource: p.defaultValueSource,
          isFinal: p.isFinal,
          isRequired: p.isRequired,
          isDartList: p.isDartList,
          isDartMap: p.isDartMap,
          isDartSet: p.isDartSet,
          decorators: p.decorators,
          showDefaultValue: p.showDefaultValue,
          doc: p.doc,
          isPossiblyDartCollection: p.isPossiblyDartCollection,
        );

  final String? type;
  final String name;
  final String? defaultValueSource;
  final bool isNullable;
  final bool isRequired;
  final bool isDartList;
  final bool isDartMap;
  final bool isDartSet;
  final List<String> decorators;
  final bool showDefaultValue;
  final bool isPossiblyDartCollection;
  final bool isFinal;
  final String doc;

  Parameter copyWith({
    String? type,
    String? name,
    String? defaultValueSource,
    bool? isDartList,
    bool? isNullable,
    bool? isRequired,
    bool? nullable,
    List<String>? decorators,
    bool? showDefaultValue,
    bool? isPossiblyDartCollection,
    String? doc,
    bool? isDartMap,
    bool? isDartSet,
    bool? isFinal,
  }) =>
      Parameter(
        type: type ?? this.type,
        name: name ?? this.name,
        isNullable: isNullable ?? this.isNullable,
        defaultValueSource: defaultValueSource ?? this.defaultValueSource,
        isRequired: isRequired ?? this.isRequired,
        decorators: decorators ?? this.decorators,
        showDefaultValue: showDefaultValue ?? this.showDefaultValue,
        doc: doc ?? this.doc,
        isDartMap: isDartMap ?? this.isDartMap,
        isDartSet: isDartSet ?? this.isDartSet,
        isDartList: isDartList ?? this.isDartList,
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
    required bool isNullable,
    required bool isRequired,
    required bool isDartList,
    required bool isDartMap,
    required bool isDartSet,
    required List<String> decorators,
    required String doc,
    required bool isPossiblyDartCollection,
  }) : super(
          name: name,
          type: type,
          isFinal: isFinal,
          isNullable: isNullable,
          showDefaultValue: true,
          isRequired: isRequired,
          isDartList: isDartList,
          isDartMap: isDartMap,
          isDartSet: isDartSet,
          decorators: decorators,
          defaultValueSource: defaultValueSource,
          doc: doc,
          isPossiblyDartCollection: isPossiblyDartCollection,
        );

  LocalParameter.fromParameter(Parameter p)
      : this(
          name: p.name,
          type: p.type,
          isNullable: p.isNullable,
          defaultValueSource: p.defaultValueSource,
          isFinal: p.isFinal,
          isRequired: p.isRequired,
          isDartList: p.isDartList,
          isDartMap: p.isDartMap,
          isDartSet: p.isDartSet,
          decorators: p.decorators,
          doc: p.doc,
          isPossiblyDartCollection: p.isPossiblyDartCollection,
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
    required bool isDartList,
    required bool isDartMap,
    required bool isDartSet,
    required bool isNullable,
    required List<String> decorators,
    required this.parameters,
    required String doc,
    required bool isPossiblyDartCollection,
  }) : super(
          name: name,
          type: type,
          isNullable: isNullable,
          showDefaultValue: false,
          isRequired: isRequired,
          isFinal: isFinal,
          isDartList: isDartList,
          isDartMap: isDartMap,
          isDartSet: isDartSet,
          decorators: decorators,
          defaultValueSource: defaultValueSource,
          doc: doc,
          isPossiblyDartCollection: isPossiblyDartCollection,
        );

  final ParametersTemplate parameters;

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
