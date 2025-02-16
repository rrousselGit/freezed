// ignore_for_file: unused_element

import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
// expect_lint: freezed_missing_private_empty_constructor
class RequiresPrivateCtor with _$RequiresPrivateCtor {
  const factory RequiresPrivateCtor() = _RequiresPrivateCtor;

  void method() {
    print('hello world');
  }
}

@freezed
abstract class HasPrivateCtor with _$HasPrivateCtor {
  const HasPrivateCtor._();

  const factory HasPrivateCtor() = _HasPrivateCtor;

  void method() {
    print('hello world');
  }
}

@freezed
// expect_lint: freezed_missing_private_empty_constructor
class HasAccessor with _$HasAccessor {
  const factory HasAccessor(int id) = _HasAccessor;

  String get idString => id.toString();
}

abstract class IdClass {
  int get id;
}

mixin IdMixin {
  int get id;
}

@freezed
abstract class WithIdMixin with _$WithIdMixin, IdMixin {
  const factory WithIdMixin(int id) = _WithIdMixin;
}

@freezed
// expect_lint: freezed_missing_private_empty_constructor
class ExtendsIdClass extends IdClass with _$ExtendsIdClass {
  // ExtendsIdClass._();
  const factory ExtendsIdClass(int id) = _ExtendsIdClass;

  @override
  int get id => id;
}

@freezed
abstract class WithStaticElements with _$WithStaticElements {
  static String field = 'field';

  static String get accessor => 'accessor';

  static String method() => 'method';

  const factory WithStaticElements() = _WithStaticElements;
}

// fake generated code:

mixin _$RequiresPrivateCtor {}
mixin _$HasPrivateCtor {}
mixin _$HasAccessor {
  int get id => throw UnimplementedError();
}
mixin _$WithIdMixin {
  int get id => throw UnimplementedError();
}
mixin _$ExtendsIdClass {}
mixin _$WithStaticElements {}

class _RequiresPrivateCtor implements RequiresPrivateCtor {
  const _RequiresPrivateCtor();
  @override
  void method() {}
}

class _HasPrivateCtor implements HasPrivateCtor {
  const _HasPrivateCtor();
  @override
  void method() {}
}

class _HasAccessor implements HasAccessor {
  const _HasAccessor(this.id);
  final int id;
  @override
  String get idString => throw UnimplementedError();
}

class _WithIdMixin implements WithIdMixin {
  const _WithIdMixin(int id);
  @override
  int get id => throw UnimplementedError();
}

class _ExtendsIdClass implements ExtendsIdClass {
  const _ExtendsIdClass(int id);
  @override
  int get id => throw UnimplementedError();
}

class _WithStaticElements implements WithStaticElements {
  const _WithStaticElements();
}
