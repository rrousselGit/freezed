import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';
import 'package:freezed/src/ast.dart';
import 'package:freezed/src/templates/concrete_template.dart';
import 'package:freezed/src/templates/prototypes.dart';
import 'package:freezed/src/tools/type.dart';

class GenericsDefinitionTemplate {
  GenericsDefinitionTemplate(this.typeParameters);

  factory GenericsDefinitionTemplate.fromGenericElement(
    List<TypeParameterElement2> generics,
  ) {
    return GenericsDefinitionTemplate(
      generics.map((e) => e.displayString2()).toList(),
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
    List<TypeParameterElement2> generics,
  ) {
    return GenericsParameterTemplate(generics.map((e) => e.name3!).toList());
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

  static ParametersTemplate fromParameterList(
    Iterable<FormalParameter> parameters, {
    bool isAssignedToThis = false,
    required bool addImplicitFinal,
  }) {
    Parameter asParameter(FormalParameter p) {
      final e = p.declaredFragment!.element;

      final value = Parameter(
        name: e.name3!,
        defaultValueSource: e.defaultValue,
        isRequired: e.isRequiredNamed,
        isFinal: addImplicitFinal || e.isFinal,
        type: e.type,
        typeDisplayString: parseTypeSource(p),
        decorators: parseDecorators(e.metadata2.annotations),
        doc: p.documentation ?? '',
        showDefaultValue: true,
        parameterElement: e,
      );

      if (isAssignedToThis) return LocalParameter.fromParameter(value);
      return value;
    }

    return ParametersTemplate(
      parameters.where((p) => p.isRequiredPositional).map(asParameter).toList(),
      optionalPositionalParameters: parameters
          .where((p) => p.isOptionalPositional)
          .map(asParameter)
          .toList(),
      namedParameters: parameters
          .where((p) => p.isNamed)
          .map(asParameter)
          .toList(),
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
    return mapParameters(LocalParameter.fromParameter);
  }

  ParametersTemplate asExpanded({bool showDefaultValue = false}) {
    return mapParameters((parameter) {
      return Parameter.fromParameter(
        parameter,
      ).copyWith(showDefaultValue: showDefaultValue);
    });
  }

  ParametersTemplate mapParameters(Parameter Function(Parameter parameter) cb) {
    return ParametersTemplate(
      requiredPositionalParameters.map(cb).toList(),
      optionalPositionalParameters: optionalPositionalParameters
          .map(cb)
          .toList(),
      namedParameters: namedParameters.map(cb).toList(),
    );
  }

  ParametersTemplate mapParameters2(
    (Parameter, {bool isNamed, bool isRequired}) Function(
      Parameter parameter, {
      required bool isNamed,
      required bool isRequired,
      required int? index,
    })
    cb,
  ) {
    final parameters = [
      ...requiredPositionalParameters.mapIndexed(
        (index, e) => cb(e, isNamed: false, isRequired: true, index: index),
      ),
      ...optionalPositionalParameters.mapIndexed(
        (index, e) => cb(e, isNamed: false, isRequired: false, index: index),
      ),
      ...namedParameters.map(
        (e) => cb(e, isNamed: true, isRequired: e.isRequired, index: null),
      ),
    ];

    return ParametersTemplate(
      parameters
          .where((e) => e.isNamed == false && e.isRequired == true)
          .map((e) => e.$1)
          .toList(),
      optionalPositionalParameters: parameters
          .where((e) => e.isNamed == false && e.isRequired == false)
          .map((e) => e.$1)
          .toList(),
      namedParameters: parameters
          .where((e) => e.isNamed == true)
          .map((e) => e.$1)
          .toList(),
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
    required this.typeDisplayString,
    required this.name,
    required this.defaultValueSource,
    required this.isRequired,
    required this.decorators,
    required this.doc,
    required this.isFinal,
    required this.showDefaultValue,
    required this.parameterElement,
  });

  factory Parameter.fromParameter(Parameter p) {
    return Parameter(
      type: p.type,
      typeDisplayString: p.typeDisplayString,
      name: p.name,
      defaultValueSource: p.defaultValueSource,
      isRequired: p.isRequired,
      decorators: p.decorators,
      doc: p.doc,
      isFinal: p.isFinal,
      showDefaultValue: p.showDefaultValue,
      parameterElement: p.parameterElement,
    );
  }

  final DartType type;
  final String typeDisplayString;
  final String name;
  final String? defaultValueSource;
  final bool isRequired;
  final List<String> decorators;
  final bool showDefaultValue;
  final bool isFinal;
  final String doc;
  final FormalParameterElement? parameterElement;

  Parameter copyWith({
    DartType? type,
    String? name,
    String? defaultValueSource,
    bool? isRequired,
    List<String>? decorators,
    bool? showDefaultValue,
    String? doc,
    bool? isFinal,
  }) => Parameter(
    type: type ?? this.type,
    typeDisplayString: typeDisplayString,
    name: name ?? this.name,
    defaultValueSource: defaultValueSource ?? this.defaultValueSource,
    isRequired: isRequired ?? this.isRequired,
    decorators: decorators ?? this.decorators,
    showDefaultValue: showDefaultValue ?? this.showDefaultValue,
    doc: doc ?? this.doc,
    isFinal: isFinal ?? this.isFinal,
    parameterElement: parameterElement,
  );

  @override
  String toString() {
    var res = ' $typeDisplayString $name';
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

class SuperParameter extends Parameter {
  SuperParameter({
    required super.name,
    required super.type,
    required super.typeDisplayString,
    required super.defaultValueSource,
    required super.isFinal,
    required super.isRequired,
    required super.decorators,
    required super.doc,
    required super.parameterElement,
  }) : super(showDefaultValue: true);

  SuperParameter.fromParameter(Parameter p)
    : this(
        name: p.name,
        type: p.type,
        typeDisplayString: p.typeDisplayString,
        defaultValueSource: p.defaultValueSource,
        isFinal: p.isFinal,
        isRequired: p.isRequired,
        decorators: p.decorators,
        doc: p.doc,
        parameterElement: p.parameterElement,
      );

  @override
  String toString() {
    var res = 'super.$name';
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
    required super.name,
    required super.type,
    required super.typeDisplayString,
    required super.defaultValueSource,
    required super.isFinal,
    required super.isRequired,
    required super.decorators,
    required super.doc,
    required super.parameterElement,
  }) : super(showDefaultValue: true);

  LocalParameter.fromParameter(Parameter p)
    : this(
        name: p.name,
        type: p.type,
        typeDisplayString: p.typeDisplayString,
        defaultValueSource: p.defaultValueSource,
        isFinal: p.isFinal,
        isRequired: p.isRequired,
        decorators: p.decorators,
        doc: p.doc,
        parameterElement: p.parameterElement,
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
    required this.parameters,
    required super.name,
    required super.defaultValueSource,
    required super.type,
    required super.typeDisplayString,
    required super.isRequired,
    required super.isFinal,
    required super.decorators,
    required super.doc,
    required super.parameterElement,
  }) : super(showDefaultValue: false);

  final ParametersTemplate parameters;

  @override
  String toString() {
    var res = '$typeDisplayString Function($parameters)';

    if (isRequired) {
      res = 'required $res';
    }
    if (decorators.isNotEmpty) {
      res = '${decorators.join()} $res';
    }
    if (type.isNullable) {
      res = '$res?';
    }

    return '$res  $name';
  }
}
