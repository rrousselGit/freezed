import 'package:freezed_annotation/freezed_annotation.dart';

part 'json.freezed.dart';
part 'json.g.dart';

@freezed
abstract class NoWhen with _$NoWhen {
  factory NoWhen({int? first}) = _NoWhen;

  factory NoWhen.fromJson(Map<String, dynamic> json) => _$NoWhenFromJson(json);
}

abstract class Base {}

const unionMixin = _$UnionJsonWithExtends;
const unionFirstBase = _$UnionJsonFirstWithExtendsImpl;
const unionSecondBase = _$UnionJsonSecondWithExtendsImpl;
const unionJson = _$UnionJsonWithExtendsFromJson;

@freezed
abstract class UnionJsonWithExtends extends Base with _$UnionJsonWithExtends {
  UnionJsonWithExtends._();

  factory UnionJsonWithExtends.first({int? first}) = _UnionJsonFirstWithExtends;
  factory UnionJsonWithExtends.second({int? second}) =
      _UnionJsonSecondWithExtends;

  factory UnionJsonWithExtends.fromJson(Map<String, dynamic> json) =>
      _$UnionJsonWithExtendsFromJson(json);
}

const pUnionMixin = _$PUnionJsonWithExtends;
const pUnionFirstBase = _$PUnionJsonFirstWithExtendsImpl;
const pUnionSecondBase = _$PUnionJsonSecondWithExtendsImpl;
const pUnionJson = _$PUnionJsonWithExtendsFromJson;

@freezed
abstract class _PUnionJsonWithExtends extends Base
    with _$PUnionJsonWithExtends {
  _PUnionJsonWithExtends._();

  // ignore: unused_element, unused_element_parameter
  factory _PUnionJsonWithExtends.first({int? first}) =
      _PUnionJsonFirstWithExtends;
  // ignore: unused_element, unused_element_parameter
  factory _PUnionJsonWithExtends.second({int? second}) =
      _PUnionJsonSecondWithExtends;

  // ignore: unused_element
  factory _PUnionJsonWithExtends.fromJson(Map<String, dynamic> json) =>
      _$PUnionJsonWithExtendsFromJson(json);
}

// regression test for https://github.com/rrousselGit/freezed/issues/409
@freezed
abstract class Regression409 with _$Regression409 {
  factory Regression409({
    dynamic totalResults,
  }) = _Regression409;

  factory Regression409.fromJson(Map<String, dynamic> json) =>
      _$Regression409FromJson(json);
}

// regression test for https://github.com/rrousselGit/freezed/issues/351
@freezed
abstract class Regression351 with _$Regression351 {
  factory Regression351({
    @JsonKey(name: 'total_results') required int totalResults,
  }) = _Regression351;

  factory Regression351.fromJson(Map<String, dynamic> json) =>
      _$Regression351FromJson(json);
}

// regression test for https://github.com/rrousselGit/freezed/issues/323
@freezed
abstract class Regression323 with _$Regression323 {
  const factory Regression323({
    required String id,
    required num amount,
  }) = _Regression323;

  factory Regression323.fromJson(Map<String, dynamic> json) =>
      _$Regression323FromJson(json);

  factory Regression323.unknown(num amount) => Regression323(
        id: '',
        amount: amount,
      );
}

// regression test for https://github.com/rrousselGit/freezed/issues/280
@freezed
abstract class Regression280 with _$Regression280 {
  const factory Regression280(String label) = _Regression280;

  factory Regression280.fromJson(Map<String, dynamic> val) {
    return Regression280(val['foo'] as String);
  }
}

@freezed
abstract class Regression280n2 with _$Regression280n2 {
  const factory Regression280n2(String label) = _Regression280n2;

  factory Regression280n2.fromJson(String val) {
    return Regression280n2(val);
  }
}

CustomJson _fromJson(Map<String, dynamic> json) {
  return _$CustomJsonFromJson(<String, dynamic>{
    'label': json['key'],
  });
}

@freezed
abstract class CustomJson with _$CustomJson {
  const factory CustomJson(String label) = _CustomJson;

  factory CustomJson.fromJson(Map<String, dynamic> json) => _fromJson(json);
}

@Freezed(unionKey: 'ty"\'pe')
abstract class FancyCustomKey with _$FancyCustomKey {
  const factory FancyCustomKey.first(int a) = _FancyCustomKeyFirst;
  const factory FancyCustomKey.second(int a) = _FancyCustomKeySecond;

  factory FancyCustomKey.fromJson(Map<String, dynamic> json) =>
      _$FancyCustomKeyFromJson(json);
}

@freezed
abstract class PositonalOptional with _$PositonalOptional {
  const factory PositonalOptional.first([int? a]) = _PositonalOptionalFirst;
  const factory PositonalOptional.second([int? a]) = _PositonalOptionalSecond;

  factory PositonalOptional.fromJson(Map<String, dynamic> json) =>
      _$PositonalOptionalFromJson(json);
}

@Freezed(unionKey: r'$type')
abstract class RawCustomKey with _$RawCustomKey {
  const factory RawCustomKey.first(int a) = _RawCustomKeyFirst;
  const factory RawCustomKey.second(int a) = _RawCustomKeySecond;

  factory RawCustomKey.fromJson(Map<String, dynamic> json) =>
      _$RawCustomKeyFromJson(json);
}

@Freezed(unionKey: 'type')
abstract class CustomKey with _$CustomKey {
  const factory CustomKey.first(int a) = _CustomKeyFirst;
  const factory CustomKey.second(int a) = _CustomKeySecond;

  factory CustomKey.fromJson(Map<String, dynamic> json) =>
      _$CustomKeyFromJson(json);
}

@freezed
abstract class CustomUnionValue with _$CustomUnionValue {
  const factory CustomUnionValue.first(int a) = _CustomUnionValueFirst;

  @FreezedUnionValue('SECOND')
  const factory CustomUnionValue.second(int a) = _CustomUnionValueSecond;

  factory CustomUnionValue.fromJson(Map<String, dynamic> json) =>
      _$CustomUnionValueFromJson(json);
}

@Freezed(fallbackUnion: 'fallback')
abstract class UnionFallback with _$UnionFallback {
  const factory UnionFallback.first(int a) = _UnionFallbackFirst;
  const factory UnionFallback.second(int a) = _UnionFallbackSecond;
  const factory UnionFallback.fallback(int a) = _UnionFallbackFallback;

  factory UnionFallback.fromJson(Map<String, dynamic> json) =>
      _$UnionFallbackFromJson(json);
}

@Freezed(fallbackUnion: 'default')
abstract class UnionDefaultFallback with _$UnionDefaultFallback {
  const factory UnionDefaultFallback(int a) = _UnionDefaultFallback;
  const factory UnionDefaultFallback.first(int a) = _UnionDefaultFallbackFirst;
  const factory UnionDefaultFallback.second(int a) =
      _UnionDefaultFallbackSecond;

  factory UnionDefaultFallback.fromJson(Map<String, dynamic> json) =>
      _$UnionDefaultFallbackFromJson(json);
}

@Freezed(unionKey: 'key', fallbackUnion: 'default')
abstract class UnionKeyDefaultFallback with _$UnionKeyDefaultFallback {
  const factory UnionKeyDefaultFallback(String key) = _UnionKeyDefaultFallback;
  const factory UnionKeyDefaultFallback.first(String key) =
      _UnionKeyDefaultFallbackFirst;

  factory UnionKeyDefaultFallback.fromJson(Map<String, dynamic> json) =>
      _$UnionKeyDefaultFallbackFromJson(json);
}

@Freezed(unionValueCase: FreezedUnionCase.pascal)
abstract class UnionValueCasePascal with _$UnionValueCasePascal {
  const factory UnionValueCasePascal.first(int a) = _UnionValueCasePascalFirst;
  const factory UnionValueCasePascal.secondValue(int a) =
      _UnionValueCasePascalSecondValue;

  factory UnionValueCasePascal.fromJson(Map<String, dynamic> json) =>
      _$UnionValueCasePascalFromJson(json);
}

@Freezed(unionValueCase: FreezedUnionCase.kebab)
abstract class UnionValueCaseKebab with _$UnionValueCaseKebab {
  const factory UnionValueCaseKebab.first(int a) = _UnionValueCaseKebabFirst;
  const factory UnionValueCaseKebab.secondValue(int a) =
      _UnionValueCaseKebabSecondValue;

  factory UnionValueCaseKebab.fromJson(Map<String, dynamic> json) =>
      _$UnionValueCaseKebabFromJson(json);
}

@Freezed(unionValueCase: FreezedUnionCase.snake)
abstract class UnionValueCaseSnake with _$UnionValueCaseSnake {
  const factory UnionValueCaseSnake.first(int a) = _UnionValueCaseSnakeFirst;
  const factory UnionValueCaseSnake.secondValue(int a) =
      _UnionValueCaseSnakeSecondValue;

  factory UnionValueCaseSnake.fromJson(Map<String, dynamic> json) =>
      _$UnionValueCaseSnakeFromJson(json);
}

@Freezed(unionValueCase: FreezedUnionCase.screamingSnake)
abstract class UnionValueCaseScreamingSnake
    with _$UnionValueCaseScreamingSnake {
  const factory UnionValueCaseScreamingSnake.first(int a) =
      _UnionValueCaseScreamingSnakeFirst;
  const factory UnionValueCaseScreamingSnake.secondValue(int a) =
      _UnionValueCaseScreamingSnakeSecondValue;

  factory UnionValueCaseScreamingSnake.fromJson(Map<String, dynamic> json) =>
      _$UnionValueCaseScreamingSnakeFromJson(json);
}

@Freezed(unionKey: 'runtimeType')
abstract class RuntimeTypeKey with _$RuntimeTypeKey {
  const factory RuntimeTypeKey.first(int a) = _RuntimeTypeKeyFirst;
  const factory RuntimeTypeKey.second(int a) = _RuntimeTypeKeySecond;

  factory RuntimeTypeKey.fromJson(Map<String, dynamic> json) =>
      _$RuntimeTypeKeyFromJson(json);
}

@Freezed(unionKey: r'$runtimeType')
abstract class RawRuntimeTypeKey with _$RawRuntimeTypeKey {
  const factory RawRuntimeTypeKey.first(int a) = _RawRuntimeTypeKeyFirst;
  const factory RawRuntimeTypeKey.second(int a) = _RawRuntimeTypeKeySecond;

  factory RawRuntimeTypeKey.fromJson(Map<String, dynamic> json) =>
      _$RawRuntimeTypeKeyFromJson(json);
}

@Freezed(unionKey: 'run"\'timeType')
abstract class FancyRuntimeTypeKey with _$FancyRuntimeTypeKey {
  const factory FancyRuntimeTypeKey.first(int a) = _FancyRuntimeTypeKeyFirst;
  const factory FancyRuntimeTypeKey.second(int a) = _FancyRuntimeTypeKeySecond;

  factory FancyRuntimeTypeKey.fromJson(Map<String, dynamic> json) =>
      _$FancyRuntimeTypeKeyFromJson(json);
}

@Freezed(unionKey: 'runtimeType')
abstract class RuntimeTypeUnrecognizedKeys with _$RuntimeTypeUnrecognizedKeys {
  @JsonSerializable(disallowUnrecognizedKeys: true)
  const factory RuntimeTypeUnrecognizedKeys.first(int a) =
      _RuntimeTypeUnrecognizedKeysFirst;
  @JsonSerializable(disallowUnrecognizedKeys: true)
  const factory RuntimeTypeUnrecognizedKeys.second(int a) =
      _RuntimeTypeUnrecognizedKeysSecond;

  factory RuntimeTypeUnrecognizedKeys.fromJson(Map<String, dynamic> json) =>
      _$RuntimeTypeUnrecognizedKeysFromJson(json);
}

@Freezed(unionKey: r'$runtimeType')
abstract class RuntimeTypeRawCustomKey with _$RuntimeTypeRawCustomKey {
  @JsonSerializable(disallowUnrecognizedKeys: true)
  const factory RuntimeTypeRawCustomKey.first(int a) =
      _RuntimeTypeRawCustomKeyFirst;
  @JsonSerializable(disallowUnrecognizedKeys: true)
  const factory RuntimeTypeRawCustomKey.second(int a) =
      _RuntimeTypeRawCustomKeySecond;

  factory RuntimeTypeRawCustomKey.fromJson(Map<String, dynamic> json) =>
      _$RuntimeTypeRawCustomKeyFromJson(json);
}

@Freezed(unionKey: 'ty"\'pe')
abstract class UnrecognizedKeysFancyCustomKey
    with _$UnrecognizedKeysFancyCustomKey {
  @JsonSerializable(disallowUnrecognizedKeys: true)
  const factory UnrecognizedKeysFancyCustomKey.first(int a) =
      _UnrecognizedKeysFancyCustomKeyFirst;
  @JsonSerializable(disallowUnrecognizedKeys: true)
  const factory UnrecognizedKeysFancyCustomKey.second(int a) =
      _UnrecognizedKeysFancyCustomKeySecond;

  factory UnrecognizedKeysFancyCustomKey.fromJson(Map<String, dynamic> json) =>
      _$UnrecognizedKeysFancyCustomKeyFromJson(json);
}

@Freezed(unionKey: r'$type')
abstract class UnrecognizedKeysRawCustomKey
    with _$UnrecognizedKeysRawCustomKey {
  @JsonSerializable(disallowUnrecognizedKeys: true)
  const factory UnrecognizedKeysRawCustomKey.first(int a) =
      _UnrecognizedKeysRawCustomKeyFirst;
  @JsonSerializable(disallowUnrecognizedKeys: true)
  const factory UnrecognizedKeysRawCustomKey.second(int a) =
      _UnrecognizedKeysRawCustomKeySecond;

  factory UnrecognizedKeysRawCustomKey.fromJson(Map<String, dynamic> json) =>
      _$UnrecognizedKeysRawCustomKeyFromJson(json);
}

@Freezed(unionKey: 'type')
abstract class UnrecognizedKeysCustomKey with _$UnrecognizedKeysCustomKey {
  @JsonSerializable(disallowUnrecognizedKeys: true)
  const factory UnrecognizedKeysCustomKey.first(int a) =
      _UnrecognizedKeysCustomKeyFirst;
  @JsonSerializable(disallowUnrecognizedKeys: true)
  const factory UnrecognizedKeysCustomKey.second(int a) =
      _UnrecognizedKeysCustomKeySecond;

  factory UnrecognizedKeysCustomKey.fromJson(Map<String, dynamic> json) =>
      _$UnrecognizedKeysCustomKeyFromJson(json);
}

@freezed
abstract class UnrecognizedKeysCustomUnionValue
    with _$UnrecognizedKeysCustomUnionValue {
  @JsonSerializable(disallowUnrecognizedKeys: true)
  const factory UnrecognizedKeysCustomUnionValue.first(int a) =
      _UnrecognizedKeysCustomUnionValueFirst;

  @JsonSerializable(disallowUnrecognizedKeys: true)
  @FreezedUnionValue('SECOND')
  const factory UnrecognizedKeysCustomUnionValue.second(int a) =
      UnrecognizedKeys_CustomUnionValueSecond;

  factory UnrecognizedKeysCustomUnionValue.fromJson(
          Map<String, dynamic> json) =>
      _$UnrecognizedKeysCustomUnionValueFromJson(json);
}

@Freezed(fallbackUnion: 'fallback')
abstract class UnrecognizedKeysUnionFallback
    with _$UnrecognizedKeysUnionFallback {
  @JsonSerializable(disallowUnrecognizedKeys: true)
  const factory UnrecognizedKeysUnionFallback.first(int a) =
      _UnrecognizedKeysUnionFallbackFirst;
  @JsonSerializable(disallowUnrecognizedKeys: true)
  const factory UnrecognizedKeysUnionFallback.second(int a) =
      _UnrecognizedKeysUnionFallbackSecond;
  @JsonSerializable(disallowUnrecognizedKeys: true)
  const factory UnrecognizedKeysUnionFallback.fallback(int a) =
      _UnrecognizedKeysUnionFallbackFallback;

  factory UnrecognizedKeysUnionFallback.fromJson(Map<String, dynamic> json) =>
      _$UnrecognizedKeysUnionFallbackFromJson(json);
}

@Freezed(fallbackUnion: 'default')
abstract class UnrecognizedKeysUnionDefaultFallback
    with _$UnrecognizedKeysUnionDefaultFallback {
  @JsonSerializable(disallowUnrecognizedKeys: true)
  const factory UnrecognizedKeysUnionDefaultFallback(int a) =
      _UnrecognizedKeysUnionDefaultFallback;
  @JsonSerializable(disallowUnrecognizedKeys: true)
  const factory UnrecognizedKeysUnionDefaultFallback.first(int a) =
      _UnrecognizedKeysUnionDefaultFallbackFirst;
  @JsonSerializable(disallowUnrecognizedKeys: true)
  const factory UnrecognizedKeysUnionDefaultFallback.second(int a) =
      _UnrecognizedKeysUnionDefaultFallbackSecond;

  factory UnrecognizedKeysUnionDefaultFallback.fromJson(
          Map<String, dynamic> json) =>
      _$UnrecognizedKeysUnionDefaultFallbackFromJson(json);
}

@Freezed(unionValueCase: FreezedUnionCase.pascal)
abstract class UnrecognizedKeysUnionValueCasePascal
    with _$UnrecognizedKeysUnionValueCasePascal {
  @JsonSerializable(disallowUnrecognizedKeys: true)
  const factory UnrecognizedKeysUnionValueCasePascal.first(int a) =
      _UnrecognizedKeysUnionValueCasePascalFirst;
  @JsonSerializable(disallowUnrecognizedKeys: true)
  const factory UnrecognizedKeysUnionValueCasePascal.secondValue(int a) =
      _UnrecognizedKeysUnionValueCasePascalSecondValue;

  factory UnrecognizedKeysUnionValueCasePascal.fromJson(
          Map<String, dynamic> json) =>
      _$UnrecognizedKeysUnionValueCasePascalFromJson(json);
}

@Freezed(unionValueCase: FreezedUnionCase.kebab)
abstract class UnrecognizedKeysUnionValueCaseKebab
    with _$UnrecognizedKeysUnionValueCaseKebab {
  @JsonSerializable(disallowUnrecognizedKeys: true)
  const factory UnrecognizedKeysUnionValueCaseKebab.first(int a) =
      _UnrecognizedKeysUnionValueCaseKebabFirst;
  @JsonSerializable(disallowUnrecognizedKeys: true)
  const factory UnrecognizedKeysUnionValueCaseKebab.secondValue(int a) =
      _UnrecognizedKeysUnionValueCaseKebabSecondValue;

  factory UnrecognizedKeysUnionValueCaseKebab.fromJson(
          Map<String, dynamic> json) =>
      _$UnrecognizedKeysUnionValueCaseKebabFromJson(json);
}

@Freezed(unionValueCase: FreezedUnionCase.snake)
abstract class UnrecognizedKeysUnionValueCaseSnake
    with _$UnrecognizedKeysUnionValueCaseSnake {
  @JsonSerializable(disallowUnrecognizedKeys: true)
  const factory UnrecognizedKeysUnionValueCaseSnake.first(int a) =
      _UnrecognizedKeysUnionValueCaseSnakeFirst;
  @JsonSerializable(disallowUnrecognizedKeys: true)
  const factory UnrecognizedKeysUnionValueCaseSnake.secondValue(int a) =
      _UnrecognizedKeysUnionValueCaseSnakeSecondValue;

  factory UnrecognizedKeysUnionValueCaseSnake.fromJson(
          Map<String, dynamic> json) =>
      _$UnrecognizedKeysUnionValueCaseSnakeFromJson(json);
}

@Freezed(unionValueCase: FreezedUnionCase.screamingSnake)
abstract class UnrecognizedKeysUnionValueCaseScreamingSnake
    with _$UnrecognizedKeysUnionValueCaseScreamingSnake {
  @JsonSerializable(disallowUnrecognizedKeys: true)
  const factory UnrecognizedKeysUnionValueCaseScreamingSnake.first(int a) =
      _UnrecognizedKeysUnionValueCaseScreamingSnakeFirst;
  @JsonSerializable(disallowUnrecognizedKeys: true)
  const factory UnrecognizedKeysUnionValueCaseScreamingSnake.secondValue(
      int a) = _UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValue;

  factory UnrecognizedKeysUnionValueCaseScreamingSnake.fromJson(
          Map<String, dynamic> json) =>
      _$UnrecognizedKeysUnionValueCaseScreamingSnakeFromJson(json);
}

@freezed
abstract class Single with _$Single {
  const factory Single(int a) = _Single;

  factory Single.fromJson(Map<String, dynamic> json) => _$SingleFromJson(json);
}

@freezed
abstract class Json with _$Json {
  const factory Json() = JsonDefault;
  const factory Json.first(String a) = First;
  const factory Json.second(int b) = Second;

  factory Json.fromJson(Map<String, dynamic> json) => _$JsonFromJson(json);
}

@freezed
abstract class NoJson with _$NoJson {
  const factory NoJson() = NoDefault;
  const factory NoJson.first(String a) = NoFirst;
  const factory NoJson.second(int b) = NoSecond;
}

@freezed
abstract class Decorator with _$Decorator {
  factory Decorator(@JsonKey(name: 'what') String a) = _Decorator;

  factory Decorator.fromJson(Map<String, dynamic> json) =>
      _$DecoratorFromJson(json);
}

@freezed
abstract class Generic<T> with _$Generic<T> {
  factory Generic(@DataConverter() T a) = _Generic<T>;

  factory Generic.fromJson(Map<String, dynamic> json) =>
      _$GenericFromJson<T>(json);
}

class DataConverter<T extends Object?> implements JsonConverter<T, Object?> {
  const DataConverter();

  @override
  T fromJson(Object? json) {
    return json as T;
  }

  @override
  Object? toJson(T object) {
    return object;
  }
}

@freezed
abstract class DefaultValue with _$DefaultValue {
  factory DefaultValue([@Default(42) int value]) = _DefaultValue;

  factory DefaultValue.fromJson(Map<String, dynamic> json) =>
      _$DefaultValueFromJson(json);
}

@freezed
abstract class DefaultValueJsonKey with _$DefaultValueJsonKey {
  factory DefaultValueJsonKey([
    @Default(42) @JsonKey(defaultValue: 21) int value,
  ]) = _DefaultValueJsonKey;

  factory DefaultValueJsonKey.fromJson(Map<String, dynamic> json) =>
      _$DefaultValueJsonKeyFromJson(json);
}

@freezed
abstract class ClassDecorator with _$ClassDecorator {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ClassDecorator(String complexName) = ClassDecoratorDefault;

  factory ClassDecorator.fromJson(Map<String, dynamic> json) =>
      _$ClassDecoratorFromJson(json);
}

@freezed
abstract class DurationValue with _$DurationValue {
  const factory DurationValue(Duration complexName) = DurationValueDefault;

  factory DurationValue.fromJson(Map<String, dynamic> json) =>
      _$DurationValueFromJson(json);
}

@JsonEnum(alwaysCreate: true, fieldRename: FieldRename.kebab)
enum StandAloneEnum {
  expected,
  specialResult,
  @JsonValue('unknown')
  unknownResult,
}

Iterable<String> get standAloneEnumValues => _$StandAloneEnumEnumMap.values;

@JsonEnum()
enum Enum {
  alpha,
  beta,
  gamma,
}

@freezed
abstract class EnumJson with _$EnumJson {
  factory EnumJson({
    @JsonKey(
      disallowNullValue: true,
      required: true,
      unknownEnumValue: JsonKey.nullForUndefinedEnumValue,
    )
    Enum? status,
  }) = _EnumJson;

  factory EnumJson.fromJson(Map<String, dynamic> json) =>
      _$EnumJsonFromJson(json);
}

@Freezed(genericArgumentFactories: true)
abstract class GenericWithArgumentFactories<T>
    with _$GenericWithArgumentFactories<T> {
  factory GenericWithArgumentFactories(T value, String value2) =
      _GenericWithArgumentFactories<T>;

  factory GenericWithArgumentFactories.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$GenericWithArgumentFactoriesFromJson<T>(json, fromJsonT);
}

@Freezed(genericArgumentFactories: true)
abstract class GenericTupleWithArgumentFactories<T, S>
    with _$GenericTupleWithArgumentFactories<T, S> {
  factory GenericTupleWithArgumentFactories(
    T value1,
    S value2,
    String value3,
  ) = _GenericTupleWithArgumentFactories<T, S>;

  factory GenericTupleWithArgumentFactories.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
    S Function(Object? json) fromJsonS,
  ) =>
      _$GenericTupleWithArgumentFactoriesFromJson(json, fromJsonT, fromJsonS);
}

@Freezed(genericArgumentFactories: true)
abstract class GenericMultiCtorWithArgumentFactories<T, S>
    with _$GenericMultiCtorWithArgumentFactories<T, S> {
  factory GenericMultiCtorWithArgumentFactories(
    T first,
    S second,
    String another,
  ) = _GenericMultiCtorWithArgumentFactories<T, S>;

  factory GenericMultiCtorWithArgumentFactories.first(T first, String another) =
      _GenericMultiCtorWithArgumentFactoriesVal<T, S>;

  factory GenericMultiCtorWithArgumentFactories.second(
    S second,
    String another,
  ) = _GenericMultiCtorWithArgumentFactoriesSec<T, S>;

  factory GenericMultiCtorWithArgumentFactories.both(
    T first,
    S second,
    String another,
  ) = _GenericMultiCtorWithArgumentFactoriesBoth<T, S>;

  factory GenericMultiCtorWithArgumentFactories.none(String another) =
      _GenericMultiCtorWithArgumentFactoriesNone<T, S>;

  factory GenericMultiCtorWithArgumentFactories.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
    S Function(Object? json) fromJsonS,
  ) =>
      _$GenericMultiCtorWithArgumentFactoriesFromJson<T, S>(
        json,
        fromJsonT,
        fromJsonS,
      );
}
