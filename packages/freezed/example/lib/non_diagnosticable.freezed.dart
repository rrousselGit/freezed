// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'non_diagnosticable.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

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

// ignore: unused_element
const $Example = _$ExampleTearOff();

mixin _$Example<T> {
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(int a, String b), {
    @required Result named(T c),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(int a, String b), {
    Result named(T c),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(_Example<T> value), {
    @required Result named(_Example2<T> value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(_Example<T> value), {
    Result named(_Example2<T> value),
    @required Result orElse(),
  });
}

abstract class $ExampleCopyWith<T, $Res> {
  factory $ExampleCopyWith(Example<T> value, $Res Function(Example<T>) then) =
      _$ExampleCopyWithImpl<T, $Res>;
}

class _$ExampleCopyWithImpl<T, $Res> implements $ExampleCopyWith<T, $Res> {
  _$ExampleCopyWithImpl(this._value, this._then);

  final Example<T> _value;
  // ignore: unused_field
  final $Res Function(Example<T>) _then;
}

abstract class _$ExampleCopyWith<T, $Res> {
  factory _$ExampleCopyWith(
          _Example<T> value, $Res Function(_Example<T>) then) =
      __$ExampleCopyWithImpl<T, $Res>;
  $Res call({int a, String b});
}

class __$ExampleCopyWithImpl<T, $Res> extends _$ExampleCopyWithImpl<T, $Res>
    implements _$ExampleCopyWith<T, $Res> {
  __$ExampleCopyWithImpl(_Example<T> _value, $Res Function(_Example<T>) _then)
      : super(_value, (v) => _then(v as _Example<T>));

  @override
  _Example<T> get _value => super._value as _Example<T>;

  @override
  $Res call({
    Object a = freezed,
    Object b = freezed,
  }) {
    return _then(_Example<T>(
      a == freezed ? _value.a : a as int,
      b == freezed ? _value.b : b as String,
    ));
  }
}

class _$_Example<T> implements _Example<T> {
  _$_Example(this.a, this.b)
      : assert(a != null),
        assert(b != null);

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
        (other is _Example<T> &&
            (identical(other.a, a) ||
                const DeepCollectionEquality().equals(other.a, a)) &&
            (identical(other.b, b) ||
                const DeepCollectionEquality().equals(other.b, b)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(a) ^
      const DeepCollectionEquality().hash(b);

  @override
  _$ExampleCopyWith<T, _Example<T>> get copyWith =>
      __$ExampleCopyWithImpl<T, _Example<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(int a, String b), {
    @required Result named(T c),
  }) {
    assert($default != null);
    assert(named != null);
    return $default(a, b);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(int a, String b), {
    Result named(T c),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if ($default != null) {
      return $default(a, b);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(_Example<T> value), {
    @required Result named(_Example2<T> value),
  }) {
    assert($default != null);
    assert(named != null);
    return $default(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(_Example<T> value), {
    Result named(_Example2<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
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
  _$ExampleCopyWith<T, _Example<T>> get copyWith;
}

abstract class _$Example2CopyWith<T, $Res> {
  factory _$Example2CopyWith(
          _Example2<T> value, $Res Function(_Example2<T>) then) =
      __$Example2CopyWithImpl<T, $Res>;
  $Res call({T c});
}

class __$Example2CopyWithImpl<T, $Res> extends _$ExampleCopyWithImpl<T, $Res>
    implements _$Example2CopyWith<T, $Res> {
  __$Example2CopyWithImpl(
      _Example2<T> _value, $Res Function(_Example2<T>) _then)
      : super(_value, (v) => _then(v as _Example2<T>));

  @override
  _Example2<T> get _value => super._value as _Example2<T>;

  @override
  $Res call({
    Object c = freezed,
  }) {
    return _then(_Example2<T>(
      c == freezed ? _value.c : c as T,
    ));
  }
}

class _$_Example2<T> implements _Example2<T> {
  _$_Example2(this.c) : assert(c != null);

  @override
  final T c;

  @override
  String toString() {
    return 'Example<$T>.named(c: $c)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Example2<T> &&
            (identical(other.c, c) ||
                const DeepCollectionEquality().equals(other.c, c)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(c);

  @override
  _$Example2CopyWith<T, _Example2<T>> get copyWith =>
      __$Example2CopyWithImpl<T, _Example2<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(int a, String b), {
    @required Result named(T c),
  }) {
    assert($default != null);
    assert(named != null);
    return named(c);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(int a, String b), {
    Result named(T c),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (named != null) {
      return named(c);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(_Example<T> value), {
    @required Result named(_Example2<T> value),
  }) {
    assert($default != null);
    assert(named != null);
    return named(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(_Example<T> value), {
    Result named(_Example2<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (named != null) {
      return named(this);
    }
    return orElse();
  }
}

abstract class _Example2<T> implements Example<T> {
  factory _Example2(T c) = _$_Example2<T>;

  T get c;
  _$Example2CopyWith<T, _Example2<T>> get copyWith;
}

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

// ignore: unused_element
const $SimpleImplements = _$SimpleImplementsTearOff();

mixin _$SimpleImplements {
  String get name;

  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result person(String name, int age),
    @required Result street(String name),
    @required Result city(String name, int population),
    @required Result country(String name, int population),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result person(String name, int age),
    Result street(String name),
    Result city(String name, int population),
    Result country(String name, int population),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result person(SimplePerson value),
    @required Result street(SimpleStreet value),
    @required Result city(SimpleCity value),
    @required Result country(SimpleCountry value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result person(SimplePerson value),
    Result street(SimpleStreet value),
    Result city(SimpleCity value),
    Result country(SimpleCountry value),
    @required Result orElse(),
  });

  $SimpleImplementsCopyWith<SimpleImplements> get copyWith;
}

abstract class $SimpleImplementsCopyWith<$Res> {
  factory $SimpleImplementsCopyWith(
          SimpleImplements value, $Res Function(SimpleImplements) then) =
      _$SimpleImplementsCopyWithImpl<$Res>;
  $Res call({String name});
}

class _$SimpleImplementsCopyWithImpl<$Res>
    implements $SimpleImplementsCopyWith<$Res> {
  _$SimpleImplementsCopyWithImpl(this._value, this._then);

  final SimpleImplements _value;
  // ignore: unused_field
  final $Res Function(SimpleImplements) _then;

  @override
  $Res call({
    Object name = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed ? _value.name : name as String,
    ));
  }
}

abstract class $SimplePersonCopyWith<$Res>
    implements $SimpleImplementsCopyWith<$Res> {
  factory $SimplePersonCopyWith(
          SimplePerson value, $Res Function(SimplePerson) then) =
      _$SimplePersonCopyWithImpl<$Res>;
  @override
  $Res call({String name, int age});
}

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
    Object name = freezed,
    Object age = freezed,
  }) {
    return _then(SimplePerson(
      name == freezed ? _value.name : name as String,
      age == freezed ? _value.age : age as int,
    ));
  }
}

class _$SimplePerson implements SimplePerson {
  const _$SimplePerson(this.name, this.age)
      : assert(name != null),
        assert(age != null);

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
        (other is SimplePerson &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.age, age) ||
                const DeepCollectionEquality().equals(other.age, age)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(age);

  @override
  $SimplePersonCopyWith<SimplePerson> get copyWith =>
      _$SimplePersonCopyWithImpl<SimplePerson>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result person(String name, int age),
    @required Result street(String name),
    @required Result city(String name, int population),
    @required Result country(String name, int population),
  }) {
    assert(person != null);
    assert(street != null);
    assert(city != null);
    assert(country != null);
    return person(name, age);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result person(String name, int age),
    Result street(String name),
    Result city(String name, int population),
    Result country(String name, int population),
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
    @required Result person(SimplePerson value),
    @required Result street(SimpleStreet value),
    @required Result city(SimpleCity value),
    @required Result country(SimpleCountry value),
  }) {
    assert(person != null);
    assert(street != null);
    assert(city != null);
    assert(country != null);
    return person(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result person(SimplePerson value),
    Result street(SimpleStreet value),
    Result city(SimpleCity value),
    Result country(SimpleCountry value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
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
  $SimplePersonCopyWith<SimplePerson> get copyWith;
}

abstract class $SimpleStreetCopyWith<$Res>
    implements $SimpleImplementsCopyWith<$Res> {
  factory $SimpleStreetCopyWith(
          SimpleStreet value, $Res Function(SimpleStreet) then) =
      _$SimpleStreetCopyWithImpl<$Res>;
  @override
  $Res call({String name});
}

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
    Object name = freezed,
  }) {
    return _then(SimpleStreet(
      name == freezed ? _value.name : name as String,
    ));
  }
}

@With.fromString('AdministrativeArea<House>')
class _$SimpleStreet implements SimpleStreet {
  const _$SimpleStreet(this.name) : assert(name != null);

  @override
  final String name;

  @override
  String toString() {
    return 'SimpleImplements.street(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SimpleStreet &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(name);

  @override
  $SimpleStreetCopyWith<SimpleStreet> get copyWith =>
      _$SimpleStreetCopyWithImpl<SimpleStreet>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result person(String name, int age),
    @required Result street(String name),
    @required Result city(String name, int population),
    @required Result country(String name, int population),
  }) {
    assert(person != null);
    assert(street != null);
    assert(city != null);
    assert(country != null);
    return street(name);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result person(String name, int age),
    Result street(String name),
    Result city(String name, int population),
    Result country(String name, int population),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (street != null) {
      return street(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result person(SimplePerson value),
    @required Result street(SimpleStreet value),
    @required Result city(SimpleCity value),
    @required Result country(SimpleCountry value),
  }) {
    assert(person != null);
    assert(street != null);
    assert(city != null);
    assert(country != null);
    return street(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result person(SimplePerson value),
    Result street(SimpleStreet value),
    Result city(SimpleCity value),
    Result country(SimpleCountry value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (street != null) {
      return street(this);
    }
    return orElse();
  }
}

abstract class SimpleStreet
    with AdministrativeArea<House>
    implements SimpleImplements {
  const factory SimpleStreet(String name) = _$SimpleStreet;

  @override
  String get name;
  @override
  $SimpleStreetCopyWith<SimpleStreet> get copyWith;
}

abstract class $SimpleCityCopyWith<$Res>
    implements $SimpleImplementsCopyWith<$Res> {
  factory $SimpleCityCopyWith(
          SimpleCity value, $Res Function(SimpleCity) then) =
      _$SimpleCityCopyWithImpl<$Res>;
  @override
  $Res call({String name, int population});
}

class _$SimpleCityCopyWithImpl<$Res>
    extends _$SimpleImplementsCopyWithImpl<$Res>
    implements $SimpleCityCopyWith<$Res> {
  _$SimpleCityCopyWithImpl(SimpleCity _value, $Res Function(SimpleCity) _then)
      : super(_value, (v) => _then(v as SimpleCity));

  @override
  SimpleCity get _value => super._value as SimpleCity;

  @override
  $Res call({
    Object name = freezed,
    Object population = freezed,
  }) {
    return _then(SimpleCity(
      name == freezed ? _value.name : name as String,
      population == freezed ? _value.population : population as int,
    ));
  }
}

@With(House)
class _$SimpleCity implements SimpleCity {
  const _$SimpleCity(this.name, this.population)
      : assert(name != null),
        assert(population != null);

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
        (other is SimpleCity &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.population, population) ||
                const DeepCollectionEquality()
                    .equals(other.population, population)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(population);

  @override
  $SimpleCityCopyWith<SimpleCity> get copyWith =>
      _$SimpleCityCopyWithImpl<SimpleCity>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result person(String name, int age),
    @required Result street(String name),
    @required Result city(String name, int population),
    @required Result country(String name, int population),
  }) {
    assert(person != null);
    assert(street != null);
    assert(city != null);
    assert(country != null);
    return city(name, population);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result person(String name, int age),
    Result street(String name),
    Result city(String name, int population),
    Result country(String name, int population),
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
    @required Result person(SimplePerson value),
    @required Result street(SimpleStreet value),
    @required Result city(SimpleCity value),
    @required Result country(SimpleCountry value),
  }) {
    assert(person != null);
    assert(street != null);
    assert(city != null);
    assert(country != null);
    return city(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result person(SimplePerson value),
    Result street(SimpleStreet value),
    Result city(SimpleCity value),
    Result country(SimpleCountry value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (city != null) {
      return city(this);
    }
    return orElse();
  }
}

abstract class SimpleCity with House implements SimpleImplements {
  const factory SimpleCity(String name, int population) = _$SimpleCity;

  @override
  String get name;
  int get population;
  @override
  $SimpleCityCopyWith<SimpleCity> get copyWith;
}

abstract class $SimpleCountryCopyWith<$Res>
    implements $SimpleImplementsCopyWith<$Res> {
  factory $SimpleCountryCopyWith(
          SimpleCountry value, $Res Function(SimpleCountry) then) =
      _$SimpleCountryCopyWithImpl<$Res>;
  @override
  $Res call({String name, int population});
}

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
    Object name = freezed,
    Object population = freezed,
  }) {
    return _then(SimpleCountry(
      name == freezed ? _value.name : name as String,
      population == freezed ? _value.population : population as int,
    ));
  }
}

@With(House)
@Implements(GeographicArea)
class _$SimpleCountry implements SimpleCountry {
  const _$SimpleCountry(this.name, this.population)
      : assert(name != null),
        assert(population != null);

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
        (other is SimpleCountry &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.population, population) ||
                const DeepCollectionEquality()
                    .equals(other.population, population)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(population);

  @override
  $SimpleCountryCopyWith<SimpleCountry> get copyWith =>
      _$SimpleCountryCopyWithImpl<SimpleCountry>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result person(String name, int age),
    @required Result street(String name),
    @required Result city(String name, int population),
    @required Result country(String name, int population),
  }) {
    assert(person != null);
    assert(street != null);
    assert(city != null);
    assert(country != null);
    return country(name, population);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result person(String name, int age),
    Result street(String name),
    Result city(String name, int population),
    Result country(String name, int population),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (country != null) {
      return country(name, population);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result person(SimplePerson value),
    @required Result street(SimpleStreet value),
    @required Result city(SimpleCity value),
    @required Result country(SimpleCountry value),
  }) {
    assert(person != null);
    assert(street != null);
    assert(city != null);
    assert(country != null);
    return country(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result person(SimplePerson value),
    Result street(SimpleStreet value),
    Result city(SimpleCity value),
    Result country(SimpleCountry value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (country != null) {
      return country(this);
    }
    return orElse();
  }
}

abstract class SimpleCountry
    with House
    implements SimpleImplements, GeographicArea {
  const factory SimpleCountry(String name, int population) = _$SimpleCountry;

  @override
  String get name;
  int get population;
  @override
  $SimpleCountryCopyWith<SimpleCountry> get copyWith;
}

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

// ignore: unused_element
const $CustomMethodImplements = _$CustomMethodImplementsTearOff();

mixin _$CustomMethodImplements {
  String get name;

  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result person(String name, int age),
    @required Result street(String name),
    @required Result city(String name, int population),
    @required Result duplex(String name),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result person(String name, int age),
    Result street(String name),
    Result city(String name, int population),
    Result duplex(String name),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result person(PersonCustomMethod value),
    @required Result street(StreetCustomMethod value),
    @required Result city(CityCustomMethod value),
    @required Result duplex(DuplexCustomMethod value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result person(PersonCustomMethod value),
    Result street(StreetCustomMethod value),
    Result city(CityCustomMethod value),
    Result duplex(DuplexCustomMethod value),
    @required Result orElse(),
  });

  $CustomMethodImplementsCopyWith<CustomMethodImplements> get copyWith;
}

abstract class $CustomMethodImplementsCopyWith<$Res> {
  factory $CustomMethodImplementsCopyWith(CustomMethodImplements value,
          $Res Function(CustomMethodImplements) then) =
      _$CustomMethodImplementsCopyWithImpl<$Res>;
  $Res call({String name});
}

class _$CustomMethodImplementsCopyWithImpl<$Res>
    implements $CustomMethodImplementsCopyWith<$Res> {
  _$CustomMethodImplementsCopyWithImpl(this._value, this._then);

  final CustomMethodImplements _value;
  // ignore: unused_field
  final $Res Function(CustomMethodImplements) _then;

  @override
  $Res call({
    Object name = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed ? _value.name : name as String,
    ));
  }
}

abstract class $PersonCustomMethodCopyWith<$Res>
    implements $CustomMethodImplementsCopyWith<$Res> {
  factory $PersonCustomMethodCopyWith(
          PersonCustomMethod value, $Res Function(PersonCustomMethod) then) =
      _$PersonCustomMethodCopyWithImpl<$Res>;
  @override
  $Res call({String name, int age});
}

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
    Object name = freezed,
    Object age = freezed,
  }) {
    return _then(PersonCustomMethod(
      name == freezed ? _value.name : name as String,
      age == freezed ? _value.age : age as int,
    ));
  }
}

class _$PersonCustomMethod extends PersonCustomMethod {
  const _$PersonCustomMethod(this.name, this.age)
      : assert(name != null),
        assert(age != null),
        super._();

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
        (other is PersonCustomMethod &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.age, age) ||
                const DeepCollectionEquality().equals(other.age, age)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(age);

  @override
  $PersonCustomMethodCopyWith<PersonCustomMethod> get copyWith =>
      _$PersonCustomMethodCopyWithImpl<PersonCustomMethod>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result person(String name, int age),
    @required Result street(String name),
    @required Result city(String name, int population),
    @required Result duplex(String name),
  }) {
    assert(person != null);
    assert(street != null);
    assert(city != null);
    assert(duplex != null);
    return person(name, age);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result person(String name, int age),
    Result street(String name),
    Result city(String name, int population),
    Result duplex(String name),
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
    @required Result person(PersonCustomMethod value),
    @required Result street(StreetCustomMethod value),
    @required Result city(CityCustomMethod value),
    @required Result duplex(DuplexCustomMethod value),
  }) {
    assert(person != null);
    assert(street != null);
    assert(city != null);
    assert(duplex != null);
    return person(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result person(PersonCustomMethod value),
    Result street(StreetCustomMethod value),
    Result city(CityCustomMethod value),
    Result duplex(DuplexCustomMethod value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (person != null) {
      return person(this);
    }
    return orElse();
  }
}

abstract class PersonCustomMethod extends CustomMethodImplements {
  const PersonCustomMethod._() : super._();
  const factory PersonCustomMethod(String name, int age) = _$PersonCustomMethod;

  @override
  String get name;
  int get age;
  @override
  $PersonCustomMethodCopyWith<PersonCustomMethod> get copyWith;
}

abstract class $StreetCustomMethodCopyWith<$Res>
    implements $CustomMethodImplementsCopyWith<$Res> {
  factory $StreetCustomMethodCopyWith(
          StreetCustomMethod value, $Res Function(StreetCustomMethod) then) =
      _$StreetCustomMethodCopyWithImpl<$Res>;
  @override
  $Res call({String name});
}

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
    Object name = freezed,
  }) {
    return _then(StreetCustomMethod(
      name == freezed ? _value.name : name as String,
    ));
  }
}

@With(Shop)
@With.fromString('AdministrativeArea<House>')
class _$StreetCustomMethod extends StreetCustomMethod {
  const _$StreetCustomMethod(this.name)
      : assert(name != null),
        super._();

  @override
  final String name;

  @override
  String toString() {
    return 'CustomMethodImplements.street(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is StreetCustomMethod &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(name);

  @override
  $StreetCustomMethodCopyWith<StreetCustomMethod> get copyWith =>
      _$StreetCustomMethodCopyWithImpl<StreetCustomMethod>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result person(String name, int age),
    @required Result street(String name),
    @required Result city(String name, int population),
    @required Result duplex(String name),
  }) {
    assert(person != null);
    assert(street != null);
    assert(city != null);
    assert(duplex != null);
    return street(name);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result person(String name, int age),
    Result street(String name),
    Result city(String name, int population),
    Result duplex(String name),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (street != null) {
      return street(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result person(PersonCustomMethod value),
    @required Result street(StreetCustomMethod value),
    @required Result city(CityCustomMethod value),
    @required Result duplex(DuplexCustomMethod value),
  }) {
    assert(person != null);
    assert(street != null);
    assert(city != null);
    assert(duplex != null);
    return street(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result person(PersonCustomMethod value),
    Result street(StreetCustomMethod value),
    Result city(CityCustomMethod value),
    Result duplex(DuplexCustomMethod value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (street != null) {
      return street(this);
    }
    return orElse();
  }
}

abstract class StreetCustomMethod extends CustomMethodImplements
    with Shop, AdministrativeArea<House> {
  const StreetCustomMethod._() : super._();
  const factory StreetCustomMethod(String name) = _$StreetCustomMethod;

  @override
  String get name;
  @override
  $StreetCustomMethodCopyWith<StreetCustomMethod> get copyWith;
}

abstract class $CityCustomMethodCopyWith<$Res>
    implements $CustomMethodImplementsCopyWith<$Res> {
  factory $CityCustomMethodCopyWith(
          CityCustomMethod value, $Res Function(CityCustomMethod) then) =
      _$CityCustomMethodCopyWithImpl<$Res>;
  @override
  $Res call({String name, int population});
}

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
    Object name = freezed,
    Object population = freezed,
  }) {
    return _then(CityCustomMethod(
      name == freezed ? _value.name : name as String,
      population == freezed ? _value.population : population as int,
    ));
  }
}

@With(House)
@Implements(GeographicArea)
class _$CityCustomMethod extends CityCustomMethod {
  const _$CityCustomMethod(this.name, this.population)
      : assert(name != null),
        assert(population != null),
        super._();

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
        (other is CityCustomMethod &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.population, population) ||
                const DeepCollectionEquality()
                    .equals(other.population, population)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(population);

  @override
  $CityCustomMethodCopyWith<CityCustomMethod> get copyWith =>
      _$CityCustomMethodCopyWithImpl<CityCustomMethod>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result person(String name, int age),
    @required Result street(String name),
    @required Result city(String name, int population),
    @required Result duplex(String name),
  }) {
    assert(person != null);
    assert(street != null);
    assert(city != null);
    assert(duplex != null);
    return city(name, population);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result person(String name, int age),
    Result street(String name),
    Result city(String name, int population),
    Result duplex(String name),
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
    @required Result person(PersonCustomMethod value),
    @required Result street(StreetCustomMethod value),
    @required Result city(CityCustomMethod value),
    @required Result duplex(DuplexCustomMethod value),
  }) {
    assert(person != null);
    assert(street != null);
    assert(city != null);
    assert(duplex != null);
    return city(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result person(PersonCustomMethod value),
    Result street(StreetCustomMethod value),
    Result city(CityCustomMethod value),
    Result duplex(DuplexCustomMethod value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (city != null) {
      return city(this);
    }
    return orElse();
  }
}

abstract class CityCustomMethod extends CustomMethodImplements
    with House
    implements GeographicArea {
  const CityCustomMethod._() : super._();
  const factory CityCustomMethod(String name, int population) =
      _$CityCustomMethod;

  @override
  String get name;
  int get population;
  @override
  $CityCustomMethodCopyWith<CityCustomMethod> get copyWith;
}

abstract class $DuplexCustomMethodCopyWith<$Res>
    implements $CustomMethodImplementsCopyWith<$Res> {
  factory $DuplexCustomMethodCopyWith(
          DuplexCustomMethod value, $Res Function(DuplexCustomMethod) then) =
      _$DuplexCustomMethodCopyWithImpl<$Res>;
  @override
  $Res call({String name});
}

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
    Object name = freezed,
  }) {
    return _then(DuplexCustomMethod(
      name == freezed ? _value.name : name as String,
    ));
  }
}

@Implements(Shop)
@Implements(GeographicArea)
class _$DuplexCustomMethod extends DuplexCustomMethod {
  const _$DuplexCustomMethod(this.name)
      : assert(name != null),
        super._();

  @override
  final String name;

  @override
  String toString() {
    return 'CustomMethodImplements.duplex(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DuplexCustomMethod &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(name);

  @override
  $DuplexCustomMethodCopyWith<DuplexCustomMethod> get copyWith =>
      _$DuplexCustomMethodCopyWithImpl<DuplexCustomMethod>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result person(String name, int age),
    @required Result street(String name),
    @required Result city(String name, int population),
    @required Result duplex(String name),
  }) {
    assert(person != null);
    assert(street != null);
    assert(city != null);
    assert(duplex != null);
    return duplex(name);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result person(String name, int age),
    Result street(String name),
    Result city(String name, int population),
    Result duplex(String name),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (duplex != null) {
      return duplex(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result person(PersonCustomMethod value),
    @required Result street(StreetCustomMethod value),
    @required Result city(CityCustomMethod value),
    @required Result duplex(DuplexCustomMethod value),
  }) {
    assert(person != null);
    assert(street != null);
    assert(city != null);
    assert(duplex != null);
    return duplex(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result person(PersonCustomMethod value),
    Result street(StreetCustomMethod value),
    Result city(CityCustomMethod value),
    Result duplex(DuplexCustomMethod value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (duplex != null) {
      return duplex(this);
    }
    return orElse();
  }
}

abstract class DuplexCustomMethod extends CustomMethodImplements
    implements Shop, GeographicArea {
  const DuplexCustomMethod._() : super._();
  const factory DuplexCustomMethod(String name) = _$DuplexCustomMethod;

  @override
  String get name;
  @override
  $DuplexCustomMethodCopyWith<DuplexCustomMethod> get copyWith;
}

class _$GenericImplementsTearOff {
  const _$GenericImplementsTearOff();

  GenericPerson<T> person<T>(String name, int age) {
    return GenericPerson<T>(
      name,
      age,
    );
  }

  GenericStreet<T> street<T>(String name, T value) {
    return GenericStreet<T>(
      name,
      value,
    );
  }

  GenericCity<T> city<T>(String name, int population) {
    return GenericCity<T>(
      name,
      population,
    );
  }
}

// ignore: unused_element
const $GenericImplements = _$GenericImplementsTearOff();

mixin _$GenericImplements<T> {
  String get name;

  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result person(String name, int age),
    @required Result street(String name, T value),
    @required Result city(String name, int population),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result person(String name, int age),
    Result street(String name, T value),
    Result city(String name, int population),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result person(GenericPerson<T> value),
    @required Result street(GenericStreet<T> value),
    @required Result city(GenericCity<T> value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result person(GenericPerson<T> value),
    Result street(GenericStreet<T> value),
    Result city(GenericCity<T> value),
    @required Result orElse(),
  });

  $GenericImplementsCopyWith<T, GenericImplements<T>> get copyWith;
}

abstract class $GenericImplementsCopyWith<T, $Res> {
  factory $GenericImplementsCopyWith(GenericImplements<T> value,
          $Res Function(GenericImplements<T>) then) =
      _$GenericImplementsCopyWithImpl<T, $Res>;
  $Res call({String name});
}

class _$GenericImplementsCopyWithImpl<T, $Res>
    implements $GenericImplementsCopyWith<T, $Res> {
  _$GenericImplementsCopyWithImpl(this._value, this._then);

  final GenericImplements<T> _value;
  // ignore: unused_field
  final $Res Function(GenericImplements<T>) _then;

  @override
  $Res call({
    Object name = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed ? _value.name : name as String,
    ));
  }
}

abstract class $GenericPersonCopyWith<T, $Res>
    implements $GenericImplementsCopyWith<T, $Res> {
  factory $GenericPersonCopyWith(
          GenericPerson<T> value, $Res Function(GenericPerson<T>) then) =
      _$GenericPersonCopyWithImpl<T, $Res>;
  @override
  $Res call({String name, int age});
}

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
    Object name = freezed,
    Object age = freezed,
  }) {
    return _then(GenericPerson<T>(
      name == freezed ? _value.name : name as String,
      age == freezed ? _value.age : age as int,
    ));
  }
}

class _$GenericPerson<T> implements GenericPerson<T> {
  const _$GenericPerson(this.name, this.age)
      : assert(name != null),
        assert(age != null);

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
        (other is GenericPerson<T> &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.age, age) ||
                const DeepCollectionEquality().equals(other.age, age)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(age);

  @override
  $GenericPersonCopyWith<T, GenericPerson<T>> get copyWith =>
      _$GenericPersonCopyWithImpl<T, GenericPerson<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result person(String name, int age),
    @required Result street(String name, T value),
    @required Result city(String name, int population),
  }) {
    assert(person != null);
    assert(street != null);
    assert(city != null);
    return person(name, age);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result person(String name, int age),
    Result street(String name, T value),
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
    @required Result person(GenericPerson<T> value),
    @required Result street(GenericStreet<T> value),
    @required Result city(GenericCity<T> value),
  }) {
    assert(person != null);
    assert(street != null);
    assert(city != null);
    return person(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result person(GenericPerson<T> value),
    Result street(GenericStreet<T> value),
    Result city(GenericCity<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
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
  $GenericPersonCopyWith<T, GenericPerson<T>> get copyWith;
}

abstract class $GenericStreetCopyWith<T, $Res>
    implements $GenericImplementsCopyWith<T, $Res> {
  factory $GenericStreetCopyWith(
          GenericStreet<T> value, $Res Function(GenericStreet<T>) then) =
      _$GenericStreetCopyWithImpl<T, $Res>;
  @override
  $Res call({String name, T value});
}

class _$GenericStreetCopyWithImpl<T, $Res>
    extends _$GenericImplementsCopyWithImpl<T, $Res>
    implements $GenericStreetCopyWith<T, $Res> {
  _$GenericStreetCopyWithImpl(
      GenericStreet<T> _value, $Res Function(GenericStreet<T>) _then)
      : super(_value, (v) => _then(v as GenericStreet<T>));

  @override
  GenericStreet<T> get _value => super._value as GenericStreet<T>;

  @override
  $Res call({
    Object name = freezed,
    Object value = freezed,
  }) {
    return _then(GenericStreet<T>(
      name == freezed ? _value.name : name as String,
      value == freezed ? _value.value : value as T,
    ));
  }
}

@With.fromString('AdministrativeArea<T>')
class _$GenericStreet<T> implements GenericStreet<T> {
  const _$GenericStreet(this.name, this.value)
      : assert(name != null),
        assert(value != null);

  @override
  final String name;
  @override
  final T value;

  @override
  String toString() {
    return 'GenericImplements<$T>.street(name: $name, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GenericStreet<T> &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(value);

  @override
  $GenericStreetCopyWith<T, GenericStreet<T>> get copyWith =>
      _$GenericStreetCopyWithImpl<T, GenericStreet<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result person(String name, int age),
    @required Result street(String name, T value),
    @required Result city(String name, int population),
  }) {
    assert(person != null);
    assert(street != null);
    assert(city != null);
    return street(name, value);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result person(String name, int age),
    Result street(String name, T value),
    Result city(String name, int population),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (street != null) {
      return street(name, value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result person(GenericPerson<T> value),
    @required Result street(GenericStreet<T> value),
    @required Result city(GenericCity<T> value),
  }) {
    assert(person != null);
    assert(street != null);
    assert(city != null);
    return street(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result person(GenericPerson<T> value),
    Result street(GenericStreet<T> value),
    Result city(GenericCity<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (street != null) {
      return street(this);
    }
    return orElse();
  }
}

abstract class GenericStreet<T>
    with AdministrativeArea<T>
    implements GenericImplements<T> {
  const factory GenericStreet(String name, T value) = _$GenericStreet<T>;

  @override
  String get name;
  T get value;
  @override
  $GenericStreetCopyWith<T, GenericStreet<T>> get copyWith;
}

abstract class $GenericCityCopyWith<T, $Res>
    implements $GenericImplementsCopyWith<T, $Res> {
  factory $GenericCityCopyWith(
          GenericCity<T> value, $Res Function(GenericCity<T>) then) =
      _$GenericCityCopyWithImpl<T, $Res>;
  @override
  $Res call({String name, int population});
}

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
    Object name = freezed,
    Object population = freezed,
  }) {
    return _then(GenericCity<T>(
      name == freezed ? _value.name : name as String,
      population == freezed ? _value.population : population as int,
    ));
  }
}

@With(House)
@Implements(GeographicArea)
class _$GenericCity<T> implements GenericCity<T> {
  const _$GenericCity(this.name, this.population)
      : assert(name != null),
        assert(population != null);

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
        (other is GenericCity<T> &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.population, population) ||
                const DeepCollectionEquality()
                    .equals(other.population, population)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(population);

  @override
  $GenericCityCopyWith<T, GenericCity<T>> get copyWith =>
      _$GenericCityCopyWithImpl<T, GenericCity<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result person(String name, int age),
    @required Result street(String name, T value),
    @required Result city(String name, int population),
  }) {
    assert(person != null);
    assert(street != null);
    assert(city != null);
    return city(name, population);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result person(String name, int age),
    Result street(String name, T value),
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
    @required Result person(GenericPerson<T> value),
    @required Result street(GenericStreet<T> value),
    @required Result city(GenericCity<T> value),
  }) {
    assert(person != null);
    assert(street != null);
    assert(city != null);
    return city(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result person(GenericPerson<T> value),
    Result street(GenericStreet<T> value),
    Result city(GenericCity<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (city != null) {
      return city(this);
    }
    return orElse();
  }
}

abstract class GenericCity<T>
    with House
    implements GenericImplements<T>, GeographicArea {
  const factory GenericCity(String name, int population) = _$GenericCity<T>;

  @override
  String get name;
  int get population;
  @override
  $GenericCityCopyWith<T, GenericCity<T>> get copyWith;
}
