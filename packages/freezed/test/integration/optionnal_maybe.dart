import 'package:freezed_annotation/freezed_annotation.dart';

part 'optionnal_maybe.freezed.dart';

@Freezed(shouldGenerateMaybeMap: false)
class OptionnalMaybeMap with _$OptionnalMaybeMap {
  const factory OptionnalMaybeMap.first() = OptionnalMaybeMap1;
  const factory OptionnalMaybeMap.second() = OptionnalMaybeMap2;
}

@Freezed(shouldGenerateMaybeWhen: false)
class OptionnalMaybeWhen with _$OptionnalMaybeWhen {
  const factory OptionnalMaybeWhen.first() = OptionnalMaybeWhen1;
  const factory OptionnalMaybeWhen.second() = OptionnalMaybeWhen2;
}
