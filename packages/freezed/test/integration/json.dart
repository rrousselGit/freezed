import 'package:freezed_annotation/freezed_annotation.dart';

part 'json.freezed.dart';
part 'json.g.dart';

@freezed
abstract class Single with _$Single {
  const factory Single(int a) = _Single;

  factory Single.fromJson(Map<String, dynamic> json) => _$SingleFromJson(json);
}

@freezed
abstract class Json with _$Json {
  const factory Json() = Default;
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

class DataConverter<T> implements JsonConverter<T, Object> {
  const DataConverter();

  @override
  T fromJson(Object json) {
    return json as T;
  }

  @override
  Object toJson(T object) {
    return object;
  }
}
