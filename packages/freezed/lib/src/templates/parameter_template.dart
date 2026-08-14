/// Template utilities for generating Dart constructor parameter lists.
///
/// This file provides templates for generating parameter declarations
/// used in freezed's generated code, including:
/// - Generic type parameters
/// - Required/optional positional parameters
/// - Named parameters
/// - Various parameter styles (this., super., callback)
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer_buffer/analyzer_buffer.dart';
import 'package:collection/collection.dart';
import 'package:freezed/src/ast.dart';
import 'package:freezed/src/templates/concrete_template.dart';
import 'package:freezed/src/templates/prototypes.dart';
import 'package:freezed/src/tools/type.dart';

/// Template for generating generic type definitions (e.g., `<T extends Object>`).
class GenericsDefinitionTemplate {
  GenericsDefinitionTemplate(this.typeParameters);

  factory GenericsDefinitionTemplate.fromGenericElement(
    List<TypeParameterElement> generics,
  ) {
    return GenericsDefinitionTemplate(
      generics.map((e) => e.displayString()).toList(),
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

/// Template for generating generic type parameters (e.g., `<T, U>`).
class GenericsParameterTemplate {
  GenericsParameterTemplate(this.typeParameters);

  factory GenericsParameterTemplate.fromGenericElement(
    List<TypeParameterElement> generics,
  ) {
    return GenericsParameterTemplate(generics.map((e) => e.name!).toList());
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

/// Template for generating complete constructor parameter lists.
///
/// This class manages the three types of Dart constructor parameters:
/// - Required positional parameters
/// - Optional positional parameters (in `[...]`)
/// - Named parameters (in `{...}`)
///
/// Example output:
/// ```dart
/// // Required: String name, int age
/// // Optional: [double? score]
/// // Named: {bool? isActive, String? role}
/// // Output: String name, int age, [double? score], {bool? isActive, String? role}
/// ```
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
        name: e.name!,
        defaultValueSource:
            p.defaultClause?.value.computeConstantValue()?.value?.toCode() ??
            e.defaultValue,
        isRequired: e.isRequiredNamed,
        isFinal: addImplicitFinal || e.isFinal,
        type: e.type,
        typeDisplayString: parseTypeSource(p),
        decorators: parseDecorators(e.metadata.annotations),
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

  /// Required positional parameters (e.g., `String name, int age`).
  final List<Parameter> requiredPositionalParameters;

  /// Optional positional parameters (e.g., `[double? score]`).
  final List<Parameter> optionalPositionalParameters;

  /// Named parameters (e.g., `{bool? isActive}`).
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

/// Represents a constructor parameter for code generation.
///
/// This class handles the string representation of parameters in generated
/// constructor parameter lists. It supports various parameter styles and
/// modifiers.
///
/// ## Important Notes
///
/// - The `isFinal` field tracks whether the parameter is final in the source
///   code, but does NOT affect the generated constructor parameter string.
/// - The `showFinal` field controls whether the `final` keyword is included
///   in the generated string. This defaults to `false` because Dart 3 does
///   not allow `final` in constructor parameter lists.
/// - For class field declarations, use the `Property` class instead, which
///   properly handles the `final` keyword for field declarations.
///
/// ## Example Usage
///
/// ```dart
/// // Constructor parameter (showFinal: false)
/// final param = Parameter(
///   type: stringType,
///   typeDisplayString: 'String',
///   name: 'value',
///   isFinal: true,
///   showFinal: false, // Correct: no 'final' in constructor params
///   // ...
/// );
/// // toString() outputs: ' String value'
///
/// // With showFinal: true (not recommended for constructors)
/// final paramWithFinal = Parameter(
///   // ...
///   showFinal: true,
/// );
/// // toString() outputs: 'final String value'
/// ```
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
    this.showFinal = false,
    required this.parameterElement,
  });

  /// Creates a new [Parameter] from an existing one.
  ///
  /// This factory is used when transforming parameters for different contexts
  /// (e.g., converting to constructor parameters, local parameters, etc.).
  ///
  /// **Important:** [showFinal] is always set to `false` in the copied parameter
  /// to ensure the `final` keyword is never emitted in constructor parameter
  /// lists, which would cause a Dart 3 compilation error.
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
      // Always false to prevent 'final' in constructor parameter lists
      showFinal: false,
      parameterElement: p.parameterElement,
    );
  }

  /// The Dart type of the parameter.
  final DartType type;

  /// The display string representation of the type (e.g., 'List<int>?').
  final String typeDisplayString;

  /// The parameter name (e.g., 'value', 'items').
  final String name;

  /// The source code for the default value, or null if no default.
  final String? defaultValueSource;

  /// Whether this is a required named parameter.
  final bool isRequired;

  /// List of decorator annotations (e.g., ['@Default(42)', '@JsonKey()']).
  final List<String> decorators;

  /// Whether to show the default value in the generated code.
  final bool showDefaultValue;

  /// Whether the parameter is final in the source code.
  ///
  /// This is used to track the parameter's mutability but does NOT
  /// affect the generated constructor parameter string. For field
  /// declarations, use `Property` which handles `final` correctly.
  final bool isFinal;

  /// Whether to include the `final` keyword in the generated string.
  ///
  /// This defaults to `false` because Dart 3 does not allow the `final`
  /// keyword in constructor parameter lists. Setting this to `true`
  /// would cause a compilation error:
  ///
  /// ```
  /// Error: Can't have modifier 'final' here. Try removing 'final'.
  /// ```
  ///
  /// This field exists for future flexibility but should remain `false`
  /// for all constructor parameter generation.
  final bool showFinal;

  /// Documentation comments for this parameter.
  final String doc;

  /// The underlying analyzer element for this parameter, or null if synthetic.
  final FormalParameterElement? parameterElement;

  /// Creates a copy of this parameter with the specified fields replaced.
  ///
  /// Use this to transform parameters while preserving most of their state.
  /// For example:
  ///
  /// ```dart
  /// final newParam = param.copyWith(
  ///   name: '_${param.name}',
  ///   decorators: [],
  /// );
  /// ```
  Parameter copyWith({
    DartType? type,
    String? name,
    String? defaultValueSource,
    bool? isRequired,
    List<String>? decorators,
    bool? showDefaultValue,
    String? doc,
    bool? isFinal,
    bool? showFinal,
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
    showFinal: showFinal ?? this.showFinal,
    parameterElement: parameterElement,
  );

  /// Converts this parameter to its string representation for use in
  /// constructor parameter lists.
  ///
  /// The output format depends on the parameter's properties:
  ///
  /// - Basic: `Type name`
  /// - Required: `required Type name`
  /// - With decorators: `@Decorator() Type name`
  /// - With default: `Type name = defaultValue`
  ///
  /// **Note:** The `final` keyword is only included if [showFinal] is `true`.
  /// For constructor parameters, this should always be `false` to avoid
  /// Dart 3 compilation errors.
  ///
  /// Example outputs:
  /// ```dart
  /// ' String value'           // Simple parameter
  /// 'required String value'   // Required parameter
  /// ' @Default(42) int count' // With default value
  /// ```
  @override
  String toString() {
    var res = ' $typeDisplayString $name';
    if (showFinal) {
      res = 'final$res';
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

/// A parameter that uses `super.` prefix for forwarding to a super constructor.
///
/// This generates parameters like `super.value` or `required super.name`.
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

/// A parameter that uses `this.` prefix for field initialization.
///
/// This generates parameters like `this.value` or `required this.name`.
/// Used in constructors that directly initialize class fields.
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

/// A parameter representing a callback/function type.
///
/// This generates parameters like `void Function(String value) callback`.
/// Used for parameters that accept function values.
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
