import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json.freezed.dart';
part 'json.g.dart';

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
