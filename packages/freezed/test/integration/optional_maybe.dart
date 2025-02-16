import 'package:freezed_annotation/freezed_annotation.dart';

part 'optional_maybe.freezed.dart';
part 'optional_maybe.g.dart';

@Freezed(copyWith: false)
abstract class OptionalCopyWith with _$OptionalCopyWith {
  const factory OptionalCopyWith([int? a]) = _OptionalCopyWith;
}

@Freezed(toStringOverride: false)
class OptionalToString with _$OptionalToString {
  const factory OptionalToString() = _OptionalToString;
}

@Freezed(equal: false)
class OptionalEqual with _$OptionalEqual {
  factory OptionalEqual() = _OptionalEqual;
}

@Freezed(toJson: false)
class OptionalToJson with _$OptionalToJson {
  factory OptionalToJson() = _OptionalToJson;

  factory OptionalToJson.fromJson(Map<String, Object?> json) =>
      _$OptionalToJsonFromJson(json);
}

@Freezed(toJson: true)
abstract class ForceToJson with _$ForceToJson {
  factory ForceToJson(int a) = _ForceToJson;
}
