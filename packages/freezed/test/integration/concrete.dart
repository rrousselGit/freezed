import 'package:freezed_annotation/freezed_annotation.dart';

part 'concrete.freezed.dart';

@freezed
abstract class EmptyExtends extends Empty with _$EmptyExtends {
  factory EmptyExtends(int value) = _EmptyExtends;
}

abstract class Empty {
  const Empty();
}

@freezed
abstract class Concrete extends A with _$Concrete {
  Concrete._();
  factory Concrete(int value) = _Concrete;
}

abstract class A {
  int get value;
  int method() {
    return 42;
  }
}

@freezed
abstract class EmptyConcrete extends Empty with _$EmptyConcrete {
  EmptyConcrete._();
  factory EmptyConcrete() = _EmptyConcrete;
}

@freezed
abstract class ConstConcrete extends Empty with _$ConstConcrete {
  const ConstConcrete._();
  const factory ConstConcrete() = _ConstConcrete;
}

@freezed
abstract class MixedIn with _$MixedIn, Mixin {
  MixedIn._();
  factory MixedIn() = _MixedIn;
}

mixin Mixin {
  int method() => 42;
}

@freezed
abstract class CustomToString with _$CustomToString {
  CustomToString._();
  factory CustomToString() = _CustomToString;

  @override
  String toString() {
    return '42';
  }
}

@freezed
abstract class MixedInToString with _$MixedInToString, ToStringMixin {
  MixedInToString._();
  factory MixedInToString() = _MixedInToString;
}

mixin ToStringMixin {
  @override
  String toString() {
    return '42';
  }
}

@freezed
abstract class BaseToString extends AbstractToString with _$BaseToString {
  BaseToString._();
  factory BaseToString() = _BaseToString;
}

abstract class AbstractToString {
  @override
  String toString() {
    return '42';
  }
}

@freezed
abstract class Const implements _$Const {
  const Const._();
  const factory Const(int a) = _Const;
}
