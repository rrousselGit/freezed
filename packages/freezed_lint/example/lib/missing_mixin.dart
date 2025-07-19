import 'package:freezed_annotation/freezed_annotation.dart';

part 'missing_mixin.freezed.dart';

@freezed
// expect_lint: freezed_missing_mixin
class MissingMixin {
  const factory MissingMixin() = _MissingMixin;
}

@freezed
abstract class WithMixin with _$WithMixin {
  const factory WithMixin() = _WithMixin;
}

mixin SomeMixin {
  int get id;
}

@freezed
// expect_lint: freezed_missing_mixin
class FooModel with SomeMixin {
  const FooModel._();

  const factory FooModel(int id) = _FooModel;

  @override
  int get id => id;
}

@freezed
abstract class BarModel with _$BarModel, SomeMixin {
  const BarModel._();

  const factory BarModel(int id) = _BarModel;

  @override
  int get id => id;
}

@freezed
class _BazModel with _$BazModel {
  const factory _BazModel() = __BazModel;
}

// fake generated code:

mixin _$BazModel {}

class __BazModel implements _BazModel {
  const __BazModel();
}
