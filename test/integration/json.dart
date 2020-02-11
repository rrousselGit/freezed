import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json.freezed.dart';
part 'json.g.dart';

@immutable
abstract class Single with _$Single {
  const factory Single(int a) = _Single;

  factory Single.fromJson(Map<String, dynamic> json) => _$SingleFromJson(json);
}

@immutable
abstract class Json with _$Json {
  const factory Json() = Default;
  const factory Json.first(String a) = First;
  const factory Json.second(int b) = Second;

  factory Json.fromJson(Map<String, dynamic> json) => _$JsonFromJson(json);
}

@immutable
abstract class NoJson with _$NoJson {
  const factory NoJson() = NoDefault;
  const factory NoJson.first(String a) = NoFirst;
  const factory NoJson.second(int b) = NoSecond;
}

@immutable
abstract class Decorator with _$Decorator {
  factory Decorator(@JsonKey(name: 'what') String a) = _Decorator;

  factory Decorator.fromJson(Map<String, dynamic> json) => _$DecoratorFromJson(json);
}
