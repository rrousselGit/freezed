// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=warning
// Offsets for "freezed_add_mixin":
// 14: // ignore: freezed_lint/freezed_missing_mixin
// 15: abstract class <>FooModel with SomeMixin {
// 16:   const FooModel._();
// ```
//
// @freezed
// - // ignore: freezed_lint/freezed_missing_mixin
// - abstract class FooModel with SomeMixin {
// + abstract class FooModel with SomeMixin, _$FooModel {
//   const FooModel._();
//
// ```
import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
// ignore: freezed_lint/freezed_missing_mixin
class MissingMixin {
  const factory MissingMixin() = _MissingMixin;
}

mixin SomeMixin {
  int get id;
}

@freezed
abstract class FooModel with SomeMixin, _$FooModel {
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
