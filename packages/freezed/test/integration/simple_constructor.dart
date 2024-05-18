// ignore_for_file: unnecessary_question_mark, avoid_unused_constructor_parameters

import 'dart:async';
import 'dart:collection';

import 'package:data_class/data_class.dart';

@Data()
class Dynamic {
  Dynamic({
    dynamic foo,
    dynamic? bar,
  });
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

@Data()
class ObjectEqual {
  ObjectEqual(Object obj);
}

@Data()
class CustomListEqual {
  CustomListEqual(CustomList<int> list);
}

@Data(makeCollectionsUnmodifiable: false)
class ListEqual {
  ListEqual(List<Object> list);
}

@Data()
class UnmodifiableListEqual {
  UnmodifiableListEqual(List<int> list);
}

@Data()
class NullUnmodifiableListEqual {
  NullUnmodifiableListEqual(List<int>? list);
}

@Data()
class CustomSetEqual {
  CustomSetEqual(CustomSet<int> dartSet);
}

@Data(makeCollectionsUnmodifiable: false)
class SetEqual {
  SetEqual(Set<int> dartSet);
}

@Data()
class UnmodifiableSetEqual {
  UnmodifiableSetEqual(Set<int> dartSet);
}

@Data()
class NullUnmodifiableSetEqual {
  NullUnmodifiableSetEqual(Set<int>? dartSet);
}

@Data()
class CustomMapEqual {
  CustomMapEqual(CustomMap<String, Object?> map);
}

@Data(makeCollectionsUnmodifiable: false)
class MapEqual {
  MapEqual(Map<String, Object?> map);
}

@Data()
class UnmodifiableMapEqual {
  UnmodifiableMapEqual(Map<String, Object?> map);
}

@Data()
class NullUnmodifiableMapEqual {
  NullUnmodifiableMapEqual(Map<String, Object?>? map);
}

mixin Some<T> {
  T? get value => throw UnimplementedError();
}
mixin Complex<T> {
  T? get value => throw UnimplementedError();
}

abstract class DataEvent {}

// @Data()
// class Large {
//   factory Large({
//     @Default(0) int? a0,
//     @Default(1) int? a1,
//     @Default(2) int? a2,
//     @Default(3) int? a3,
//     @Default(4) int? a4,
//     @Default(5) int? a5,
//     @Default(6) int? a6,
//     @Default(7) int? a7,
//     @Default(8) int? a8,
//     @Default(9) int? a9,
//     @Default(10) int? a10,
//     @Default(11) int? a11,
//     @Default(12) int? a12,
//     @Default(13) int? a13,
//     @Default(14) int? a14,
//     @Default(15) int? a15,
//     @Default(16) int? a16,
//     @Default(17) int? a17,
//     @Default(18) int? a18,
//     @Default(19) int? a19,
//     @Default(20) int? a20,
//     @Default(21) int? a21,
//     @Default(22) int? a22,
//     @Default(23) int? a23,
//     @Default(24) int? a24,
//     @Default(25) int? a25,
//     @Default(26) int? a26,
//     @Default(27) int? a27,
//     @Default(28) int? a28,
//     @Default(29) int? a29,
//   }) = _Large;
// }

// Regression test for https://github.com/rrousselGit/Freezed(/issues/131
@Data()
class Regression131 extends DataEvent {
  Regression131(String versionName);
}

// @Data()
// class UnimplementedGetter {
//   UnimplementedGetter(int value);

//   @override
//   int get value;
// }

@Data()
class Assertion {
  Assertion(int a, int b)
      : assert(a > 0),
        assert(b > a);
}

// // Regression test for https://github.com/rrousselGit/Freezed(/issues/326
// @Data()
// class Doc326 with _$Doc326 {
//   /// Hello world
//   factory Doc326({
//     int? named,
//   }) = _Doc326;
// }

// // Regression test for https://github.com/rrousselGit/Freezed(/issues/317
// @Data()
// class Doc317 with _$Doc317 {
//   factory Doc317({
//     /// )
//     int? named,
//   }) = _Doc317;
// }

// @Data()
// class Doc with _$Doc {
//   factory Doc(
//     /// Multi
//     /// line
//     /// positional
//     int positional, {
//     /// Single line named
//     int? named,

//     // Simple
//     int? simple,
//   }) = _Doc;
// }

/// Regression test for https://github.com/rrousselGit/Freezed(/issues/213
@Data()
class Product {
  const Product({
    String? name,
    Product? parent,
  });
}

@Data(constructor: 'something')
class Test {
  const Test.something(Completer<void> completer);
}

@Data(constructor: '_internal')
class Private {
  // This is the (private) Freezed( constructor
  const Private._internal(
    Iterable<String> items,
  );
}

@Data()
class MyClass {
  MyClass({String? a, int? b});
}

@Data()
class MixedParam {
  const MixedParam(String a, {int? b});
}

@Data()
class PositionalMixedParam {
  const PositionalMixedParam(String a, [int? b]);
}

@Data()
class Required {
  const Required({required String? a});
}

@Data()
class Empty {
  const Empty();
}

@Data()
class Empty2 {
  const Empty2();
}

@Data(constructor: 'named')
class SingleNamedCtor {
  const SingleNamedCtor.named(int a);
}

// @Data()
// class Generic<T> with _$Generic<T> {
//   const Generic(T value) = A<T>;
// }

// @Data()
// class Example {
//   const Example(String a, {int? b});

//   factory Example.fixed() {
//     return const Example('a', b: 42);
//   }
// }

@Data()
class NoConst {
  NoConst();
}

// Regression test for https://github.com/rrousselGit/Freezed(/issues/40
@Data()
class SecondState {
  const SecondState({
    String? dateTime,
    String? uuid,
  });
}

// Regression test for https://github.com/rrousselGit/Freezed(/issues/44
@Data()
class Static {
  const Static();

  static int? staticVariable;

  static int get staticGetter => 0;

  static int staticMethod() => 0;
}

@Data()
class Late {
  Late(int value);

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

@Data()
class AllProperties {
  AllProperties(int value);

  int get a => 1;
  late final b = 2;
  final c = 3;
}

@Data()
class Late2 {
  Late2(int? Function() cb);

  late final int? first = cb();
}

@Data()
class ComplexLate {
  ComplexLate(List<int> values);

  late final List<int> odd = values.where((value) {
    if (value.isOdd)
      return true;
    else
      return false;
  }).toList();
}

// @Data()
// class IntDefault {
//   factory IntDefault([@Default(42) int value]) = _IntDefault;
// }

// @Data()
// class StringDefault with _$StringDefault {
//   factory StringDefault([@Default('42') String value]) = _StringDefault;
// }

// @Data()
// class SpecialStringDefault with _$SpecialStringDefault {
//   factory SpecialStringDefault([@Default('(1)[2]{3}') String value]) =
//       _SpecialStringDefault;
// }

// /// Adds `const` to default non-literal values
// @Data()
// class DefaultNonLiteralConst with _$DefaultNonLiteralConst {
//   factory DefaultNonLiteralConst({
//     @Default(Object()) Object listObject,
//   }) = _DefaultNonLiteralConst;
// }

// /// Does not add `const` to non-literal values if already present
// @Data()
// class DefaultNonLiteralAlreadyConst with _$DefaultNonLiteralAlreadyConst {
//   factory DefaultNonLiteralAlreadyConst({
//     @Default(
//       // ignore: unnecessary_const
//       const Object(),
//     )
//     Object listObject,
//   }) = _DefaultNonLiteralAlreadyConst;
// }

// @Data()
// class DoubleDefault with _$DoubleDefault {
//   factory DoubleDefault([@Default(42.0) double value]) = _DoubleDefault;
// }

// @Data()
// class TypeDefault with _$TypeDefault {
//   factory TypeDefault([@Default(TypeDefault) Type value]) = _TypeDefault;
// }

// @Data()
// class ListDefault with _$ListDefault {
//   factory ListDefault([@Default(<int>[42]) List<int> value]) = _ListDefault;
// }

// @Data()
// class SetDefault with _$SetDefault {
//   factory SetDefault([@Default(<int>{42}) Set<int> value]) = _SetDefault;
// }

// @Data()
// class MapDefault with _$MapDefault {
//   factory MapDefault([@Default(<int, int>{42: 42}) Map<int, int> value]) =
//       _MapDefault;
// }

// @Data()
// class BoolDefault with _$BoolDefault {
//   factory BoolDefault([@Default(false) bool value]) = _BoolDefault;
// }

// @Data()
// class NullDefault with _$NullDefault {
//   factory NullDefault([@Default(null) bool? value]) = _NullDefault;
// }

// @Data()
// class ExplicitConstDefault with _$ExplicitConstDefault {
//   factory ExplicitConstDefault(
//       //ignore: unnecessary_const
//       [@Default(const <Object>[]) List<Object> value]) = _ExplicitConstDefault;
// }

// @Data()
// class StaticConstDefault with _$StaticConstDefault {
//   factory StaticConstDefault([@Default(Duration.zero) Duration value]) =
//       _StaticConstDefault;
// }

// enum _Enum { a }

// @Data()
// class EnumDefault with _$EnumDefault {
//   factory EnumDefault([@Default(_Enum.a) _Enum value]) = _EnumDefault;
// }
