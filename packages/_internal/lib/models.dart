import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';

class GenericsParameterTemplate {}

class GenericsDefinitionTemplate {}

class ParametersTemplate {}

class Property {
  late String name;
}

class AssertTemplate {}

class LateGetter {}

class Element {}

String constructorNameToCallbackName(String name) => name;

/// A generated property that has for type a class generated using Freezed
///
/// This allows Freezed to support deep copy of the object.
/// This does include primitives like [int] and [List].
@freezed
abstract class CloneableProperty with _$CloneableProperty {
  factory CloneableProperty({
    required String name,
    required String typeName,
    required String type,
    required bool nullable,
    required GenericsParameterTemplate genericParameters,
  }) = _CloneableProperty;
}

/// The informations of a specific constructor of a class tagged with `@freezed`.
///
/// This only includes constructors where Freezed needs to generate something.
@freezed
abstract class ConstructorDetails with _$ConstructorDetails {
  factory ConstructorDetails({
    required String name,
    required String unionValue,
    required bool isConst,
    required String redirectedName,
    required ParametersTemplate parameters,
    required List<Property> impliedProperties,
    required bool isDefault,
    required bool hasJsonSerializable,
    required String fullName,
    required List<String> withDecorators,
    required List<String> implementsDecorators,
    required List<String> decorators,
    required List<CloneableProperty> cloneableProperties,
    required bool canOverrideToString,
    required List<AssertTemplate> asserts,
  }) = _ConstructorDetails;

  ConstructorDetails._();

  String get callbackName => constructorNameToCallbackName(name);
}

@freezed
abstract class Data with _$Data {
  @Assert('constructors.isNotEmpty')
  factory Data({
    required String name,
    required bool needsJsonSerializable,
    required String unionKey,
    required List<String> concretePropertiesName,
    required List<ConstructorDetails> constructors,
    required GenericsDefinitionTemplate genericsDefinitionTemplate,
    required GenericsParameterTemplate genericsParameterTemplate,
    required bool shouldUseExtends,
  }) = _Data;
}

@freezed
abstract class GlobalData with _$GlobalData {
  factory GlobalData({
    required bool hasJson,
    required bool hasDiagnostics,
  }) = _GlobalData;
}

extension ShouldGenerateWhen on List<ConstructorDetails> {
  bool get shouldGenerateUnions {
    return where((element) =>
        element.name.isNotEmpty && !element.name.startsWith('_')).isNotEmpty;
  }
}
