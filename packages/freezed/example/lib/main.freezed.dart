// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package

part of 'main.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

mixin _$MyClass {
  String get a;
  int get b;

  MyClass copyWith({String a, int b});
}

class _$_MyClass with DiagnosticableTreeMixin implements _MyClass {
  _$_MyClass({this.a, this.b});

  @override
  final String a;
  @override
  final int b;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MyClass(a: $a, b: $b)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MyClass'))
      ..add(DiagnosticsProperty('a', a))
      ..add(DiagnosticsProperty('b', b));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MyClass &&
            (identical(other.a, a) ||
                const DeepCollectionEquality().equals(other.a, a)) &&
            (identical(other.b, b) ||
                const DeepCollectionEquality().equals(other.b, b)));
  }

  @override
  int get hashCode => runtimeType.hashCode ^ a.hashCode ^ b.hashCode;

  @override
  _$_MyClass copyWith({
    Object a = freezed,
    Object b = freezed,
  }) {
    return _$_MyClass(
      a: a == freezed ? this.a : a as String,
      b: b == freezed ? this.b : b as int,
    );
  }
}

abstract class _MyClass implements MyClass {
  factory _MyClass({String a, int b}) = _$_MyClass;

  @override
  String get a;
  @override
  int get b;

  @override
  _MyClass copyWith({String a, int b});
}

mixin _$Union {
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(int value), {
    @required Result loading(),
    @required Result error(String message),
    @required Result complex(int a, String b),
  });

  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(int value), {
    Result loading(),
    Result error(String message),
    Result complex(int a, String b),
    @required Result orElse(),
  });

  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(Data value), {
    @required Result loading(Loading value),
    @required Result error(ErrorDetails value),
    @required Result complex(Complex value),
  });

  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(Data value), {
    Result loading(Loading value),
    Result error(ErrorDetails value),
    Result complex(Complex value),
    @required Result orElse(),
  });
}

class _$Data with DiagnosticableTreeMixin implements Data {
  const _$Data(this.value) : assert(value != null);

  @override
  final int value;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Union(value: $value)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Union'))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Data &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;

  @override
  _$Data copyWith({
    Object value = freezed,
  }) {
    assert(value != null);
    return _$Data(
      value == freezed ? this.value : value as int,
    );
  }

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(int value), {
    @required Result loading(),
    @required Result error(String message),
    @required Result complex(int a, String b),
  }) {
    assert($default != null);
    assert(loading != null);
    assert(error != null);
    assert(complex != null);
    return $default(value);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(int value), {
    Result loading(),
    Result error(String message),
    Result complex(int a, String b),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if ($default != null) {
      return $default(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(Data value), {
    @required Result loading(Loading value),
    @required Result error(ErrorDetails value),
    @required Result complex(Complex value),
  }) {
    assert($default != null);
    assert(loading != null);
    assert(error != null);
    assert(complex != null);
    return $default(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(Data value), {
    Result loading(Loading value),
    Result error(ErrorDetails value),
    Result complex(Complex value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class Data implements Union {
  const factory Data(int value) = _$Data;

  int get value;

  Data copyWith({int value});
}

class _$Loading with DiagnosticableTreeMixin implements Loading {
  const _$Loading();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Union.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'Union.loading'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(int value), {
    @required Result loading(),
    @required Result error(String message),
    @required Result complex(int a, String b),
  }) {
    assert($default != null);
    assert(loading != null);
    assert(error != null);
    assert(complex != null);
    return loading();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(int value), {
    Result loading(),
    Result error(String message),
    Result complex(int a, String b),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(Data value), {
    @required Result loading(Loading value),
    @required Result error(ErrorDetails value),
    @required Result complex(Complex value),
  }) {
    assert($default != null);
    assert(loading != null);
    assert(error != null);
    assert(complex != null);
    return loading(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(Data value), {
    Result loading(Loading value),
    Result error(ErrorDetails value),
    Result complex(Complex value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading implements Union {
  const factory Loading() = _$Loading;
}

class _$ErrorDetails with DiagnosticableTreeMixin implements ErrorDetails {
  const _$ErrorDetails([this.message]);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Union.error(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Union.error'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ErrorDetails &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode => runtimeType.hashCode ^ message.hashCode;

  @override
  _$ErrorDetails copyWith({
    Object message = freezed,
  }) {
    return _$ErrorDetails(
      message == freezed ? this.message : message as String,
    );
  }

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(int value), {
    @required Result loading(),
    @required Result error(String message),
    @required Result complex(int a, String b),
  }) {
    assert($default != null);
    assert(loading != null);
    assert(error != null);
    assert(complex != null);
    return error(message);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(int value), {
    Result loading(),
    Result error(String message),
    Result complex(int a, String b),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(Data value), {
    @required Result loading(Loading value),
    @required Result error(ErrorDetails value),
    @required Result complex(Complex value),
  }) {
    assert($default != null);
    assert(loading != null);
    assert(error != null);
    assert(complex != null);
    return error(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(Data value), {
    Result loading(Loading value),
    Result error(ErrorDetails value),
    Result complex(Complex value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ErrorDetails implements Union {
  const factory ErrorDetails([String message]) = _$ErrorDetails;

  String get message;

  ErrorDetails copyWith({String message});
}

class _$Complex with DiagnosticableTreeMixin implements Complex {
  const _$Complex(this.a, this.b)
      : assert(a != null),
        assert(b != null);

  @override
  final int a;
  @override
  final String b;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Union.complex(a: $a, b: $b)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Union.complex'))
      ..add(DiagnosticsProperty('a', a))
      ..add(DiagnosticsProperty('b', b));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Complex &&
            (identical(other.a, a) ||
                const DeepCollectionEquality().equals(other.a, a)) &&
            (identical(other.b, b) ||
                const DeepCollectionEquality().equals(other.b, b)));
  }

  @override
  int get hashCode => runtimeType.hashCode ^ a.hashCode ^ b.hashCode;

  @override
  _$Complex copyWith({
    Object a = freezed,
    Object b = freezed,
  }) {
    assert(a != null);
    assert(b != null);
    return _$Complex(
      a == freezed ? this.a : a as int,
      b == freezed ? this.b : b as String,
    );
  }

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(int value), {
    @required Result loading(),
    @required Result error(String message),
    @required Result complex(int a, String b),
  }) {
    assert($default != null);
    assert(loading != null);
    assert(error != null);
    assert(complex != null);
    return complex(a, b);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(int value), {
    Result loading(),
    Result error(String message),
    Result complex(int a, String b),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (complex != null) {
      return complex(a, b);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(Data value), {
    @required Result loading(Loading value),
    @required Result error(ErrorDetails value),
    @required Result complex(Complex value),
  }) {
    assert($default != null);
    assert(loading != null);
    assert(error != null);
    assert(complex != null);
    return complex(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(Data value), {
    Result loading(Loading value),
    Result error(ErrorDetails value),
    Result complex(Complex value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (complex != null) {
      return complex(this);
    }
    return orElse();
  }
}

abstract class Complex implements Union {
  const factory Complex(int a, String b) = _$Complex;

  int get a;
  String get b;

  Complex copyWith({int a, String b});
}

mixin _$SharedProperty {
  String get name;

  SharedProperty copyWith({String name});

  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result person(String name, int age),
    @required Result city(String name, int population),
  });

  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result person(String name, int age),
    Result city(String name, int population),
    @required Result orElse(),
  });

  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result person(SharedProperty0 value),
    @required Result city(SharedProperty1 value),
  });

  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result person(SharedProperty0 value),
    Result city(SharedProperty1 value),
    @required Result orElse(),
  });
}

class _$SharedProperty0
    with DiagnosticableTreeMixin
    implements SharedProperty0 {
  _$SharedProperty0({this.name, this.age});

  @override
  final String name;
  @override
  final int age;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SharedProperty.person(name: $name, age: $age)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SharedProperty.person'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('age', age));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SharedProperty0 &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.age, age) ||
                const DeepCollectionEquality().equals(other.age, age)));
  }

  @override
  int get hashCode => runtimeType.hashCode ^ name.hashCode ^ age.hashCode;

  @override
  _$SharedProperty0 copyWith({
    Object name = freezed,
    Object age = freezed,
  }) {
    return _$SharedProperty0(
      name: name == freezed ? this.name : name as String,
      age: age == freezed ? this.age : age as int,
    );
  }

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result person(String name, int age),
    @required Result city(String name, int population),
  }) {
    assert(person != null);
    assert(city != null);
    return person(name, age);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result person(String name, int age),
    Result city(String name, int population),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (person != null) {
      return person(name, age);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result person(SharedProperty0 value),
    @required Result city(SharedProperty1 value),
  }) {
    assert(person != null);
    assert(city != null);
    return person(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result person(SharedProperty0 value),
    Result city(SharedProperty1 value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (person != null) {
      return person(this);
    }
    return orElse();
  }
}

abstract class SharedProperty0 implements SharedProperty {
  factory SharedProperty0({String name, int age}) = _$SharedProperty0;

  @override
  String get name;
  int get age;

  @override
  SharedProperty0 copyWith({String name, int age});
}

class _$SharedProperty1
    with DiagnosticableTreeMixin
    implements SharedProperty1 {
  _$SharedProperty1({this.name, this.population});

  @override
  final String name;
  @override
  final int population;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SharedProperty.city(name: $name, population: $population)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SharedProperty.city'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('population', population));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SharedProperty1 &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.population, population) ||
                const DeepCollectionEquality()
                    .equals(other.population, population)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ name.hashCode ^ population.hashCode;

  @override
  _$SharedProperty1 copyWith({
    Object name = freezed,
    Object population = freezed,
  }) {
    return _$SharedProperty1(
      name: name == freezed ? this.name : name as String,
      population: population == freezed ? this.population : population as int,
    );
  }

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result person(String name, int age),
    @required Result city(String name, int population),
  }) {
    assert(person != null);
    assert(city != null);
    return city(name, population);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result person(String name, int age),
    Result city(String name, int population),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (city != null) {
      return city(name, population);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result person(SharedProperty0 value),
    @required Result city(SharedProperty1 value),
  }) {
    assert(person != null);
    assert(city != null);
    return city(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result person(SharedProperty0 value),
    Result city(SharedProperty1 value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (city != null) {
      return city(this);
    }
    return orElse();
  }
}

abstract class SharedProperty1 implements SharedProperty {
  factory SharedProperty1({String name, int population}) = _$SharedProperty1;

  @override
  String get name;
  int get population;

  @override
  SharedProperty1 copyWith({String name, int population});
}
