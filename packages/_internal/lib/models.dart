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
class DeepCloneableProperty with _$DeepCloneableProperty {
  factory DeepCloneableProperty({
    required String name,
    required String typeName,
    required String type,
    required bool nullable,
    required bool isDowncastedToNullable,
    required GenericsParameterTemplate genericParameters,
  }) = _DeepCloneableProperty;
}

/// The information of a specific constructor of a class tagged with `@freezed`.
///
/// This only includes constructors where Freezed needs to generate something.
@freezed
class ConstructorDetails with _$ConstructorDetails {
  factory ConstructorDetails({
    required String name,
    required String unionValue,
    required bool isConst,
    required String redirectedName,
    required ParametersTemplate parameters,
    required List<Property> impliedProperties,
    required bool isDefault,
    required bool isFallback,
    required bool hasJsonSerializable,
    required String fullName,
    required String escapedName,
    required List<String> withDecorators,
    required List<String> implementsDecorators,
    required List<String> decorators,
    required List<DeepCloneableProperty> cloneableProperties,
    required List<AssertTemplate> asserts,
  }) = _ConstructorDetails;

  ConstructorDetails._();

  String get callbackName => constructorNameToCallbackName(name);
}

@freezed
class MapConfig with _$MapConfig {
  factory MapConfig({
    required bool map,
    required bool mapOrNull,
    required bool maybeMap,
  }) = _MapConfig;
}

@freezed
class WhenConfig with _$WhenConfig {
  factory WhenConfig({
    required bool when,
    required bool whenOrNull,
    required bool maybeWhen,
  }) = _WhenConfig;
}

@freezed
class Data with _$Data {
  @Assert('constructors.isNotEmpty')
  factory Data({
    required String name,
    required String unionKey,
    required bool generateCopyWith,
    required bool generateEqual,
    required bool generateToString,
    required MapConfig map,
    required WhenConfig when,
    required bool generateFromJson,
    required bool generateToJson,
    required bool makeCollectionsImmutable,
    required List<String> concretePropertiesName,
    required List<ConstructorDetails> constructors,
    required GenericsDefinitionTemplate genericsDefinitionTemplate,
    required GenericsParameterTemplate genericsParameterTemplate,
    required bool shouldUseExtends,
    required bool genericArgumentFactories,
  }) = _Data;
}

@freezed
class GlobalData with _$GlobalData {
  factory GlobalData({
    required bool hasJson,
    required bool hasDiagnostics,
  }) = _GlobalData;
}
