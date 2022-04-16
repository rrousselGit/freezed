import 'package:freezed_annotation/freezed_annotation.dart';

part 'optionnal_maybe.freezed.dart';
part 'optionnal_maybe.g.dart';

@Freezed(map: FreezedMap.none)
class OptionnalMaybeMap with _$OptionnalMaybeMap {
  const factory OptionnalMaybeMap.first() = OptionnalMaybeMap1;
  const factory OptionnalMaybeMap.second() = OptionnalMaybeMap2;
}

@Freezed(when: FreezedWhen.none)
class OptionnalMaybeWhen with _$OptionnalMaybeWhen {
  const factory OptionnalMaybeWhen.first() = OptionnalMaybeWhen1;
  const factory OptionnalMaybeWhen.second() = OptionnalMaybeWhen2;
}

@Freezed(copyWith: false)
class OptionalCopyWith with _$OptionalCopyWith {
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

@Freezed(map: FreezedMap.all, when: FreezedWhen.all)
class ForceUnionMethod with _$ForceUnionMethod {
  factory ForceUnionMethod() = _ForceUnionMethod;
}

@Freezed(map: FreezedMap.all, when: FreezedWhen.all)
class ForceUnionMethod2 with _$ForceUnionMethod2 {
  factory ForceUnionMethod2.two() = _ForceUnionMethod2;
}

@Freezed(toJson: false)
class OptionalToJson with _$OptionalToJson {
  factory OptionalToJson() = _OptionalToJson;

  factory OptionalToJson.fromJson(Map<String, Object?> json) =>
      _$OptionalToJsonFromJson(json);
}

@Freezed(toJson: true)
class ForceToJson with _$ForceToJson {
  factory ForceToJson(int a) = _ForceToJson;
}
