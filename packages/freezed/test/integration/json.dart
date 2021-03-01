import 'package:freezed_annotation/freezed_annotation.dart';

part 'json.freezed.dart';
part 'json.g.dart';

// regression test for https://github.com/rrousselGit/freezed/issues/351
@freezed
class Regression351 with _$Regression351 {
  factory Regression351({
    @JsonKey(name: 'total_results') required int totalResults,
  }) = _Regression351;

  factory Regression351.fromJson(Map<String, dynamic> json) =>
      _$Regression351FromJson(json);
}

// regression test for https://github.com/rrousselGit/freezed/issues/323
@freezed
class Regression323 with _$Regression323 {
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
class Regression280 with _$Regression280 {
  const factory Regression280(String label) = _Regression280;

  factory Regression280.fromJson(Map<String, dynamic> val) {
    return Regression280(val['foo'] as String);
  }
}

@freezed
class Regression280n2 with _$Regression280n2 {
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
class CustomJson with _$CustomJson {
  const factory CustomJson(String label) = _CustomJson;

  factory CustomJson.fromJson(Map<String, dynamic> json) => _fromJson(json);
}

@Freezed(unionKey: 'ty"\'pe')
class FancyCustomKey with _$FancyCustomKey {
  const factory FancyCustomKey.first(int a) = _FancyCustomKeyFirst;
  const factory FancyCustomKey.second(int a) = _FancyCustomKeySecond;

  factory FancyCustomKey.fromJson(Map<String, dynamic> json) =>
      _$FancyCustomKeyFromJson(json);
}

@Freezed(unionKey: r'$type')
class RawCustomKey with _$RawCustomKey {
  const factory RawCustomKey.first(int a) = _RawCustomKeyFirst;
  const factory RawCustomKey.second(int a) = _RawCustomKeySecond;

  factory RawCustomKey.fromJson(Map<String, dynamic> json) =>
      _$RawCustomKeyFromJson(json);
}

@Freezed(unionKey: 'type')
class CustomKey with _$CustomKey {
  const factory CustomKey.first(int a) = _CustomKeyFirst;
  const factory CustomKey.second(int a) = _CustomKeySecond;

  factory CustomKey.fromJson(Map<String, dynamic> json) =>
      _$CustomKeyFromJson(json);
}

@freezed
class CustomUnionValue with _$CustomUnionValue {
  const factory CustomUnionValue.first(int a) = _CustomUnionValueFirst;

  @FreezedUnionValue('SECOND')
  const factory CustomUnionValue.second(int a) = _CustomUnionValueSecond;

  factory CustomUnionValue.fromJson(Map<String, dynamic> json) =>
      _$CustomUnionValueFromJson(json);
}

@Freezed(unionValueCase: FreezedUnionCase.pascal)
class UnionValueCasePascal with _$UnionValueCasePascal {
  const factory UnionValueCasePascal.first(int a) = _UnionValueCasePascalFirst;
  const factory UnionValueCasePascal.secondValue(int a) =
      _UnionValueCasePascalSecondValue;

  factory UnionValueCasePascal.fromJson(Map<String, dynamic> json) =>
      _$UnionValueCasePascalFromJson(json);
}

@Freezed(unionValueCase: FreezedUnionCase.kebab)
class UnionValueCaseKebab with _$UnionValueCaseKebab {
  const factory UnionValueCaseKebab.first(int a) = _UnionValueCaseKebabFirst;
  const factory UnionValueCaseKebab.secondValue(int a) =
      _UnionValueCaseKebabSecondValue;

  factory UnionValueCaseKebab.fromJson(Map<String, dynamic> json) =>
      _$UnionValueCaseKebabFromJson(json);
}

@Freezed(unionValueCase: FreezedUnionCase.snake)
class UnionValueCaseSnake with _$UnionValueCaseSnake {
  const factory UnionValueCaseSnake.first(int a) = _UnionValueCaseSnakeFirst;
  const factory UnionValueCaseSnake.secondValue(int a) =
      _UnionValueCaseSnakeSecondValue;

  factory UnionValueCaseSnake.fromJson(Map<String, dynamic> json) =>
      _$UnionValueCaseSnakeFromJson(json);
}

@freezed
class Single with _$Single {
  const factory Single(int a) = _Single;

  factory Single.fromJson(Map<String, dynamic> json) => _$SingleFromJson(json);
}

@freezed
class Json with _$Json {
  const factory Json() = JsonDefault;
  const factory Json.first(String a) = First;
  const factory Json.second(int b) = Second;

  factory Json.fromJson(Map<String, dynamic> json) => _$JsonFromJson(json);
}

@freezed
class NoJson with _$NoJson {
  const factory NoJson() = NoDefault;
  const factory NoJson.first(String a) = NoFirst;
  const factory NoJson.second(int b) = NoSecond;
}

@freezed
class Decorator with _$Decorator {
  factory Decorator(@JsonKey(name: 'what') String a) = _Decorator;

  factory Decorator.fromJson(Map<String, dynamic> json) =>
      _$DecoratorFromJson(json);
}

@freezed
class Generic<T> with _$Generic<T> {
  factory Generic(@DataConverter() T a) = _Generic<T>;

  factory Generic.fromJson(Map<String, dynamic> json) =>
      _$GenericFromJson<T>(json);
}

class DataConverter<T> implements JsonConverter<T, Object?> {
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
class DefaultValue with _$DefaultValue {
  factory DefaultValue([@Default(42) int value]) = _DefaultValue;

  factory DefaultValue.fromJson(Map<String, dynamic> json) =>
      _$DefaultValueFromJson(json);
}

@freezed
class DefaultValueJsonKey with _$DefaultValueJsonKey {
  factory DefaultValueJsonKey([
    @Default(42) @JsonKey(defaultValue: 21) int value,
  ]) = _DefaultValueJsonKey;

  factory DefaultValueJsonKey.fromJson(Map<String, dynamic> json) =>
      _$DefaultValueJsonKeyFromJson(json);
}

@freezed
class ClassDecorator with _$ClassDecorator {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ClassDecorator(String complexName) = ClassDecoratorDefault;

  factory ClassDecorator.fromJson(Map<String, dynamic> json) =>
      _$ClassDecoratorFromJson(json);
}

@freezed
class DurationValue with _$DurationValue {
  const factory DurationValue(Duration complexName) = DurationValueDefault;

  factory DurationValue.fromJson(Map<String, dynamic> json) =>
      _$DurationValueFromJson(json);
}

@freezed
class GenericValue with _$GenericValue {
  const factory GenericValue(String name) = _GenericValue;
  factory GenericValue.fromJson(Map<String, dynamic> json) =>
      _$GenericValueFromJson(json);
}

@freezed
class GenericName with _$GenericName {
  const factory GenericName(String name) = _GenericName;
  factory GenericName.fromJson(Map<String, dynamic> json) =>
      _$GenericNameFromJson(json);
}

@freezed
class Generic2<T> with _$Generic2<T> {
  @JsonSerializable(genericArgumentFactories: true)
  factory Generic2(T value, String another) = _Generic2<T>;

  factory Generic2.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$Generic2FromJson<T>(json, fromJsonT);
}

@freezed
class Generic3<T, S> with _$Generic3<T, S> {
  @JsonSerializable(genericArgumentFactories: true)
  factory Generic3(T value, S second, String another) = _Generic3<T, S>;

  factory Generic3.fromJson(
          Map<String, dynamic> json,
          T Function(Object? json) fromJsonT,
          S Function(Object? json) fromJsonS) =>
      _$Generic3FromJson<T, S>(json, fromJsonT, fromJsonS);
}

@freezed
class Generic4<T, S> with _$Generic4<T, S> {
  @JsonSerializable(genericArgumentFactories: true)
  factory Generic4(T value, S second, String another) = _Generic4<T, S>;

  @JsonSerializable(genericArgumentFactories: true)
  factory Generic4.val(T value, String another) = _Generic4Val<T, S>;

  @JsonSerializable(genericArgumentFactories: true)
  factory Generic4.sec(S second, String another) = _Generic4Sec<T, S>;

  @JsonSerializable(genericArgumentFactories: true)
  factory Generic4.both(T value, S second, String another) =
      _Generic4Both<T, S>;

  @JsonSerializable(genericArgumentFactories: true)
  factory Generic4.none(String another) = _Generic4None<T, S>;

  factory Generic4.fromJson(
          Map<String, dynamic> json,
          T Function(Object? json) fromJsonT,
          S Function(Object? json) fromJsonS) =>
      _$Generic4FromJson<T, S>(json, fromJsonT, fromJsonS);
}

@freezed
class Generic5<T> with _$Generic5<T> {
  @JsonSerializable(genericArgumentFactories: true)
  factory Generic5({required T value, required String another}) = _Generic5<T>;

  factory Generic5.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$Generic5FromJson<T>(json, fromJsonT);
}

@freezed
class GenericTuple<T, S> with _$GenericTuple<T, S> {
  @JsonSerializable(genericArgumentFactories: true)
  factory GenericTuple(T value1, S value2, String value3) = _GenericTuple<T, S>;

  factory GenericTuple.fromJson(
          Map<String, dynamic> json,
          T Function(Object? json) fromJsonT,
          S Function(Object? json) fromJsonS) =>
      _$GenericTupleFromJson(json, fromJsonT, fromJsonS);
}

void main() {
  print(Generic2.fromJson(
    <String, Object>{
      'value': <String, String>{'name': 'hola'},
      'another': 'world'
    },
    (json) => GenericValue.fromJson(json as Map<String, dynamic>),
  ));

  final gen3 = Generic3.fromJson(
    <String, Object>{
      'value': <String, String>{'name': 'hola'},
      'second': <String, String>{'name': 'bonjour'},
      'another': 'world',
    },
    (json) => GenericValue.fromJson(json as Map<String, dynamic>),
    (json) => json is Map<String, dynamic>
        ? GenericName.fromJson(json)
        : const GenericName('default'),
  );

  print(gen3);

  print(gen3.toJson((value) => value.toJson(), (value) => value.toJson()));

  print(GenericTuple.fromJson(
    <String, Object>{
      'value1': 1,
      'value2': 'Value 2',
      'value3': 'Bonjour',
    },
    (json) => json as int,
    (json) => json as String,
  ));

  print(GenericTuple(1, 'Value 2', 'Always string').toJson(
    (value) => value,
    (value) => value,
  ));
}
