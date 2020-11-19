// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'main.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$MyClassTearOff {
  const _$MyClassTearOff();

// ignore: unused_element
  _MyClass call({String a, int b}) {
    return _MyClass(
      a: a,
      b: b,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $MyClass = _$MyClassTearOff();

/// @nodoc
mixin _$MyClass {
  String get a;
  int get b;

  $MyClassCopyWith<MyClass> get copyWith;
}

/// @nodoc
abstract class $MyClassCopyWith<$Res> {
  factory $MyClassCopyWith(MyClass value, $Res Function(MyClass) then) =
      _$MyClassCopyWithImpl<$Res>;
  $Res call({String a, int b});
}

/// @nodoc
class _$MyClassCopyWithImpl<$Res> implements $MyClassCopyWith<$Res> {
  _$MyClassCopyWithImpl(this._value, this._then);

  final MyClass _value;
  // ignore: unused_field
  final $Res Function(MyClass) _then;

  @override
  $Res call({
    Object a = freezed,
    Object b = freezed,
  }) {
    return _then(_value.copyWith(
      a: a == freezed ? _value.a : a as String,
      b: b == freezed ? _value.b : b as int,
    ));
  }
}

/// @nodoc
abstract class _$MyClassCopyWith<$Res> implements $MyClassCopyWith<$Res> {
  factory _$MyClassCopyWith(_MyClass value, $Res Function(_MyClass) then) =
      __$MyClassCopyWithImpl<$Res>;
  @override
  $Res call({String a, int b});
}

/// @nodoc
class __$MyClassCopyWithImpl<$Res> extends _$MyClassCopyWithImpl<$Res>
    implements _$MyClassCopyWith<$Res> {
  __$MyClassCopyWithImpl(_MyClass _value, $Res Function(_MyClass) _then)
      : super(_value, (v) => _then(v as _MyClass));

  @override
  _MyClass get _value => super._value as _MyClass;

  @override
  $Res call({
    Object a = freezed,
    Object b = freezed,
  }) {
    return _then(_MyClass(
      a: a == freezed ? _value.a : a as String,
      b: b == freezed ? _value.b : b as int,
    ));
  }
}

/// @nodoc
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
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(a) ^
      const DeepCollectionEquality().hash(b);

  @override
  _$MyClassCopyWith<_MyClass> get copyWith =>
      __$MyClassCopyWithImpl<_MyClass>(this, _$identity);
}

abstract class _MyClass implements MyClass {
  factory _MyClass({String a, int b}) = _$_MyClass;

  @override
  String get a;
  @override
  int get b;
  @override
  _$MyClassCopyWith<_MyClass> get copyWith;
}

Union _$UnionFromJson(Map<String, dynamic> json) {
  switch (json['custom-key'] as String) {
    case 'default':
      return Data.fromJson(json);
    case 'loading':
      return Loading.fromJson(json);
    case 'error':
      return ErrorDetails.fromJson(json);
    case 'complex':
      return Complex.fromJson(json);

    default:
      throw FallThroughError();
  }
}

/// @nodoc
class _$UnionTearOff {
  const _$UnionTearOff();

// ignore: unused_element
  Data call(int value) {
    return Data(
      value,
    );
  }

// ignore: unused_element
  Loading loading() {
    return const Loading();
  }

// ignore: unused_element
  ErrorDetails error([String message]) {
    return ErrorDetails(
      message,
    );
  }

// ignore: unused_element
  Complex complex(int a, String b) {
    return Complex(
      a,
      b,
    );
  }

// ignore: unused_element
  Union fromJson(Map<String, Object> json) {
    return Union.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Union = _$UnionTearOff();

/// @nodoc
mixin _$Union {
  @optionalTypeArgs
  TResult when<TResult extends Object>(
    TResult $default(int value), {
    @required TResult loading(),
    @required TResult error(String message),
    @required TResult complex(int a, String b),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>(
    TResult $default(int value), {
    TResult loading(),
    TResult error(String message),
    TResult complex(int a, String b),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>(
    TResult $default(Data value), {
    @required TResult loading(Loading value),
    @required TResult error(ErrorDetails value),
    @required TResult complex(Complex value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>(
    TResult $default(Data value), {
    TResult loading(Loading value),
    TResult error(ErrorDetails value),
    TResult complex(Complex value),
    @required TResult orElse(),
  });
  Map<String, dynamic> toJson();
}

/// @nodoc
abstract class $UnionCopyWith<$Res> {
  factory $UnionCopyWith(Union value, $Res Function(Union) then) =
      _$UnionCopyWithImpl<$Res>;
}

/// @nodoc
class _$UnionCopyWithImpl<$Res> implements $UnionCopyWith<$Res> {
  _$UnionCopyWithImpl(this._value, this._then);

  final Union _value;
  // ignore: unused_field
  final $Res Function(Union) _then;
}

/// @nodoc
abstract class $DataCopyWith<$Res> {
  factory $DataCopyWith(Data value, $Res Function(Data) then) =
      _$DataCopyWithImpl<$Res>;
  $Res call({int value});
}

/// @nodoc
class _$DataCopyWithImpl<$Res> extends _$UnionCopyWithImpl<$Res>
    implements $DataCopyWith<$Res> {
  _$DataCopyWithImpl(Data _value, $Res Function(Data) _then)
      : super(_value, (v) => _then(v as Data));

  @override
  Data get _value => super._value as Data;

  @override
  $Res call({
    Object value = freezed,
  }) {
    return _then(Data(
      value == freezed ? _value.value : value as int,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$Data with DiagnosticableTreeMixin implements Data {
  const _$Data(this.value) : assert(value != null);

  factory _$Data.fromJson(Map<String, dynamic> json) => _$_$DataFromJson(json);

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
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(value);

  @override
  $DataCopyWith<Data> get copyWith =>
      _$DataCopyWithImpl<Data>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>(
    TResult $default(int value), {
    @required TResult loading(),
    @required TResult error(String message),
    @required TResult complex(int a, String b),
  }) {
    assert($default != null);
    assert(loading != null);
    assert(error != null);
    assert(complex != null);
    return $default(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>(
    TResult $default(int value), {
    TResult loading(),
    TResult error(String message),
    TResult complex(int a, String b),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if ($default != null) {
      return $default(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>(
    TResult $default(Data value), {
    @required TResult loading(Loading value),
    @required TResult error(ErrorDetails value),
    @required TResult complex(Complex value),
  }) {
    assert($default != null);
    assert(loading != null);
    assert(error != null);
    assert(complex != null);
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>(
    TResult $default(Data value), {
    TResult loading(Loading value),
    TResult error(ErrorDetails value),
    TResult complex(Complex value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$DataToJson(this)..['custom-key'] = 'default';
  }
}

abstract class Data implements Union {
  const factory Data(int value) = _$Data;

  factory Data.fromJson(Map<String, dynamic> json) = _$Data.fromJson;

  int get value;
  $DataCopyWith<Data> get copyWith;
}

/// @nodoc
abstract class $LoadingCopyWith<$Res> {
  factory $LoadingCopyWith(Loading value, $Res Function(Loading) then) =
      _$LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoadingCopyWithImpl<$Res> extends _$UnionCopyWithImpl<$Res>
    implements $LoadingCopyWith<$Res> {
  _$LoadingCopyWithImpl(Loading _value, $Res Function(Loading) _then)
      : super(_value, (v) => _then(v as Loading));

  @override
  Loading get _value => super._value as Loading;
}

@JsonSerializable()

/// @nodoc
class _$Loading with DiagnosticableTreeMixin implements Loading {
  const _$Loading();

  factory _$Loading.fromJson(Map<String, dynamic> json) =>
      _$_$LoadingFromJson(json);

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
  TResult when<TResult extends Object>(
    TResult $default(int value), {
    @required TResult loading(),
    @required TResult error(String message),
    @required TResult complex(int a, String b),
  }) {
    assert($default != null);
    assert(loading != null);
    assert(error != null);
    assert(complex != null);
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>(
    TResult $default(int value), {
    TResult loading(),
    TResult error(String message),
    TResult complex(int a, String b),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>(
    TResult $default(Data value), {
    @required TResult loading(Loading value),
    @required TResult error(ErrorDetails value),
    @required TResult complex(Complex value),
  }) {
    assert($default != null);
    assert(loading != null);
    assert(error != null);
    assert(complex != null);
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>(
    TResult $default(Data value), {
    TResult loading(Loading value),
    TResult error(ErrorDetails value),
    TResult complex(Complex value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$LoadingToJson(this)..['custom-key'] = 'loading';
  }
}

abstract class Loading implements Union {
  const factory Loading() = _$Loading;

  factory Loading.fromJson(Map<String, dynamic> json) = _$Loading.fromJson;
}

/// @nodoc
abstract class $ErrorDetailsCopyWith<$Res> {
  factory $ErrorDetailsCopyWith(
          ErrorDetails value, $Res Function(ErrorDetails) then) =
      _$ErrorDetailsCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class _$ErrorDetailsCopyWithImpl<$Res> extends _$UnionCopyWithImpl<$Res>
    implements $ErrorDetailsCopyWith<$Res> {
  _$ErrorDetailsCopyWithImpl(
      ErrorDetails _value, $Res Function(ErrorDetails) _then)
      : super(_value, (v) => _then(v as ErrorDetails));

  @override
  ErrorDetails get _value => super._value as ErrorDetails;

  @override
  $Res call({
    Object message = freezed,
  }) {
    return _then(ErrorDetails(
      message == freezed ? _value.message : message as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$ErrorDetails with DiagnosticableTreeMixin implements ErrorDetails {
  const _$ErrorDetails([this.message]);

  factory _$ErrorDetails.fromJson(Map<String, dynamic> json) =>
      _$_$ErrorDetailsFromJson(json);

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
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @override
  $ErrorDetailsCopyWith<ErrorDetails> get copyWith =>
      _$ErrorDetailsCopyWithImpl<ErrorDetails>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>(
    TResult $default(int value), {
    @required TResult loading(),
    @required TResult error(String message),
    @required TResult complex(int a, String b),
  }) {
    assert($default != null);
    assert(loading != null);
    assert(error != null);
    assert(complex != null);
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>(
    TResult $default(int value), {
    TResult loading(),
    TResult error(String message),
    TResult complex(int a, String b),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>(
    TResult $default(Data value), {
    @required TResult loading(Loading value),
    @required TResult error(ErrorDetails value),
    @required TResult complex(Complex value),
  }) {
    assert($default != null);
    assert(loading != null);
    assert(error != null);
    assert(complex != null);
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>(
    TResult $default(Data value), {
    TResult loading(Loading value),
    TResult error(ErrorDetails value),
    TResult complex(Complex value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$ErrorDetailsToJson(this)..['custom-key'] = 'error';
  }
}

abstract class ErrorDetails implements Union {
  const factory ErrorDetails([String message]) = _$ErrorDetails;

  factory ErrorDetails.fromJson(Map<String, dynamic> json) =
      _$ErrorDetails.fromJson;

  String get message;
  $ErrorDetailsCopyWith<ErrorDetails> get copyWith;
}

/// @nodoc
abstract class $ComplexCopyWith<$Res> {
  factory $ComplexCopyWith(Complex value, $Res Function(Complex) then) =
      _$ComplexCopyWithImpl<$Res>;
  $Res call({int a, String b});
}

/// @nodoc
class _$ComplexCopyWithImpl<$Res> extends _$UnionCopyWithImpl<$Res>
    implements $ComplexCopyWith<$Res> {
  _$ComplexCopyWithImpl(Complex _value, $Res Function(Complex) _then)
      : super(_value, (v) => _then(v as Complex));

  @override
  Complex get _value => super._value as Complex;

  @override
  $Res call({
    Object a = freezed,
    Object b = freezed,
  }) {
    return _then(Complex(
      a == freezed ? _value.a : a as int,
      b == freezed ? _value.b : b as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$Complex with DiagnosticableTreeMixin implements Complex {
  const _$Complex(this.a, this.b)
      : assert(a != null),
        assert(b != null);

  factory _$Complex.fromJson(Map<String, dynamic> json) =>
      _$_$ComplexFromJson(json);

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
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(a) ^
      const DeepCollectionEquality().hash(b);

  @override
  $ComplexCopyWith<Complex> get copyWith =>
      _$ComplexCopyWithImpl<Complex>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>(
    TResult $default(int value), {
    @required TResult loading(),
    @required TResult error(String message),
    @required TResult complex(int a, String b),
  }) {
    assert($default != null);
    assert(loading != null);
    assert(error != null);
    assert(complex != null);
    return complex(a, b);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>(
    TResult $default(int value), {
    TResult loading(),
    TResult error(String message),
    TResult complex(int a, String b),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (complex != null) {
      return complex(a, b);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>(
    TResult $default(Data value), {
    @required TResult loading(Loading value),
    @required TResult error(ErrorDetails value),
    @required TResult complex(Complex value),
  }) {
    assert($default != null);
    assert(loading != null);
    assert(error != null);
    assert(complex != null);
    return complex(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>(
    TResult $default(Data value), {
    TResult loading(Loading value),
    TResult error(ErrorDetails value),
    TResult complex(Complex value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (complex != null) {
      return complex(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$ComplexToJson(this)..['custom-key'] = 'complex';
  }
}

abstract class Complex implements Union {
  const factory Complex(int a, String b) = _$Complex;

  factory Complex.fromJson(Map<String, dynamic> json) = _$Complex.fromJson;

  int get a;
  String get b;
  $ComplexCopyWith<Complex> get copyWith;
}

/// @nodoc
class _$SharedPropertyTearOff {
  const _$SharedPropertyTearOff();

// ignore: unused_element
  SharedProperty0 person({String name, int age}) {
    return SharedProperty0(
      name: name,
      age: age,
    );
  }

// ignore: unused_element
  SharedProperty1 city({String name, int population}) {
    return SharedProperty1(
      name: name,
      population: population,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $SharedProperty = _$SharedPropertyTearOff();

/// @nodoc
mixin _$SharedProperty {
  String get name;

  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult person(String name, int age),
    @required TResult city(String name, int population),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult person(String name, int age),
    TResult city(String name, int population),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult person(SharedProperty0 value),
    @required TResult city(SharedProperty1 value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult person(SharedProperty0 value),
    TResult city(SharedProperty1 value),
    @required TResult orElse(),
  });

  $SharedPropertyCopyWith<SharedProperty> get copyWith;
}

/// @nodoc
abstract class $SharedPropertyCopyWith<$Res> {
  factory $SharedPropertyCopyWith(
          SharedProperty value, $Res Function(SharedProperty) then) =
      _$SharedPropertyCopyWithImpl<$Res>;
  $Res call({String name});
}

/// @nodoc
class _$SharedPropertyCopyWithImpl<$Res>
    implements $SharedPropertyCopyWith<$Res> {
  _$SharedPropertyCopyWithImpl(this._value, this._then);

  final SharedProperty _value;
  // ignore: unused_field
  final $Res Function(SharedProperty) _then;

  @override
  $Res call({
    Object name = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed ? _value.name : name as String,
    ));
  }
}

/// @nodoc
abstract class $SharedProperty0CopyWith<$Res>
    implements $SharedPropertyCopyWith<$Res> {
  factory $SharedProperty0CopyWith(
          SharedProperty0 value, $Res Function(SharedProperty0) then) =
      _$SharedProperty0CopyWithImpl<$Res>;
  @override
  $Res call({String name, int age});
}

/// @nodoc
class _$SharedProperty0CopyWithImpl<$Res>
    extends _$SharedPropertyCopyWithImpl<$Res>
    implements $SharedProperty0CopyWith<$Res> {
  _$SharedProperty0CopyWithImpl(
      SharedProperty0 _value, $Res Function(SharedProperty0) _then)
      : super(_value, (v) => _then(v as SharedProperty0));

  @override
  SharedProperty0 get _value => super._value as SharedProperty0;

  @override
  $Res call({
    Object name = freezed,
    Object age = freezed,
  }) {
    return _then(SharedProperty0(
      name: name == freezed ? _value.name : name as String,
      age: age == freezed ? _value.age : age as int,
    ));
  }
}

/// @nodoc
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
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(age);

  @override
  $SharedProperty0CopyWith<SharedProperty0> get copyWith =>
      _$SharedProperty0CopyWithImpl<SharedProperty0>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult person(String name, int age),
    @required TResult city(String name, int population),
  }) {
    assert(person != null);
    assert(city != null);
    return person(name, age);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult person(String name, int age),
    TResult city(String name, int population),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (person != null) {
      return person(name, age);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult person(SharedProperty0 value),
    @required TResult city(SharedProperty1 value),
  }) {
    assert(person != null);
    assert(city != null);
    return person(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult person(SharedProperty0 value),
    TResult city(SharedProperty1 value),
    @required TResult orElse(),
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
  $SharedProperty0CopyWith<SharedProperty0> get copyWith;
}

/// @nodoc
abstract class $SharedProperty1CopyWith<$Res>
    implements $SharedPropertyCopyWith<$Res> {
  factory $SharedProperty1CopyWith(
          SharedProperty1 value, $Res Function(SharedProperty1) then) =
      _$SharedProperty1CopyWithImpl<$Res>;
  @override
  $Res call({String name, int population});
}

/// @nodoc
class _$SharedProperty1CopyWithImpl<$Res>
    extends _$SharedPropertyCopyWithImpl<$Res>
    implements $SharedProperty1CopyWith<$Res> {
  _$SharedProperty1CopyWithImpl(
      SharedProperty1 _value, $Res Function(SharedProperty1) _then)
      : super(_value, (v) => _then(v as SharedProperty1));

  @override
  SharedProperty1 get _value => super._value as SharedProperty1;

  @override
  $Res call({
    Object name = freezed,
    Object population = freezed,
  }) {
    return _then(SharedProperty1(
      name: name == freezed ? _value.name : name as String,
      population: population == freezed ? _value.population : population as int,
    ));
  }
}

/// @nodoc
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
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(population);

  @override
  $SharedProperty1CopyWith<SharedProperty1> get copyWith =>
      _$SharedProperty1CopyWithImpl<SharedProperty1>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult person(String name, int age),
    @required TResult city(String name, int population),
  }) {
    assert(person != null);
    assert(city != null);
    return city(name, population);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult person(String name, int age),
    TResult city(String name, int population),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (city != null) {
      return city(name, population);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult person(SharedProperty0 value),
    @required TResult city(SharedProperty1 value),
  }) {
    assert(person != null);
    assert(city != null);
    return city(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult person(SharedProperty0 value),
    TResult city(SharedProperty1 value),
    @required TResult orElse(),
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
  $SharedProperty1CopyWith<SharedProperty1> get copyWith;
}
