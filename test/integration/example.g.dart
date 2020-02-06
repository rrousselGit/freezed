// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// ImmutableGenerator
// **************************************************************************

class _$ObjectMyClass {
  const _$ObjectMyClass();
}

const _$defaultMyClass = _$ObjectMyClass();

class _MyClass implements MyClass {
  const _MyClass({this.a, this.b});

  final String a;
  final int b;

  @override
  String toString() {
    return 'MyClass(a: $a, b: $b)';
  }

  @override
  bool operator ==(dynamic other) {
    return other is _MyClass && other.a == a && other.b == b;
  }

  @override
  int get hashCode => a.hashCode ^ b.hashCode;

  @override
  MyClass copyWith({
    Object a = _$defaultMyClass,
    Object b = _$defaultMyClass,
  }) {
    return MyClass(
      a: a == _$defaultMyClass ? this.a : a as String,
      b: b == _$defaultMyClass ? this.b : b as int,
    );
  }
}

abstract class _MyClassBase {
  String get a;
  int get b;

  MyClass copyWith({String a, int b});
}
