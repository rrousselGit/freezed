import 'package:freezed_annotation/freezed_annotation.dart';

part 'optionnal_maybe.freezed.dart';

// ignore: deprecated_member_use
@Freezed(maybeMap: false)
class OptionnalMaybeMap with _$OptionnalMaybeMap {
  const factory OptionnalMaybeMap.first() = OptionnalMaybeMap1;
  const factory OptionnalMaybeMap.second() = OptionnalMaybeMap2;
}

// ignore: deprecated_member_use
@Freezed(maybeWhen: false)
class OptionnalMaybeWhen with _$OptionnalMaybeWhen {
  const factory OptionnalMaybeWhen.first() = OptionnalMaybeWhen1;
  const factory OptionnalMaybeWhen.second() = OptionnalMaybeWhen2;
}
