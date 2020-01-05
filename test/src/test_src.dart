// ignore_for_file: undefined_class, mixin_of_non_class, redirect_to_non_class, uri_has_not_been_generated
import 'package:immutable/immutable.dart';
import 'package:source_gen_test/annotations.dart';

part 'test_src.g.dart';

@ShouldGenerate(r'''
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

  Map<String, dynamic> toJSON() {
    return <String, dynamic>{
      'a': a,
      'b': b,
    };
  }

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
}
''')
@Immutable()
abstract class MyClass with _MyClassBase {
  const factory MyClass({
    String a,
    int b,
  }) = _MyClass;
}

@ShouldGenerate(r'''
class _$ObjectMixedParameters {
  const _$ObjectMixedParameters();
}

const _$defaultMixedParameters = _$ObjectMixedParameters();

class _MixedParameters implements MixedParameters {
  const _MixedParameters(this.a, [this.b, this.d]);

  final String a;
  final int b;
  final Object d;

  @override
  String toString() {
    return 'MixedParameters(a: $a, b: $b, d: $d)';
  }

  @override
  bool operator ==(dynamic other) {
    return other is _MixedParameters &&
        other.a == a &&
        other.b == b &&
        other.d == d;
  }

  @override
  int get hashCode => a.hashCode ^ b.hashCode ^ d.hashCode;

  Map<String, dynamic> toJSON() {
    return <String, dynamic>{
      'a': a,
      'b': b,
      'd': d,
    };
  }

  @override
  MixedParameters copyWith({
    Object a = _$defaultMixedParameters,
    Object b = _$defaultMixedParameters,
    Object d = _$defaultMixedParameters,
  }) {
    return MixedParameters(
      a == _$defaultMixedParameters ? this.a : a as String,
      b == _$defaultMixedParameters ? this.b : b as int,
      d == _$defaultMixedParameters ? this.d : d,
    );
  }
}

abstract class _MixedParametersBase {
  String get a;
  int get b;
  Object get d;
}
''')
@Immutable()
abstract class MixedParameters with _MixedParametersBase {
  const factory MixedParameters(String a, [int b, Object d]) = _MixedParameters;
}

@ShouldGenerate(r'''
class _$ObjectPositionalAndNamed {
  const _$ObjectPositionalAndNamed();
}

const _$defaultPositionalAndNamed = _$ObjectPositionalAndNamed();

class _PositionalAndNamed implements PositionalAndNamed {
  const _PositionalAndNamed(this.a, {this.b, this.d});

  final String a;
  final int b;
  final Object d;

  @override
  String toString() {
    return 'PositionalAndNamed(a: $a, b: $b, d: $d)';
  }

  @override
  bool operator ==(dynamic other) {
    return other is _PositionalAndNamed &&
        other.a == a &&
        other.b == b &&
        other.d == d;
  }

  @override
  int get hashCode => a.hashCode ^ b.hashCode ^ d.hashCode;

  Map<String, dynamic> toJSON() {
    return <String, dynamic>{
      'a': a,
      'b': b,
      'd': d,
    };
  }

  @override
  PositionalAndNamed copyWith({
    Object a = _$defaultPositionalAndNamed,
    Object b = _$defaultPositionalAndNamed,
    Object d = _$defaultPositionalAndNamed,
  }) {
    return PositionalAndNamed(
      a == _$defaultPositionalAndNamed ? this.a : a as String,
      b: b == _$defaultPositionalAndNamed ? this.b : b as int,
      d: d == _$defaultPositionalAndNamed ? this.d : d,
    );
  }
}

abstract class _PositionalAndNamedBase {
  String get a;
  int get b;
  Object get d;
}
''')
@Immutable()
abstract class PositionalAndNamed with _PositionalAndNamedBase {
  const factory PositionalAndNamed(String a, {int b, Object d}) = _PositionalAndNamed;
}
@ShouldGenerate(r'''
class _$ObjectFromJSON {
  const _$ObjectFromJSON();
}

const _$defaultFromJSON = _$ObjectFromJSON();

class _FromJSON implements FromJSON {
  const _FromJSON(this.a, {this.b, this.d});

  factory _FromJSON.fromJSON(Map<String, dynamic> json) {
    return _FromJSON(
      a: json['a'] as String,
      b: json['b'] as int,
      d: json['d'] as Object,
    );
  }

  final String a;
  final int b;
  final Object d;

  @override
  String toString() {
    return 'FromJSON(a: $a, b: $b, d: $d)';
  }

  @override
  bool operator ==(dynamic other) {
    return other is _FromJSON &&
        other.a == a &&
        other.b == b &&
        other.d == d;
  }

  @override
  int get hashCode => a.hashCode ^ b.hashCode ^ d.hashCode;

  Map<String, dynamic> toJSON() {
    return <String, dynamic>{
      'a': a,
      'b': b,
      'd': d,
    };
  }

  @override
  FromJSON copyWith({
    Object a = _$defaultFromJSON,
    Object b = _$defaultFromJSON,
    Object d = _$defaultFromJSON,
  }) {
    return FromJSON(
      a == _$defaultFromJSON ? this.a : a as String,
      b: b == _$defaultFromJSON ? this.b : b as int,
      d: d == _$defaultFromJSON ? this.d : d,
    );
  }
}

abstract class _FromJSONBase {
  String get a;
  int get b;
  Object get d;
}
''')
@Immutable()
abstract class FromJSON with _FromJSONBase {
  const factory FromJSON(String a, {int b, Object d}) = _FromJSON;

  factory FromJSON.fromJSON(Map<String, dynamic> json) = _FromJSON.fromJSON;
}
