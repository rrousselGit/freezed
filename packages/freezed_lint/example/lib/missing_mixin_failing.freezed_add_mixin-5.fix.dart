// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=warning
// Offsets for "freezed_add_mixin":
// 4: // ignore: freezed_lint/freezed_missing_mixin
// 5: class <>MissingMixin {
// 6:   const factory MissingMixin() = _MissingMixin;
// ```
//
// @freezed
// - // ignore: freezed_lint/freezed_missing_mixin
// - class MissingMixin {
// + class MissingMixin with _$MissingMixin {
//   const factory MissingMixin() = _MissingMixin;
// }
// ```
import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
class MissingMixin with _$MissingMixin {
  const factory MissingMixin() = _MissingMixin;
}

mixin SomeMixin {
  int get id;
}

@freezed
// ignore: freezed_lint/freezed_missing_mixin
abstract class FooModel with SomeMixin {
  const FooModel._();

  const factory FooModel(int id) = _FooModel;
}

// fake generated code:

mixin _$MissingMixin {}

mixin _$FooModel {}

class _MissingMixin with _$MissingMixin implements MissingMixin {
  const _MissingMixin();
}

class _FooModel extends FooModel with _$FooModel {
  const _FooModel(this.id) : super._();
  @override
  final int id;
}
