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
