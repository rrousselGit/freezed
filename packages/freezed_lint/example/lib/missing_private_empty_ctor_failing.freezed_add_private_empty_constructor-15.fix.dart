// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=warning
// Offsets for "freezed_add_private_empty_constructor":
// 14: // ignore: freezed_lint/freezed_missing_private_empty_constructor
// 15: class <>HasAccessor with _$HasAccessor {
// 16:   const factory HasAccessor(int id) = _HasAccessor;
// ```
//
// @freezed
// - // ignore: freezed_lint/freezed_missing_private_empty_constructor
// - class HasAccessor with _$HasAccessor {
// + class HasAccessor with _$HasAccessor {
// +   const HasAccessor._();
//   const factory HasAccessor(int id) = _HasAccessor;
//
// ```
import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
// ignore: freezed_lint/freezed_missing_private_empty_constructor
class RequiresPrivateCtor with _$RequiresPrivateCtor {
  const factory RequiresPrivateCtor() = _RequiresPrivateCtor;

  void method() {
    print('hello world');
  }
}

@freezed
class HasAccessor with _$HasAccessor {
  const HasAccessor._();
  const factory HasAccessor(int id) = _HasAccessor;

  String get idString => id.toString();
}

abstract class IdClass {
  int get id;
}

@freezed
// ignore: freezed_lint/freezed_missing_private_empty_constructor
class ExtendsIdClass extends IdClass with _$ExtendsIdClass {
  const factory ExtendsIdClass(int id) = _ExtendsIdClass;

  @override
  int get id => id;
}

mixin IdMixin {
  int get id;
}

// TODO: freezed requires a `WithIdMixin._()` constructor because of the
// extra mixin, but freezed_missing_private_empty_constructor doesn't report it.
@freezed
abstract class WithIdMixin with _$WithIdMixin, IdMixin {
  const factory WithIdMixin(int id) = _WithIdMixin;
}

// fake generated code:

mixin _$RequiresPrivateCtor {}

mixin _$HasAccessor {
  int get id => throw UnimplementedError();
}

mixin _$ExtendsIdClass {}

mixin _$WithIdMixin {
  int get id => throw UnimplementedError();
}

class _RequiresPrivateCtor implements RequiresPrivateCtor {
  const _RequiresPrivateCtor();
  @override
  void method() {}
}

class _HasAccessor implements HasAccessor {
  const _HasAccessor(this.id);
  @override
  final int id;
  @override
  String get idString => throw UnimplementedError();
}

class _ExtendsIdClass implements ExtendsIdClass {
  const _ExtendsIdClass(int id);
  @override
  int get id => throw UnimplementedError();
}

class _WithIdMixin implements WithIdMixin {
  const _WithIdMixin(this.id);
  @override
  final int id;
}
