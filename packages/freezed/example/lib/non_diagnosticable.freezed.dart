// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'non_diagnosticable.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ExampleTearOff {
  const _$ExampleTearOff();

  _Example<T> call<T>(int a, String b) {
    return _Example<T>(
      a,
      b,
    );
  }

  _Example2<T> named<T>(T c) {
    return _Example2<T>(
      c,
    );
  }
}

/// @nodoc
const $Example = _$ExampleTearOff();

/// @nodoc
mixin _$Example<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int a, String b) $default, {
    required TResult Function(T c) named,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(int a, String b)? $default, {
    TResult Function(T c)? named,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int a, String b)? $default, {
    TResult Function(T c)? named,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Example<T> value) $default, {
    required TResult Function(_Example2<T> value) named,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_Example<T> value)? $default, {
    TResult Function(_Example2<T> value)? named,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Example<T> value)? $default, {
    TResult Function(_Example2<T> value)? named,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExampleCopyWith<T, $Res> {
  factory $ExampleCopyWith(Example<T> value, $Res Function(Example<T>) then) =
      _$ExampleCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$ExampleCopyWithImpl<T, $Res> implements $ExampleCopyWith<T, $Res> {
  _$ExampleCopyWithImpl(this._value, this._then);

  final Example<T> _value;
  // ignore: unused_field
  final $Res Function(Example<T>) _then;
}

/// @nodoc
abstract class _$ExampleCopyWith<T, $Res> {
  factory _$ExampleCopyWith(
          _Example<T> value, $Res Function(_Example<T>) then) =
      __$ExampleCopyWithImpl<T, $Res>;
  $Res call({int a, String b});
}

/// @nodoc
class __$ExampleCopyWithImpl<T, $Res> extends _$ExampleCopyWithImpl<T, $Res>
    implements _$ExampleCopyWith<T, $Res> {
  __$ExampleCopyWithImpl(_Example<T> _value, $Res Function(_Example<T>) _then)
      : super(_value, (v) => _then(v as _Example<T>));

  @override
  _Example<T> get _value => super._value as _Example<T>;

  @override
  $Res call({
    Object? a = freezed,
    Object? b = freezed,
  }) {
    return _then(_Example<T>(
      a == freezed
          ? _value.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
      b == freezed
          ? _value.b
          : b // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Example<T> implements _Example<T> {
  _$_Example(this.a, this.b);

  @override
  final int a;
  @override
  final String b;

  @override
  String toString() {
    return 'Example<$T>(a: $a, b: $b)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Example<T> &&
            (identical(other.a, a) || other.a == a) &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a, b);

  @JsonKey(ignore: true)
  @override
  _$ExampleCopyWith<T, _Example<T>> get copyWith =>
      __$ExampleCopyWithImpl<T, _Example<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int a, String b) $default, {
    required TResult Function(T c) named,
  }) {
    return $default(a, b);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(int a, String b)? $default, {
    TResult Function(T c)? named,
  }) {
    return $default?.call(a, b);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int a, String b)? $default, {
    TResult Function(T c)? named,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(a, b);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Example<T> value) $default, {
    required TResult Function(_Example2<T> value) named,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_Example<T> value)? $default, {
    TResult Function(_Example2<T> value)? named,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Example<T> value)? $default, {
    TResult Function(_Example2<T> value)? named,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _Example<T> implements Example<T> {
  factory _Example(int a, String b) = _$_Example<T>;

  int get a;
  String get b;
  @JsonKey(ignore: true)
  _$ExampleCopyWith<T, _Example<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$Example2CopyWith<T, $Res> {
  factory _$Example2CopyWith(
          _Example2<T> value, $Res Function(_Example2<T>) then) =
      __$Example2CopyWithImpl<T, $Res>;
  $Res call({T c});
}

/// @nodoc
class __$Example2CopyWithImpl<T, $Res> extends _$ExampleCopyWithImpl<T, $Res>
    implements _$Example2CopyWith<T, $Res> {
  __$Example2CopyWithImpl(
      _Example2<T> _value, $Res Function(_Example2<T>) _then)
      : super(_value, (v) => _then(v as _Example2<T>));

  @override
  _Example2<T> get _value => super._value as _Example2<T>;

  @override
  $Res call({
    Object? c = freezed,
  }) {
    return _then(_Example2<T>(
      c == freezed
          ? _value.c
          : c // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$_Example2<T> implements _Example2<T> {
  _$_Example2(this.c);

  @override
  final T c;

  @override
  String toString() {
    return 'Example<$T>.named(c: $c)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Example2<T> &&
            const DeepCollectionEquality().equals(other.c, c));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(c));

  @JsonKey(ignore: true)
  @override
  _$Example2CopyWith<T, _Example2<T>> get copyWith =>
      __$Example2CopyWithImpl<T, _Example2<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int a, String b) $default, {
    required TResult Function(T c) named,
  }) {
    return named(c);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(int a, String b)? $default, {
    TResult Function(T c)? named,
  }) {
    return named?.call(c);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int a, String b)? $default, {
    TResult Function(T c)? named,
    required TResult orElse(),
  }) {
    if (named != null) {
      return named(c);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Example<T> value) $default, {
    required TResult Function(_Example2<T> value) named,
  }) {
    return named(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_Example<T> value)? $default, {
    TResult Function(_Example2<T> value)? named,
  }) {
    return named?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Example<T> value)? $default, {
    TResult Function(_Example2<T> value)? named,
    required TResult orElse(),
  }) {
    if (named != null) {
      return named(this);
    }
    return orElse();
  }
}

abstract class _Example2<T> implements Example<T> {
  factory _Example2(T c) = _$_Example2<T>;

  T get c;
  @JsonKey(ignore: true)
  _$Example2CopyWith<T, _Example2<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$SimpleImplementsTearOff {
  const _$SimpleImplementsTearOff();

  SimplePerson person(String name, int age) {
    return SimplePerson(
      name,
      age,
    );
  }

  SimpleStreet street(String name) {
    return SimpleStreet(
      name,
    );
  }

  SimpleCity city(String name, int population) {
    return SimpleCity(
      name,
      population,
    );
  }

  SimpleCountry country(String name, int population) {
    return SimpleCountry(
      name,
      population,
    );
  }
}

/// @nodoc
const $SimpleImplements = _$SimpleImplementsTearOff();

/// @nodoc
mixin _$SimpleImplements {
  String get name => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, int age) person,
    required TResult Function(String name) street,
    required TResult Function(String name, int population) city,
    required TResult Function(String name, int population) country,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, int age)? person,
    TResult Function(String name)? street,
    TResult Function(String name, int population)? city,
    TResult Function(String name, int population)? country,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, int age)? person,
    TResult Function(String name)? street,
    TResult Function(String name, int population)? city,
    TResult Function(String name, int population)? country,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SimplePerson value) person,
    required TResult Function(SimpleStreet value) street,
    required TResult Function(SimpleCity value) city,
    required TResult Function(SimpleCountry value) country,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SimplePerson value)? person,
    TResult Function(SimpleStreet value)? street,
    TResult Function(SimpleCity value)? city,
    TResult Function(SimpleCountry value)? country,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SimplePerson value)? person,
    TResult Function(SimpleStreet value)? street,
    TResult Function(SimpleCity value)? city,
    TResult Function(SimpleCountry value)? country,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SimpleImplementsCopyWith<SimpleImplements> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimpleImplementsCopyWith<$Res> {
  factory $SimpleImplementsCopyWith(
          SimpleImplements value, $Res Function(SimpleImplements) then) =
      _$SimpleImplementsCopyWithImpl<$Res>;
  $Res call({String name});
}

/// @nodoc
class _$SimpleImplementsCopyWithImpl<$Res>
    implements $SimpleImplementsCopyWith<$Res> {
  _$SimpleImplementsCopyWithImpl(this._value, this._then);

  final SimpleImplements _value;
  // ignore: unused_field
  final $Res Function(SimpleImplements) _then;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class $SimplePersonCopyWith<$Res>
    implements $SimpleImplementsCopyWith<$Res> {
  factory $SimplePersonCopyWith(
          SimplePerson value, $Res Function(SimplePerson) then) =
      _$SimplePersonCopyWithImpl<$Res>;
  @override
  $Res call({String name, int age});
}

/// @nodoc
class _$SimplePersonCopyWithImpl<$Res>
    extends _$SimpleImplementsCopyWithImpl<$Res>
    implements $SimplePersonCopyWith<$Res> {
  _$SimplePersonCopyWithImpl(
      SimplePerson _value, $Res Function(SimplePerson) _then)
      : super(_value, (v) => _then(v as SimplePerson));

  @override
  SimplePerson get _value => super._value as SimplePerson;

  @override
  $Res call({
    Object? name = freezed,
    Object? age = freezed,
  }) {
    return _then(SimplePerson(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age == freezed
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$SimplePerson implements SimplePerson {
  const _$SimplePerson(this.name, this.age);

  @override
  final String name;
  @override
  final int age;

  @override
  String toString() {
    return 'SimpleImplements.person(name: $name, age: $age)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SimplePerson &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, age);

  @JsonKey(ignore: true)
  @override
  $SimplePersonCopyWith<SimplePerson> get copyWith =>
      _$SimplePersonCopyWithImpl<SimplePerson>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, int age) person,
    required TResult Function(String name) street,
    required TResult Function(String name, int population) city,
    required TResult Function(String name, int population) country,
  }) {
    return person(name, age);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, int age)? person,
    TResult Function(String name)? street,
    TResult Function(String name, int population)? city,
    TResult Function(String name, int population)? country,
  }) {
    return person?.call(name, age);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, int age)? person,
    TResult Function(String name)? street,
    TResult Function(String name, int population)? city,
    TResult Function(String name, int population)? country,
    required TResult orElse(),
  }) {
    if (person != null) {
      return person(name, age);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SimplePerson value) person,
    required TResult Function(SimpleStreet value) street,
    required TResult Function(SimpleCity value) city,
    required TResult Function(SimpleCountry value) country,
  }) {
    return person(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SimplePerson value)? person,
    TResult Function(SimpleStreet value)? street,
    TResult Function(SimpleCity value)? city,
    TResult Function(SimpleCountry value)? country,
  }) {
    return person?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SimplePerson value)? person,
    TResult Function(SimpleStreet value)? street,
    TResult Function(SimpleCity value)? city,
    TResult Function(SimpleCountry value)? country,
    required TResult orElse(),
  }) {
    if (person != null) {
      return person(this);
    }
    return orElse();
  }
}

abstract class SimplePerson implements SimpleImplements {
  const factory SimplePerson(String name, int age) = _$SimplePerson;

  @override
  String get name;
  int get age;
  @override
  @JsonKey(ignore: true)
  $SimplePersonCopyWith<SimplePerson> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimpleStreetCopyWith<$Res>
    implements $SimpleImplementsCopyWith<$Res> {
  factory $SimpleStreetCopyWith(
          SimpleStreet value, $Res Function(SimpleStreet) then) =
      _$SimpleStreetCopyWithImpl<$Res>;
  @override
  $Res call({String name});
}

/// @nodoc
class _$SimpleStreetCopyWithImpl<$Res>
    extends _$SimpleImplementsCopyWithImpl<$Res>
    implements $SimpleStreetCopyWith<$Res> {
  _$SimpleStreetCopyWithImpl(
      SimpleStreet _value, $Res Function(SimpleStreet) _then)
      : super(_value, (v) => _then(v as SimpleStreet));

  @override
  SimpleStreet get _value => super._value as SimpleStreet;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(SimpleStreet(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@With<AdministrativeArea<House>>()
class _$SimpleStreet with AdministrativeArea<House> implements SimpleStreet {
  const _$SimpleStreet(this.name);

  @override
  final String name;

  @override
  String toString() {
    return 'SimpleImplements.street(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SimpleStreet &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  $SimpleStreetCopyWith<SimpleStreet> get copyWith =>
      _$SimpleStreetCopyWithImpl<SimpleStreet>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, int age) person,
    required TResult Function(String name) street,
    required TResult Function(String name, int population) city,
    required TResult Function(String name, int population) country,
  }) {
    return street(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, int age)? person,
    TResult Function(String name)? street,
    TResult Function(String name, int population)? city,
    TResult Function(String name, int population)? country,
  }) {
    return street?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, int age)? person,
    TResult Function(String name)? street,
    TResult Function(String name, int population)? city,
    TResult Function(String name, int population)? country,
    required TResult orElse(),
  }) {
    if (street != null) {
      return street(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SimplePerson value) person,
    required TResult Function(SimpleStreet value) street,
    required TResult Function(SimpleCity value) city,
    required TResult Function(SimpleCountry value) country,
  }) {
    return street(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SimplePerson value)? person,
    TResult Function(SimpleStreet value)? street,
    TResult Function(SimpleCity value)? city,
    TResult Function(SimpleCountry value)? country,
  }) {
    return street?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SimplePerson value)? person,
    TResult Function(SimpleStreet value)? street,
    TResult Function(SimpleCity value)? city,
    TResult Function(SimpleCountry value)? country,
    required TResult orElse(),
  }) {
    if (street != null) {
      return street(this);
    }
    return orElse();
  }
}

abstract class SimpleStreet
    implements SimpleImplements, AdministrativeArea<House> {
  const factory SimpleStreet(String name) = _$SimpleStreet;

  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  $SimpleStreetCopyWith<SimpleStreet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimpleCityCopyWith<$Res>
    implements $SimpleImplementsCopyWith<$Res> {
  factory $SimpleCityCopyWith(
          SimpleCity value, $Res Function(SimpleCity) then) =
      _$SimpleCityCopyWithImpl<$Res>;
  @override
  $Res call({String name, int population});
}

/// @nodoc
class _$SimpleCityCopyWithImpl<$Res>
    extends _$SimpleImplementsCopyWithImpl<$Res>
    implements $SimpleCityCopyWith<$Res> {
  _$SimpleCityCopyWithImpl(SimpleCity _value, $Res Function(SimpleCity) _then)
      : super(_value, (v) => _then(v as SimpleCity));

  @override
  SimpleCity get _value => super._value as SimpleCity;

  @override
  $Res call({
    Object? name = freezed,
    Object? population = freezed,
  }) {
    return _then(SimpleCity(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      population == freezed
          ? _value.population
          : population // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@With<House>()
class _$SimpleCity with House implements SimpleCity {
  const _$SimpleCity(this.name, this.population);

  @override
  final String name;
  @override
  final int population;

  @override
  String toString() {
    return 'SimpleImplements.city(name: $name, population: $population)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SimpleCity &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.population, population) ||
                other.population == population));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, population);

  @JsonKey(ignore: true)
  @override
  $SimpleCityCopyWith<SimpleCity> get copyWith =>
      _$SimpleCityCopyWithImpl<SimpleCity>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, int age) person,
    required TResult Function(String name) street,
    required TResult Function(String name, int population) city,
    required TResult Function(String name, int population) country,
  }) {
    return city(name, population);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, int age)? person,
    TResult Function(String name)? street,
    TResult Function(String name, int population)? city,
    TResult Function(String name, int population)? country,
  }) {
    return city?.call(name, population);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, int age)? person,
    TResult Function(String name)? street,
    TResult Function(String name, int population)? city,
    TResult Function(String name, int population)? country,
    required TResult orElse(),
  }) {
    if (city != null) {
      return city(name, population);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SimplePerson value) person,
    required TResult Function(SimpleStreet value) street,
    required TResult Function(SimpleCity value) city,
    required TResult Function(SimpleCountry value) country,
  }) {
    return city(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SimplePerson value)? person,
    TResult Function(SimpleStreet value)? street,
    TResult Function(SimpleCity value)? city,
    TResult Function(SimpleCountry value)? country,
  }) {
    return city?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SimplePerson value)? person,
    TResult Function(SimpleStreet value)? street,
    TResult Function(SimpleCity value)? city,
    TResult Function(SimpleCountry value)? country,
    required TResult orElse(),
  }) {
    if (city != null) {
      return city(this);
    }
    return orElse();
  }
}

abstract class SimpleCity implements SimpleImplements, House {
  const factory SimpleCity(String name, int population) = _$SimpleCity;

  @override
  String get name;
  int get population;
  @override
  @JsonKey(ignore: true)
  $SimpleCityCopyWith<SimpleCity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimpleCountryCopyWith<$Res>
    implements $SimpleImplementsCopyWith<$Res> {
  factory $SimpleCountryCopyWith(
          SimpleCountry value, $Res Function(SimpleCountry) then) =
      _$SimpleCountryCopyWithImpl<$Res>;
  @override
  $Res call({String name, int population});
}

/// @nodoc
class _$SimpleCountryCopyWithImpl<$Res>
    extends _$SimpleImplementsCopyWithImpl<$Res>
    implements $SimpleCountryCopyWith<$Res> {
  _$SimpleCountryCopyWithImpl(
      SimpleCountry _value, $Res Function(SimpleCountry) _then)
      : super(_value, (v) => _then(v as SimpleCountry));

  @override
  SimpleCountry get _value => super._value as SimpleCountry;

  @override
  $Res call({
    Object? name = freezed,
    Object? population = freezed,
  }) {
    return _then(SimpleCountry(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      population == freezed
          ? _value.population
          : population // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@With<House>()
@Implements<GeographicArea>()
class _$SimpleCountry with House implements SimpleCountry {
  const _$SimpleCountry(this.name, this.population);

  @override
  final String name;
  @override
  final int population;

  @override
  String toString() {
    return 'SimpleImplements.country(name: $name, population: $population)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SimpleCountry &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.population, population) ||
                other.population == population));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, population);

  @JsonKey(ignore: true)
  @override
  $SimpleCountryCopyWith<SimpleCountry> get copyWith =>
      _$SimpleCountryCopyWithImpl<SimpleCountry>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, int age) person,
    required TResult Function(String name) street,
    required TResult Function(String name, int population) city,
    required TResult Function(String name, int population) country,
  }) {
    return country(name, population);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, int age)? person,
    TResult Function(String name)? street,
    TResult Function(String name, int population)? city,
    TResult Function(String name, int population)? country,
  }) {
    return country?.call(name, population);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, int age)? person,
    TResult Function(String name)? street,
    TResult Function(String name, int population)? city,
    TResult Function(String name, int population)? country,
    required TResult orElse(),
  }) {
    if (country != null) {
      return country(name, population);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SimplePerson value) person,
    required TResult Function(SimpleStreet value) street,
    required TResult Function(SimpleCity value) city,
    required TResult Function(SimpleCountry value) country,
  }) {
    return country(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SimplePerson value)? person,
    TResult Function(SimpleStreet value)? street,
    TResult Function(SimpleCity value)? city,
    TResult Function(SimpleCountry value)? country,
  }) {
    return country?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SimplePerson value)? person,
    TResult Function(SimpleStreet value)? street,
    TResult Function(SimpleCity value)? city,
    TResult Function(SimpleCountry value)? country,
    required TResult orElse(),
  }) {
    if (country != null) {
      return country(this);
    }
    return orElse();
  }
}

abstract class SimpleCountry
    implements SimpleImplements, GeographicArea, House {
  const factory SimpleCountry(String name, int population) = _$SimpleCountry;

  @override
  String get name;
  int get population;
  @override
  @JsonKey(ignore: true)
  $SimpleCountryCopyWith<SimpleCountry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$CustomMethodImplementsTearOff {
  const _$CustomMethodImplementsTearOff();

  PersonCustomMethod person(String name, int age) {
    return PersonCustomMethod(
      name,
      age,
    );
  }

  StreetCustomMethod street(String name) {
    return StreetCustomMethod(
      name,
    );
  }

  CityCustomMethod city(String name, int population) {
    return CityCustomMethod(
      name,
      population,
    );
  }

  DuplexCustomMethod duplex(String name) {
    return DuplexCustomMethod(
      name,
    );
  }
}

/// @nodoc
const $CustomMethodImplements = _$CustomMethodImplementsTearOff();

/// @nodoc
mixin _$CustomMethodImplements {
  String get name => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, int age) person,
    required TResult Function(String name) street,
    required TResult Function(String name, int population) city,
    required TResult Function(String name) duplex,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, int age)? person,
    TResult Function(String name)? street,
    TResult Function(String name, int population)? city,
    TResult Function(String name)? duplex,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, int age)? person,
    TResult Function(String name)? street,
    TResult Function(String name, int population)? city,
    TResult Function(String name)? duplex,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PersonCustomMethod value) person,
    required TResult Function(StreetCustomMethod value) street,
    required TResult Function(CityCustomMethod value) city,
    required TResult Function(DuplexCustomMethod value) duplex,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(PersonCustomMethod value)? person,
    TResult Function(StreetCustomMethod value)? street,
    TResult Function(CityCustomMethod value)? city,
    TResult Function(DuplexCustomMethod value)? duplex,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PersonCustomMethod value)? person,
    TResult Function(StreetCustomMethod value)? street,
    TResult Function(CityCustomMethod value)? city,
    TResult Function(DuplexCustomMethod value)? duplex,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CustomMethodImplementsCopyWith<CustomMethodImplements> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomMethodImplementsCopyWith<$Res> {
  factory $CustomMethodImplementsCopyWith(CustomMethodImplements value,
          $Res Function(CustomMethodImplements) then) =
      _$CustomMethodImplementsCopyWithImpl<$Res>;
  $Res call({String name});
}

/// @nodoc
class _$CustomMethodImplementsCopyWithImpl<$Res>
    implements $CustomMethodImplementsCopyWith<$Res> {
  _$CustomMethodImplementsCopyWithImpl(this._value, this._then);

  final CustomMethodImplements _value;
  // ignore: unused_field
  final $Res Function(CustomMethodImplements) _then;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class $PersonCustomMethodCopyWith<$Res>
    implements $CustomMethodImplementsCopyWith<$Res> {
  factory $PersonCustomMethodCopyWith(
          PersonCustomMethod value, $Res Function(PersonCustomMethod) then) =
      _$PersonCustomMethodCopyWithImpl<$Res>;
  @override
  $Res call({String name, int age});
}

/// @nodoc
class _$PersonCustomMethodCopyWithImpl<$Res>
    extends _$CustomMethodImplementsCopyWithImpl<$Res>
    implements $PersonCustomMethodCopyWith<$Res> {
  _$PersonCustomMethodCopyWithImpl(
      PersonCustomMethod _value, $Res Function(PersonCustomMethod) _then)
      : super(_value, (v) => _then(v as PersonCustomMethod));

  @override
  PersonCustomMethod get _value => super._value as PersonCustomMethod;

  @override
  $Res call({
    Object? name = freezed,
    Object? age = freezed,
  }) {
    return _then(PersonCustomMethod(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age == freezed
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$PersonCustomMethod extends PersonCustomMethod {
  const _$PersonCustomMethod(this.name, this.age) : super._();

  @override
  final String name;
  @override
  final int age;

  @override
  String toString() {
    return 'CustomMethodImplements.person(name: $name, age: $age)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PersonCustomMethod &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, age);

  @JsonKey(ignore: true)
  @override
  $PersonCustomMethodCopyWith<PersonCustomMethod> get copyWith =>
      _$PersonCustomMethodCopyWithImpl<PersonCustomMethod>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, int age) person,
    required TResult Function(String name) street,
    required TResult Function(String name, int population) city,
    required TResult Function(String name) duplex,
  }) {
    return person(name, age);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, int age)? person,
    TResult Function(String name)? street,
    TResult Function(String name, int population)? city,
    TResult Function(String name)? duplex,
  }) {
    return person?.call(name, age);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, int age)? person,
    TResult Function(String name)? street,
    TResult Function(String name, int population)? city,
    TResult Function(String name)? duplex,
    required TResult orElse(),
  }) {
    if (person != null) {
      return person(name, age);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PersonCustomMethod value) person,
    required TResult Function(StreetCustomMethod value) street,
    required TResult Function(CityCustomMethod value) city,
    required TResult Function(DuplexCustomMethod value) duplex,
  }) {
    return person(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(PersonCustomMethod value)? person,
    TResult Function(StreetCustomMethod value)? street,
    TResult Function(CityCustomMethod value)? city,
    TResult Function(DuplexCustomMethod value)? duplex,
  }) {
    return person?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PersonCustomMethod value)? person,
    TResult Function(StreetCustomMethod value)? street,
    TResult Function(CityCustomMethod value)? city,
    TResult Function(DuplexCustomMethod value)? duplex,
    required TResult orElse(),
  }) {
    if (person != null) {
      return person(this);
    }
    return orElse();
  }
}

abstract class PersonCustomMethod extends CustomMethodImplements {
  const factory PersonCustomMethod(String name, int age) = _$PersonCustomMethod;
  const PersonCustomMethod._() : super._();

  @override
  String get name;
  int get age;
  @override
  @JsonKey(ignore: true)
  $PersonCustomMethodCopyWith<PersonCustomMethod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreetCustomMethodCopyWith<$Res>
    implements $CustomMethodImplementsCopyWith<$Res> {
  factory $StreetCustomMethodCopyWith(
          StreetCustomMethod value, $Res Function(StreetCustomMethod) then) =
      _$StreetCustomMethodCopyWithImpl<$Res>;
  @override
  $Res call({String name});
}

/// @nodoc
class _$StreetCustomMethodCopyWithImpl<$Res>
    extends _$CustomMethodImplementsCopyWithImpl<$Res>
    implements $StreetCustomMethodCopyWith<$Res> {
  _$StreetCustomMethodCopyWithImpl(
      StreetCustomMethod _value, $Res Function(StreetCustomMethod) _then)
      : super(_value, (v) => _then(v as StreetCustomMethod));

  @override
  StreetCustomMethod get _value => super._value as StreetCustomMethod;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(StreetCustomMethod(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@With<Shop>()
@With<AdministrativeArea<House>>()
class _$StreetCustomMethod extends StreetCustomMethod
    with Shop, AdministrativeArea<House> {
  const _$StreetCustomMethod(this.name) : super._();

  @override
  final String name;

  @override
  String toString() {
    return 'CustomMethodImplements.street(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StreetCustomMethod &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  $StreetCustomMethodCopyWith<StreetCustomMethod> get copyWith =>
      _$StreetCustomMethodCopyWithImpl<StreetCustomMethod>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, int age) person,
    required TResult Function(String name) street,
    required TResult Function(String name, int population) city,
    required TResult Function(String name) duplex,
  }) {
    return street(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, int age)? person,
    TResult Function(String name)? street,
    TResult Function(String name, int population)? city,
    TResult Function(String name)? duplex,
  }) {
    return street?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, int age)? person,
    TResult Function(String name)? street,
    TResult Function(String name, int population)? city,
    TResult Function(String name)? duplex,
    required TResult orElse(),
  }) {
    if (street != null) {
      return street(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PersonCustomMethod value) person,
    required TResult Function(StreetCustomMethod value) street,
    required TResult Function(CityCustomMethod value) city,
    required TResult Function(DuplexCustomMethod value) duplex,
  }) {
    return street(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(PersonCustomMethod value)? person,
    TResult Function(StreetCustomMethod value)? street,
    TResult Function(CityCustomMethod value)? city,
    TResult Function(DuplexCustomMethod value)? duplex,
  }) {
    return street?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PersonCustomMethod value)? person,
    TResult Function(StreetCustomMethod value)? street,
    TResult Function(CityCustomMethod value)? city,
    TResult Function(DuplexCustomMethod value)? duplex,
    required TResult orElse(),
  }) {
    if (street != null) {
      return street(this);
    }
    return orElse();
  }
}

abstract class StreetCustomMethod extends CustomMethodImplements
    implements Shop, AdministrativeArea<House> {
  const factory StreetCustomMethod(String name) = _$StreetCustomMethod;
  const StreetCustomMethod._() : super._();

  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  $StreetCustomMethodCopyWith<StreetCustomMethod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CityCustomMethodCopyWith<$Res>
    implements $CustomMethodImplementsCopyWith<$Res> {
  factory $CityCustomMethodCopyWith(
          CityCustomMethod value, $Res Function(CityCustomMethod) then) =
      _$CityCustomMethodCopyWithImpl<$Res>;
  @override
  $Res call({String name, int population});
}

/// @nodoc
class _$CityCustomMethodCopyWithImpl<$Res>
    extends _$CustomMethodImplementsCopyWithImpl<$Res>
    implements $CityCustomMethodCopyWith<$Res> {
  _$CityCustomMethodCopyWithImpl(
      CityCustomMethod _value, $Res Function(CityCustomMethod) _then)
      : super(_value, (v) => _then(v as CityCustomMethod));

  @override
  CityCustomMethod get _value => super._value as CityCustomMethod;

  @override
  $Res call({
    Object? name = freezed,
    Object? population = freezed,
  }) {
    return _then(CityCustomMethod(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      population == freezed
          ? _value.population
          : population // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@With<House>()
@Implements<GeographicArea>()
class _$CityCustomMethod extends CityCustomMethod with House {
  const _$CityCustomMethod(this.name, this.population) : super._();

  @override
  final String name;
  @override
  final int population;

  @override
  String toString() {
    return 'CustomMethodImplements.city(name: $name, population: $population)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CityCustomMethod &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.population, population) ||
                other.population == population));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, population);

  @JsonKey(ignore: true)
  @override
  $CityCustomMethodCopyWith<CityCustomMethod> get copyWith =>
      _$CityCustomMethodCopyWithImpl<CityCustomMethod>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, int age) person,
    required TResult Function(String name) street,
    required TResult Function(String name, int population) city,
    required TResult Function(String name) duplex,
  }) {
    return city(name, population);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, int age)? person,
    TResult Function(String name)? street,
    TResult Function(String name, int population)? city,
    TResult Function(String name)? duplex,
  }) {
    return city?.call(name, population);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, int age)? person,
    TResult Function(String name)? street,
    TResult Function(String name, int population)? city,
    TResult Function(String name)? duplex,
    required TResult orElse(),
  }) {
    if (city != null) {
      return city(name, population);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PersonCustomMethod value) person,
    required TResult Function(StreetCustomMethod value) street,
    required TResult Function(CityCustomMethod value) city,
    required TResult Function(DuplexCustomMethod value) duplex,
  }) {
    return city(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(PersonCustomMethod value)? person,
    TResult Function(StreetCustomMethod value)? street,
    TResult Function(CityCustomMethod value)? city,
    TResult Function(DuplexCustomMethod value)? duplex,
  }) {
    return city?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PersonCustomMethod value)? person,
    TResult Function(StreetCustomMethod value)? street,
    TResult Function(CityCustomMethod value)? city,
    TResult Function(DuplexCustomMethod value)? duplex,
    required TResult orElse(),
  }) {
    if (city != null) {
      return city(this);
    }
    return orElse();
  }
}

abstract class CityCustomMethod extends CustomMethodImplements
    implements GeographicArea, House {
  const factory CityCustomMethod(String name, int population) =
      _$CityCustomMethod;
  const CityCustomMethod._() : super._();

  @override
  String get name;
  int get population;
  @override
  @JsonKey(ignore: true)
  $CityCustomMethodCopyWith<CityCustomMethod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DuplexCustomMethodCopyWith<$Res>
    implements $CustomMethodImplementsCopyWith<$Res> {
  factory $DuplexCustomMethodCopyWith(
          DuplexCustomMethod value, $Res Function(DuplexCustomMethod) then) =
      _$DuplexCustomMethodCopyWithImpl<$Res>;
  @override
  $Res call({String name});
}

/// @nodoc
class _$DuplexCustomMethodCopyWithImpl<$Res>
    extends _$CustomMethodImplementsCopyWithImpl<$Res>
    implements $DuplexCustomMethodCopyWith<$Res> {
  _$DuplexCustomMethodCopyWithImpl(
      DuplexCustomMethod _value, $Res Function(DuplexCustomMethod) _then)
      : super(_value, (v) => _then(v as DuplexCustomMethod));

  @override
  DuplexCustomMethod get _value => super._value as DuplexCustomMethod;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(DuplexCustomMethod(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@Implements<Shop>()
@Implements<GeographicArea>()
class _$DuplexCustomMethod extends DuplexCustomMethod {
  const _$DuplexCustomMethod(this.name) : super._();

  @override
  final String name;

  @override
  String toString() {
    return 'CustomMethodImplements.duplex(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DuplexCustomMethod &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  $DuplexCustomMethodCopyWith<DuplexCustomMethod> get copyWith =>
      _$DuplexCustomMethodCopyWithImpl<DuplexCustomMethod>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, int age) person,
    required TResult Function(String name) street,
    required TResult Function(String name, int population) city,
    required TResult Function(String name) duplex,
  }) {
    return duplex(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, int age)? person,
    TResult Function(String name)? street,
    TResult Function(String name, int population)? city,
    TResult Function(String name)? duplex,
  }) {
    return duplex?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, int age)? person,
    TResult Function(String name)? street,
    TResult Function(String name, int population)? city,
    TResult Function(String name)? duplex,
    required TResult orElse(),
  }) {
    if (duplex != null) {
      return duplex(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PersonCustomMethod value) person,
    required TResult Function(StreetCustomMethod value) street,
    required TResult Function(CityCustomMethod value) city,
    required TResult Function(DuplexCustomMethod value) duplex,
  }) {
    return duplex(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(PersonCustomMethod value)? person,
    TResult Function(StreetCustomMethod value)? street,
    TResult Function(CityCustomMethod value)? city,
    TResult Function(DuplexCustomMethod value)? duplex,
  }) {
    return duplex?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PersonCustomMethod value)? person,
    TResult Function(StreetCustomMethod value)? street,
    TResult Function(CityCustomMethod value)? city,
    TResult Function(DuplexCustomMethod value)? duplex,
    required TResult orElse(),
  }) {
    if (duplex != null) {
      return duplex(this);
    }
    return orElse();
  }
}

abstract class DuplexCustomMethod extends CustomMethodImplements
    implements Shop, GeographicArea {
  const factory DuplexCustomMethod(String name) = _$DuplexCustomMethod;
  const DuplexCustomMethod._() : super._();

  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  $DuplexCustomMethodCopyWith<DuplexCustomMethod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$GenericImplementsTearOff {
  const _$GenericImplementsTearOff();

  GenericPerson<T> person<T>(String name, int age) {
    return GenericPerson<T>(
      name,
      age,
    );
  }

  GenericCity<T> city<T>(String name, int population) {
    return GenericCity<T>(
      name,
      population,
    );
  }
}

/// @nodoc
const $GenericImplements = _$GenericImplementsTearOff();

/// @nodoc
mixin _$GenericImplements<T> {
  String get name => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, int age) person,
    required TResult Function(String name, int population) city,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, int age)? person,
    TResult Function(String name, int population)? city,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, int age)? person,
    TResult Function(String name, int population)? city,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenericPerson<T> value) person,
    required TResult Function(GenericCity<T> value) city,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(GenericPerson<T> value)? person,
    TResult Function(GenericCity<T> value)? city,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenericPerson<T> value)? person,
    TResult Function(GenericCity<T> value)? city,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GenericImplementsCopyWith<T, GenericImplements<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenericImplementsCopyWith<T, $Res> {
  factory $GenericImplementsCopyWith(GenericImplements<T> value,
          $Res Function(GenericImplements<T>) then) =
      _$GenericImplementsCopyWithImpl<T, $Res>;
  $Res call({String name});
}

/// @nodoc
class _$GenericImplementsCopyWithImpl<T, $Res>
    implements $GenericImplementsCopyWith<T, $Res> {
  _$GenericImplementsCopyWithImpl(this._value, this._then);

  final GenericImplements<T> _value;
  // ignore: unused_field
  final $Res Function(GenericImplements<T>) _then;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class $GenericPersonCopyWith<T, $Res>
    implements $GenericImplementsCopyWith<T, $Res> {
  factory $GenericPersonCopyWith(
          GenericPerson<T> value, $Res Function(GenericPerson<T>) then) =
      _$GenericPersonCopyWithImpl<T, $Res>;
  @override
  $Res call({String name, int age});
}

/// @nodoc
class _$GenericPersonCopyWithImpl<T, $Res>
    extends _$GenericImplementsCopyWithImpl<T, $Res>
    implements $GenericPersonCopyWith<T, $Res> {
  _$GenericPersonCopyWithImpl(
      GenericPerson<T> _value, $Res Function(GenericPerson<T>) _then)
      : super(_value, (v) => _then(v as GenericPerson<T>));

  @override
  GenericPerson<T> get _value => super._value as GenericPerson<T>;

  @override
  $Res call({
    Object? name = freezed,
    Object? age = freezed,
  }) {
    return _then(GenericPerson<T>(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age == freezed
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$GenericPerson<T> implements GenericPerson<T> {
  const _$GenericPerson(this.name, this.age);

  @override
  final String name;
  @override
  final int age;

  @override
  String toString() {
    return 'GenericImplements<$T>.person(name: $name, age: $age)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GenericPerson<T> &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, age);

  @JsonKey(ignore: true)
  @override
  $GenericPersonCopyWith<T, GenericPerson<T>> get copyWith =>
      _$GenericPersonCopyWithImpl<T, GenericPerson<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, int age) person,
    required TResult Function(String name, int population) city,
  }) {
    return person(name, age);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, int age)? person,
    TResult Function(String name, int population)? city,
  }) {
    return person?.call(name, age);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, int age)? person,
    TResult Function(String name, int population)? city,
    required TResult orElse(),
  }) {
    if (person != null) {
      return person(name, age);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenericPerson<T> value) person,
    required TResult Function(GenericCity<T> value) city,
  }) {
    return person(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(GenericPerson<T> value)? person,
    TResult Function(GenericCity<T> value)? city,
  }) {
    return person?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenericPerson<T> value)? person,
    TResult Function(GenericCity<T> value)? city,
    required TResult orElse(),
  }) {
    if (person != null) {
      return person(this);
    }
    return orElse();
  }
}

abstract class GenericPerson<T> implements GenericImplements<T> {
  const factory GenericPerson(String name, int age) = _$GenericPerson<T>;

  @override
  String get name;
  int get age;
  @override
  @JsonKey(ignore: true)
  $GenericPersonCopyWith<T, GenericPerson<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenericCityCopyWith<T, $Res>
    implements $GenericImplementsCopyWith<T, $Res> {
  factory $GenericCityCopyWith(
          GenericCity<T> value, $Res Function(GenericCity<T>) then) =
      _$GenericCityCopyWithImpl<T, $Res>;
  @override
  $Res call({String name, int population});
}

/// @nodoc
class _$GenericCityCopyWithImpl<T, $Res>
    extends _$GenericImplementsCopyWithImpl<T, $Res>
    implements $GenericCityCopyWith<T, $Res> {
  _$GenericCityCopyWithImpl(
      GenericCity<T> _value, $Res Function(GenericCity<T>) _then)
      : super(_value, (v) => _then(v as GenericCity<T>));

  @override
  GenericCity<T> get _value => super._value as GenericCity<T>;

  @override
  $Res call({
    Object? name = freezed,
    Object? population = freezed,
  }) {
    return _then(GenericCity<T>(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      population == freezed
          ? _value.population
          : population // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@With<House>()
@Implements<GeographicArea>()
class _$GenericCity<T> with House implements GenericCity<T> {
  const _$GenericCity(this.name, this.population);

  @override
  final String name;
  @override
  final int population;

  @override
  String toString() {
    return 'GenericImplements<$T>.city(name: $name, population: $population)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GenericCity<T> &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.population, population) ||
                other.population == population));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, population);

  @JsonKey(ignore: true)
  @override
  $GenericCityCopyWith<T, GenericCity<T>> get copyWith =>
      _$GenericCityCopyWithImpl<T, GenericCity<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, int age) person,
    required TResult Function(String name, int population) city,
  }) {
    return city(name, population);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, int age)? person,
    TResult Function(String name, int population)? city,
  }) {
    return city?.call(name, population);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, int age)? person,
    TResult Function(String name, int population)? city,
    required TResult orElse(),
  }) {
    if (city != null) {
      return city(name, population);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenericPerson<T> value) person,
    required TResult Function(GenericCity<T> value) city,
  }) {
    return city(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(GenericPerson<T> value)? person,
    TResult Function(GenericCity<T> value)? city,
  }) {
    return city?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenericPerson<T> value)? person,
    TResult Function(GenericCity<T> value)? city,
    required TResult orElse(),
  }) {
    if (city != null) {
      return city(this);
    }
    return orElse();
  }
}

abstract class GenericCity<T>
    implements GenericImplements<T>, GeographicArea, House {
  const factory GenericCity(String name, int population) = _$GenericCity<T>;

  @override
  String get name;
  int get population;
  @override
  @JsonKey(ignore: true)
  $GenericCityCopyWith<T, GenericCity<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
