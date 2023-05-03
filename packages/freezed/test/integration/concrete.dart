import 'package:freezed_annotation/freezed_annotation.dart';

part 'concrete.freezed.dart';

@freezed
class EmptyExtends extends Empty with _$EmptyExtends {
  factory EmptyExtends(int value) = _EmptyExtends;
}

class Empty {
  const Empty();
}

@freezed
class Concrete extends A with _$Concrete {
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
class EmptyConcrete extends Empty with _$EmptyConcrete {
  EmptyConcrete._();
  factory EmptyConcrete() = _EmptyConcrete;
}

@freezed
class ConstConcrete extends Empty with _$ConstConcrete {
  const ConstConcrete._();
  const factory ConstConcrete() = _ConstConcrete;
}

@freezed
class MixedIn with _$MixedIn, Mixin {
  MixedIn._();
  factory MixedIn() = _MixedIn;
}

mixin Mixin {
  int method() => 42;
}

@freezed
class ConcreteGetter with _$ConcreteGetter {
  const ConcreteGetter._();
  const factory ConcreteGetter() = _ConcreteGetter;

  int get getter => 42;
}

@freezed
class CustomToString with _$CustomToString {
  CustomToString._();
  factory CustomToString() = _CustomToString;

  @override
  String toString() {
    return '42';
  }
}

@freezed
class MixedInToString with _$MixedInToString, ToStringMixin {
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
class BaseToString extends AbstractToString with _$BaseToString {
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
class Const with _$Const {
  const Const._();
  const factory Const(int a) = _Const;
}

@freezed
class Dollar with _$Dollar {
  const factory Dollar({
    required String $test,
  }) = _DollarStartWithDollar;
}

/// Middle with $
@freezed
class DollarMiddle with _$DollarMiddle {
  const factory DollarMiddle({
    required String te$st,
  }) = _DollarMiddleMiddleWithDollar;
}

/// End with $
@freezed
class DollarEnd with _$DollarEnd {
  const factory DollarEnd({
    required String test$,
  }) = _DollarEndEndWithDollar;
}

/// class with $
@freezed
class $DollarClass with _$$DollarClass {
  const factory $DollarClass() = _DollarClassWithDollar;
}

/// class contructor with $
@freezed
class DollarFactory with _$DollarFactory {
  const factory DollarFactory.$() = _DollarFactoryWithDollar;
}
