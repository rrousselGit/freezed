// ignore_for_file: unnecessary_question_mark

import 'dart:async';
import 'dart:collection';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'single_class_constructor.freezed.dart';

@freezed
class Dynamic with _$Dynamic {
  factory Dynamic({
    dynamic foo,
    dynamic? bar,
  }) = DynamicFirst;
}

class CustomMap<A, B> extends MapBase<A, B> {
  CustomMap(this._source);

  final Map<A, B> _source;

  @override
  B? operator [](Object? key) => _source[key];

  @override
  void operator []=(A key, B value) => _source[key] = value;

  @override
  void clear() => _source.clear();

  @override
  Iterable<A> get keys => _source.keys;

  @override
  B? remove(Object? key) => _source.remove(key);
}

class CustomSet<T> extends SetBase<T> {
  CustomSet(this._source);

  final Set<T> _source;

  @override
  bool add(T value) => _source.add(value);

  @override
  bool contains(Object? element) => _source.contains(element);

  @override
  Iterator<T> get iterator => _source.iterator;

  @override
  int get length => _source.length;

  @override
  T? lookup(Object? element) => _source.lookup(element);

  @override
  bool remove(Object? value) => _source.remove(value);

  @override
  Set<T> toSet() => _source.toSet();
}

class CustomList<T> extends ListBase<T?> {
  CustomList(this._source);

  final List<T?> _source;

  @override
  int get length => _source.length;

  @override
  set length(int length) => _source.length = length;

  @override
  T? operator [](int index) => _source[index];

  @override
  void operator []=(int index, T? value) => _source[index] = value;
}

@freezed
class CustomListEqual with _$CustomListEqual {
  factory CustomListEqual(CustomList<int> list) = CustomListEqualFirst;
}

@Freezed(makeCollectionsUnmodifiable: false)
class ListEqual with _$ListEqual {
  factory ListEqual(List<int> list) = ListEqualFirst;
}

@freezed
class UnmodifiableListEqual with _$UnmodifiableListEqual {
  factory UnmodifiableListEqual(List<int> list) = UnmodifiableListEqualFirst;
}

@freezed
class NullUnmodifiableListEqual with _$NullUnmodifiableListEqual {
  factory NullUnmodifiableListEqual(List<int>? list) =
      NullUnmodifiableListEqualFirst;
}

@freezed
class CustomSetEqual with _$CustomSetEqual {
  factory CustomSetEqual(CustomSet<int> dartSet) = CustomSetEqualFirst;
}

@Freezed(makeCollectionsUnmodifiable: false)
class SetEqual with _$SetEqual {
  factory SetEqual(Set<int> dartSet) = SetEqualFirst;
}

@freezed
class UnmodifiableSetEqual with _$UnmodifiableSetEqual {
  factory UnmodifiableSetEqual(Set<int> dartSet) = UnmodifiableSetEqualFirst;
}

@freezed
class NullUnmodifiableSetEqual with _$NullUnmodifiableSetEqual {
  factory NullUnmodifiableSetEqual(Set<int>? dartSet) =
      NullUnmodifiableSetEqualFirst;
}

@freezed
class CustomMapEqual with _$CustomMapEqual {
  factory CustomMapEqual(CustomMap<String, Object?> map) = CustomMapEqualFirst;
}

@Freezed(makeCollectionsUnmodifiable: false)
class MapEqual with _$MapEqual {
  factory MapEqual(Map<String, Object?> map) = MapEqualFirst;
}

@freezed
class UnmodifiableMapEqual with _$UnmodifiableMapEqual {
  factory UnmodifiableMapEqual(Map<String, Object?> map) =
      UnmodifiableMapEqualFirst;
}

@freezed
class NullUnmodifiableMapEqual with _$NullUnmodifiableMapEqual {
  factory NullUnmodifiableMapEqual(Map<String, Object?>? map) =
      NullUnmodifiableMapEqualFirst;
}

mixin Some<T> {
  T? get value => throw UnimplementedError();
}
mixin Complex<T> {
  T? get value => throw UnimplementedError();
}

const withAlias = With<Some<Complex<Type>>>();

@freezed
class WithAlias with _$WithAlias {
  @withAlias
  factory WithAlias.first() = WithAliasFirst;
}

const implementsAlias = Implements<Some<Complex<Type>>>();

@freezed
class ImplementsAlias with _$ImplementsAlias {
  @implementsAlias
  factory ImplementsAlias.first({
    Complex<Type>? value,
  }) = ImplementsAliasFirst;
}

abstract class DataEvent {}

@freezed
class Large with _$Large {
  factory Large({
    @Default(0) int? a0,
    @Default(1) int? a1,
    @Default(2) int? a2,
    @Default(3) int? a3,
    @Default(4) int? a4,
    @Default(5) int? a5,
    @Default(6) int? a6,
    @Default(7) int? a7,
    @Default(8) int? a8,
    @Default(9) int? a9,
    @Default(10) int? a10,
    @Default(11) int? a11,
    @Default(12) int? a12,
    @Default(13) int? a13,
    @Default(14) int? a14,
    @Default(15) int? a15,
    @Default(16) int? a16,
    @Default(17) int? a17,
    @Default(18) int? a18,
    @Default(19) int? a19,
    @Default(20) int? a20,
    @Default(21) int? a21,
    @Default(22) int? a22,
    @Default(23) int? a23,
    @Default(24) int? a24,
    @Default(25) int? a25,
    @Default(26) int? a26,
    @Default(27) int? a27,
    @Default(28) int? a28,
    @Default(29) int? a29,
  }) = _Large;
}

// Regression test for https://github.com/rrousselGit/freezed/issues/131
@freezed
class Regression131 extends DataEvent with _$Regression131 {
  factory Regression131(String versionName) = _Regression131;
}

@freezed
class UnimplementedGetter with _$UnimplementedGetter {
  factory UnimplementedGetter(int value) = _UnimplementedGetter;

  @override
  int get value;
}

@freezed
class Assertion with _$Assertion {
  @Assert('a > 0')
  @Assert('b > a')
  factory Assertion(int a, int b) = _Assertion;
}

// Regression test for https://github.com/rrousselGit/freezed/issues/326
@freezed
class Doc326 with _$Doc326 {
  /// Hello world
  factory Doc326({
    int? named,
  }) = _Doc326;
}

// Regression test for https://github.com/rrousselGit/freezed/issues/317
@freezed
class Doc317 with _$Doc317 {
  factory Doc317({
    /// )
    int? named,
  }) = _Doc317;
}

@freezed
class Doc with _$Doc {
  factory Doc(
    /// Multi
    /// line
    /// positional
    int positional, {
    /// Single line named
    int? named,

    // Simple
    int? simple,
  }) = _Doc;
}

/// Regression test for https://github.com/rrousselGit/freezed/issues/213
@freezed
class Product with _$Product {
  const factory Product({
    String? name,
    Product? parent,
  }) = _ProductDataClass;
}

@freezed
class Test with _$Test {
  const factory Test.something(Completer<void> completer) = TestSomething;
}

@freezed
class Private with _$Private {
  // This is the (private) Freezed constructor
  const factory Private._internal(
    Iterable<String> items,
  ) = _Private;
}

@freezed
class MyClass with _$MyClass {
  const factory MyClass({String? a, int? b}) = WhateverIWant;
}

@freezed
class MixedParam with _$MixedParam {
  const factory MixedParam(String a, {int? b}) = WhateverMixedParam;
}

@freezed
class PositionalMixedParam with _$PositionalMixedParam {
  const factory PositionalMixedParam(String a, [int? b]) =
      WhateverPositionalMixedParam;
}

@freezed
class Required with _$Required {
  const factory Required({required String? a}) = WhateverRequired;
}

@freezed
class Empty with _$Empty {
  const factory Empty() = WhateverEmpty;
}

@freezed
class Empty2 with _$Empty2 {
  const factory Empty2() = WhateverEmpty2;
}

@freezed
class SingleNamedCtor with _$SingleNamedCtor {
  const factory SingleNamedCtor.named(int a) = WhateverSingleNamedCtor;
}

@freezed
class Generic<T> with _$Generic<T> {
  const factory Generic(T value) = A<T>;
}

@freezed
class Example with _$Example {
  const factory Example(String a, {int? b}) = Example0;

  factory Example.fixed() {
    return const Example('a', b: 42);
  }
}

@freezed
class NoConst with _$NoConst {
  factory NoConst() = NoConstImpl;
}

// Regression test for https://github.com/rrousselGit/freezed/issues/40
@freezed
class SecondState with _$SecondState {
  const factory SecondState({
    String? dateTime,
    String? uuid,
  }) = _SecondState;
}

// Regression test for https://github.com/rrousselGit/freezed/issues/44
@freezed
class Static with _$Static {
  const factory Static() = _Static;

  static int? staticVariable;

  static int get staticGetter => 0;

  static int staticMethod() => 0;
}

@freezed
class Late with _$Late {
  Late._();
  factory Late(int value) = _Late;

  late final container = LateContainer(value);
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
class AllProperties with _$AllProperties {
  AllProperties._();
  factory AllProperties(int value) = _AllProperties;

  int get a => 1;
  late final b = 2;
  final c = 3;
}

@freezed
class Late2 with _$Late2 {
  Late2._();
  factory Late2(int? Function() cb) = _Late2;

  late final int? first = cb();
}

@freezed
class ComplexLate with _$ComplexLate {
  ComplexLate._();
  factory ComplexLate(List<int> values) = _ComplexLate;

  late final List<int> odd = values.where((value) {
    if (value.isOdd)
      return true;
    else
      return false;
  }).toList();
}

@freezed
class IntDefault with _$IntDefault {
  factory IntDefault([@Default(42) int value]) = _IntDefault;
}

@freezed
class StringDefault with _$StringDefault {
  factory StringDefault([@Default('42') String value]) = _StringDefault;
}

@freezed
class SpecialStringDefault with _$SpecialStringDefault {
  factory SpecialStringDefault([@Default('(1)[2]{3}') String value]) =
      _SpecialStringDefault;
}

/// Adds `const` to default non-literral values
@freezed
class DefaultNonLitteralConst with _$DefaultNonLitteralConst {
  factory DefaultNonLitteralConst({
    @Default(Object()) Object listObject,
  }) = _DefaultNonLitteralConst;
}

/// Does not add `const` to non-literral values if already present
@freezed
class DefaultNonLitteralAlreadyConst with _$DefaultNonLitteralAlreadyConst {
  factory DefaultNonLitteralAlreadyConst({
    @Default(
      // ignore: unnecessary_const
      const Object(),
    )
    Object listObject,
  }) = _DefaultNonLitteralAlreadyConst;
}

@freezed
class DoubleDefault with _$DoubleDefault {
  factory DoubleDefault([@Default(42.0) double value]) = _DoubleDefault;
}

@freezed
class TypeDefault with _$TypeDefault {
  factory TypeDefault([@Default(TypeDefault) Type value]) = _TypeDefault;
}

@freezed
class ListDefault with _$ListDefault {
  factory ListDefault([@Default(<int>[42]) List<int> value]) = _ListDefault;
}

@freezed
class SetDefault with _$SetDefault {
  factory SetDefault([@Default(<int>{42}) Set<int> value]) = _SetDefault;
}

@freezed
class MapDefault with _$MapDefault {
  factory MapDefault([@Default(<int, int>{42: 42}) Map<int, int> value]) =
      _MapDefault;
}

@freezed
class BoolDefault with _$BoolDefault {
  factory BoolDefault([@Default(false) bool value]) = _BoolDefault;
}

@freezed
class NullDefault with _$NullDefault {
  factory NullDefault([@Default(null) bool? value]) = _NullDefault;
}

@freezed
class ExplicitConstDefault with _$ExplicitConstDefault {
  factory ExplicitConstDefault(
      //ignore: unnecessary_const
      [@Default(const <Object>[]) List<Object> value]) = _ExplicitConstDefault;
}

@freezed
class StaticConstDefault with _$StaticConstDefault {
  factory StaticConstDefault([@Default(Duration.zero) Duration value]) =
      _StaticConstDefault;
}

enum _Enum { a }

@freezed
class EnumDefault with _$EnumDefault {
  factory EnumDefault([@Default(_Enum.a) _Enum value]) = _EnumDefault;
}
