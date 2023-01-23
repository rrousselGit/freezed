import 'package:freezed_annotation/freezed_annotation.dart';

part 'missing_mixin.freezed.dart';

@freezed
// expect_lint: freezed_missing_mixin
class MissingMixin {
  const factory MissingMixin() = _MissingMixin;
}

@freezed
class WithMixin with _$WithMixin {
  const factory WithMixin() = _WithMixin;
}
