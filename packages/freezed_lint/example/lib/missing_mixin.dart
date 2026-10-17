import 'package:freezed_annotation/freezed_annotation.dart';

part 'missing_mixin.freezed.dart';

@freezed
abstract class WithMixin with _$WithMixin {
  const factory WithMixin() = _WithMixin;
}

mixin SomeMixin {
  int get id;
}

@freezed
abstract class BarModel with _$BarModel, SomeMixin {
  const BarModel._();

  const factory BarModel(int id) = _BarModel;
}
