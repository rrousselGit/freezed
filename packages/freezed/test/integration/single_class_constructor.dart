import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

part 'single_class_constructor.freezed.dart';

/// Regression test for https://github.com/rrousselGit/freezed/issues/213
@freezed
abstract class Product with _$Product {
  const factory Product({
    String name,
    Product parent,
  }) = _ProductDataClass;
}

@freezed
abstract class Test with _$Test {
  const factory Test.something(Completer completer) = TestSomething;
}

@freezed
abstract class Private implements _$Private {
  // This is the (private) Freezed constructor
  const factory Private._internal(
    Iterable<String> items,
  ) = _Private;
}

@freezed
abstract class MyClass with _$MyClass {
  const factory MyClass({String a, int b}) = WhateverIWant;
}

@freezed
abstract class MixedParam with _$MixedParam {
  const factory MixedParam(String a, {int b}) = WhateverMixedParam;
}

@freezed
abstract class PositionalMixedParam with _$PositionalMixedParam {
  const factory PositionalMixedParam(String a, [int b]) =
      WhateverPositionalMixedParam;
}

@freezed
abstract class Required with _$Required {
  const factory Required({@required String a}) = WhateverRequired;
}

@freezed
abstract class Empty with _$Empty {
  const factory Empty() = WhateverEmpty;
}

@freezed
abstract class Empty2 with _$Empty2 {
  const factory Empty2() = WhateverEmpty2;
}

@freezed
abstract class SingleNamedCtor with _$SingleNamedCtor {
  const factory SingleNamedCtor.named(int a) = WhateverSingleNamedCtor;
}

@freezed
abstract class Generic<T> with _$Generic<T> {
  const factory Generic(T value) = A<T>;
}

@freezed
abstract class Example with _$Example {
  const factory Example(String a, {int b}) = Example0;

  factory Example.fixed() {
    return const Example('a', b: 42);
  }
}

@freezed
abstract class NoConst with _$NoConst {
  factory NoConst() = NoConstImpl;
}

// Regression test for https://github.com/rrousselGit/freezed/issues/40
@freezed
abstract class SecondState with _$SecondState {
  const factory SecondState({
    String dateTime,
    String uuid,
  }) = _SecondState;
}

// Regression test for https://github.com/rrousselGit/freezed/issues/44
@freezed
abstract class Static with _$Static {
  const factory Static() = _Static;

  static int staticVariable;

  static int get staticGetter => 0;

  static int staticMethod() => 0;
}

@freezed
abstract class Late with _$Late {
  factory Late(int value) = _Late;

  @late
  LateContainer get container => LateContainer(value);
}

class LateContainer {
  LateContainer(this.value);

  final int value;

  @override
  String toString() {
    return 'Container(value: $value)';
  }
}

@freezed
abstract class Late2 with _$Late2 {
  factory Late2(int Function() cb) = _Late2;

  @late
  int get first => cb();
}

@freezed
abstract class ComplexLate with _$ComplexLate {
  factory ComplexLate(List<int> values) = _ComplexLate;

  @late
  List<int> get odd => values.where((value) {
        if (value.isOdd)
          return true;
        else
          return false;
      }).toList();
}

@freezed
abstract class IntDefault with _$IntDefault {
  factory IntDefault([@Default(42) int value]) = _IntDefault;
}

@freezed
abstract class StringDefault with _$StringDefault {
  factory StringDefault([@Default('42') String value]) = _StringDefault;
}

@freezed
abstract class DoubleDefault with _$DoubleDefault {
  factory DoubleDefault([@Default(42.0) double value]) = _DoubleDefault;
}

@freezed
abstract class TypeDefault with _$TypeDefault {
  factory TypeDefault([@Default(TypeDefault) Type value]) = _TypeDefault;
}

@freezed
abstract class ListDefault with _$ListDefault {
  factory ListDefault([@Default(<int>[42]) List<int> value]) = _ListDefault;
}

@freezed
abstract class SetDefault with _$SetDefault {
  factory SetDefault([@Default(<int>{42}) Set<int> value]) = _SetDefault;
}

@freezed
abstract class MapDefault with _$MapDefault {
  factory MapDefault([@Default(<int, int>{42: 42}) Map<int, int> value]) =
      _MapDefault;
}

@freezed
abstract class BoolDefault with _$BoolDefault {
  factory BoolDefault([@Default(false) bool value]) = _BoolDefault;
}

@freezed
abstract class NullDefault with _$NullDefault {
  factory NullDefault([@Default(null) bool value]) = _NullDefault;
}

@freezed
abstract class ExplicitConstDefault with _$ExplicitConstDefault {
  factory ExplicitConstDefault(
      //ignore: unnecessary_const
      [@Default(const <Object>[]) List<Object> value]) = _ExplicitConstDefault;
}

@freezed
abstract class StaticConstDefault with _$StaticConstDefault {
  factory StaticConstDefault([@Default(Duration.zero) Duration value]) =
      _StaticConstDefault;
}

enum _Enum { a }

@freezed
abstract class EnumDefault with _$EnumDefault {
  factory EnumDefault([@Default(_Enum.a) _Enum value]) = _EnumDefault;
}
