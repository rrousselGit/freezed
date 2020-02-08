// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// ImmutableGenerator
// **************************************************************************

abstract class _$MyClass {
  String get a;
  int get b;

  MyClass copyWith({String a, int b});
}

class _$_MyClass implements _MyClass {
  const _$_MyClass({this.a, this.b});

  @override
  final String a;
  @override
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
  int get hashCode => runtimeType.hashCode ^ a.hashCode ^ b.hashCode;

  @override
  _$_MyClass copyWith({
    Object a = immutable,
    Object b = immutable,
  }) {
    return _$_MyClass(
      a: a == immutable ? this.a : a as String,
      b: b == immutable ? this.b : b as int,
    );
  }
}

abstract class _MyClass implements MyClass {
  const factory _MyClass({String a, int b}) = _$_MyClass;

  @override
  String get a;
  @override
  int get b;

  @override
  _MyClass copyWith({String a, int b});
}

abstract class _$Union {
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
}

class _$Union0 implements Union0 {
  const _$Union0(this.value);

  @override
  final int value;

  @override
  String toString() {
    return 'Union(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return other is Union0 && other.value == value;
  }

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;

  @override
  _$Union0 copyWith({
    Object value = immutable,
  }) {
    return _$Union0(
      value == immutable ? this.value : value as int,
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
}

abstract class Union0 implements Union {
  const factory Union0(int value) = _$Union0;

  int get value;

  Union0 copyWith({int value});
}

class _$Union1 implements Union1 {
  const _$Union1();

  @override
  String toString() {
    return 'Union.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return other is Union1;
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
}

abstract class Union1 implements Union {
  const factory Union1() = _$Union1;
}

class _$Union2 implements Union2 {
  const _$Union2([this.message]);

  @override
  final String message;

  @override
  String toString() {
    return 'Union.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return other is Union2 && other.message == message;
  }

  @override
  int get hashCode => runtimeType.hashCode ^ message.hashCode;

  @override
  _$Union2 copyWith({
    Object message = immutable,
  }) {
    return _$Union2(
      message == immutable ? this.message : message as String,
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
}

abstract class Union2 implements Union {
  const factory Union2([String message]) = _$Union2;

  String get message;

  Union2 copyWith({String message});
}

class _$Union3 implements Union3 {
  const _$Union3(this.a, this.b);

  @override
  final int a;
  @override
  final String b;

  @override
  String toString() {
    return 'Union.complex(a: $a, b: $b)';
  }

  @override
  bool operator ==(dynamic other) {
    return other is Union3 && other.a == a && other.b == b;
  }

  @override
  int get hashCode => runtimeType.hashCode ^ a.hashCode ^ b.hashCode;

  @override
  _$Union3 copyWith({
    Object a = immutable,
    Object b = immutable,
  }) {
    return _$Union3(
      a == immutable ? this.a : a as int,
      b == immutable ? this.b : b as String,
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
}

abstract class Union3 implements Union {
  const factory Union3(int a, String b) = _$Union3;

  int get a;
  String get b;

  Union3 copyWith({int a, String b});
}

abstract class _$SharedProperty {
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
}

class _$SharedProperty0 implements SharedProperty0 {
  const _$SharedProperty0(this.name, this.age);

  @override
  final String name;
  @override
  final int age;

  @override
  String toString() {
    return 'SharedProperty.person(name: $name, age: $age)';
  }

  @override
  bool operator ==(dynamic other) {
    return other is SharedProperty0 && other.name == name && other.age == age;
  }

  @override
  int get hashCode => runtimeType.hashCode ^ name.hashCode ^ age.hashCode;

  @override
  _$SharedProperty0 copyWith({
    Object name = immutable,
    Object age = immutable,
  }) {
    return _$SharedProperty0(
      name == immutable ? this.name : name as String,
      age == immutable ? this.age : age as int,
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
}

abstract class SharedProperty0 implements SharedProperty {
  const factory SharedProperty0(String name, int age) = _$SharedProperty0;

  @override
  String get name;
  int get age;

  @override
  SharedProperty0 copyWith({String name, int age});
}

class _$SharedProperty1 implements SharedProperty1 {
  const _$SharedProperty1(this.name, this.population);

  @override
  final String name;
  @override
  final int population;

  @override
  String toString() {
    return 'SharedProperty.city(name: $name, population: $population)';
  }

  @override
  bool operator ==(dynamic other) {
    return other is SharedProperty1 &&
        other.name == name &&
        other.population == population;
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ name.hashCode ^ population.hashCode;

  @override
  _$SharedProperty1 copyWith({
    Object name = immutable,
    Object population = immutable,
  }) {
    return _$SharedProperty1(
      name == immutable ? this.name : name as String,
      population == immutable ? this.population : population as int,
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
}

abstract class SharedProperty1 implements SharedProperty {
  const factory SharedProperty1(String name, int population) =
      _$SharedProperty1;

  @override
  String get name;
  int get population;

  @override
  SharedProperty1 copyWith({String name, int population});
}
