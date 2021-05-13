// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'main.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MyClassTearOff {
  const _$MyClassTearOff();

  _MyClass call({String? a, int? b}) {
    return _MyClass(
      a: a,
      b: b,
    );
  }
}

/// @nodoc
const $MyClass = _$MyClassTearOff();

/// @nodoc
mixin _$MyClass {
  String? get a => throw _privateConstructorUsedError;
  int? get b => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MyClassCopyWith<MyClass> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyClassCopyWith<$Res> {
  factory $MyClassCopyWith(MyClass value, $Res Function(MyClass) then) =
      _$MyClassCopyWithImpl<$Res>;
  $Res call({String? a, int? b});
}

/// @nodoc
class _$MyClassCopyWithImpl<$Res> implements $MyClassCopyWith<$Res> {
  _$MyClassCopyWithImpl(this._value, this._then);

  final MyClass _value;
  // ignore: unused_field
  final $Res Function(MyClass) _then;

  @override
  $Res call({
    Object? a = freezed,
    Object? b = freezed,
  }) {
    return _then(_value.copyWith(
      a: a == freezed
          ? _value.a
          : a // ignore: cast_nullable_to_non_nullable
              as String?,
      b: b == freezed
          ? _value.b
          : b // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$MyClassCopyWith<$Res> implements $MyClassCopyWith<$Res> {
  factory _$MyClassCopyWith(_MyClass value, $Res Function(_MyClass) then) =
      __$MyClassCopyWithImpl<$Res>;
  @override
  $Res call({String? a, int? b});
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
    Object? a = freezed,
    Object? b = freezed,
  }) {
    return _then(_MyClass(
      a: a == freezed
          ? _value.a
          : a // ignore: cast_nullable_to_non_nullable
              as String?,
      b: b == freezed
          ? _value.b
          : b // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_MyClass with DiagnosticableTreeMixin implements _MyClass {
  _$_MyClass({this.a, this.b});

  @override
  final String? a;
  @override
  final int? b;

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

  @JsonKey(ignore: true)
  @override
  _$MyClassCopyWith<_MyClass> get copyWith =>
      __$MyClassCopyWithImpl<_MyClass>(this, _$identity);
}

abstract class _MyClass implements MyClass {
  factory _MyClass({String? a, int? b}) = _$_MyClass;

  @override
  String? get a => throw _privateConstructorUsedError;
  @override
  int? get b => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MyClassCopyWith<_MyClass> get copyWith =>
      throw _privateConstructorUsedError;
}

Union _$UnionFromJson(Map<String, dynamic> json) {
  switch (json['custom-key'] as String) {
    case 'Default':
      return Data.fromJson(json);
    case 'Loading':
      return Loading.fromJson(json);
    case 'Error':
      return ErrorDetails.fromJson(json);
    case 'Complex':
      return Complex.fromJson(json);

    default:
      throw FallThroughError();
  }
}

/// @nodoc
class _$UnionTearOff {
  const _$UnionTearOff();

  Data call(int value) {
    return Data(
      value,
    );
  }

  Loading loading() {
    return const Loading();
  }

  ErrorDetails error([String? message]) {
    return ErrorDetails(
      message,
    );
  }

  Complex complex(int a, String b) {
    return Complex(
      a,
      b,
    );
  }

  Union fromJson(Map<String, Object> json) {
    return Union.fromJson(json);
  }
}

/// @nodoc
const $Union = _$UnionTearOff();

/// @nodoc
mixin _$Union {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int value) $default, {
    required TResult Function() loading,
    required TResult Function(String? message) error,
    required TResult Function(int a, String b) complex,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int value)? $default, {
    TResult Function()? loading,
    TResult Function(String? message)? error,
    TResult Function(int a, String b)? complex,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Data value) $default, {
    required TResult Function(Loading value) loading,
    required TResult Function(ErrorDetails value) error,
    required TResult Function(Complex value) complex,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Data value)? $default, {
    TResult Function(Loading value)? loading,
    TResult Function(ErrorDetails value)? error,
    TResult Function(Complex value)? complex,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
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
    Object? value = freezed,
  }) {
    return _then(Data(
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Data with DiagnosticableTreeMixin implements Data {
  const _$Data(this.value);

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

  @JsonKey(ignore: true)
  @override
  $DataCopyWith<Data> get copyWith =>
      _$DataCopyWithImpl<Data>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int value) $default, {
    required TResult Function() loading,
    required TResult Function(String? message) error,
    required TResult Function(int a, String b) complex,
  }) {
    return $default(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int value)? $default, {
    TResult Function()? loading,
    TResult Function(String? message)? error,
    TResult Function(int a, String b)? complex,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Data value) $default, {
    required TResult Function(Loading value) loading,
    required TResult Function(ErrorDetails value) error,
    required TResult Function(Complex value) complex,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Data value)? $default, {
    TResult Function(Loading value)? loading,
    TResult Function(ErrorDetails value)? error,
    TResult Function(Complex value)? complex,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$DataToJson(this)..['custom-key'] = 'Default';
  }
}

abstract class Data implements Union {
  const factory Data(int value) = _$Data;

  factory Data.fromJson(Map<String, dynamic> json) = _$Data.fromJson;

  int get value => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataCopyWith<Data> get copyWith => throw _privateConstructorUsedError;
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

/// @nodoc
@JsonSerializable()
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
  TResult when<TResult extends Object?>(
    TResult Function(int value) $default, {
    required TResult Function() loading,
    required TResult Function(String? message) error,
    required TResult Function(int a, String b) complex,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int value)? $default, {
    TResult Function()? loading,
    TResult Function(String? message)? error,
    TResult Function(int a, String b)? complex,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Data value) $default, {
    required TResult Function(Loading value) loading,
    required TResult Function(ErrorDetails value) error,
    required TResult Function(Complex value) complex,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Data value)? $default, {
    TResult Function(Loading value)? loading,
    TResult Function(ErrorDetails value)? error,
    TResult Function(Complex value)? complex,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$LoadingToJson(this)..['custom-key'] = 'Loading';
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
  $Res call({String? message});
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
    Object? message = freezed,
  }) {
    return _then(ErrorDetails(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ErrorDetails with DiagnosticableTreeMixin implements ErrorDetails {
  const _$ErrorDetails([this.message]);

  factory _$ErrorDetails.fromJson(Map<String, dynamic> json) =>
      _$_$ErrorDetailsFromJson(json);

  @override
  final String? message;

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

  @JsonKey(ignore: true)
  @override
  $ErrorDetailsCopyWith<ErrorDetails> get copyWith =>
      _$ErrorDetailsCopyWithImpl<ErrorDetails>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int value) $default, {
    required TResult Function() loading,
    required TResult Function(String? message) error,
    required TResult Function(int a, String b) complex,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int value)? $default, {
    TResult Function()? loading,
    TResult Function(String? message)? error,
    TResult Function(int a, String b)? complex,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Data value) $default, {
    required TResult Function(Loading value) loading,
    required TResult Function(ErrorDetails value) error,
    required TResult Function(Complex value) complex,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Data value)? $default, {
    TResult Function(Loading value)? loading,
    TResult Function(ErrorDetails value)? error,
    TResult Function(Complex value)? complex,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$ErrorDetailsToJson(this)..['custom-key'] = 'Error';
  }
}

abstract class ErrorDetails implements Union {
  const factory ErrorDetails([String? message]) = _$ErrorDetails;

  factory ErrorDetails.fromJson(Map<String, dynamic> json) =
      _$ErrorDetails.fromJson;

  String? get message => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorDetailsCopyWith<ErrorDetails> get copyWith =>
      throw _privateConstructorUsedError;
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
    Object? a = freezed,
    Object? b = freezed,
  }) {
    return _then(Complex(
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
@JsonSerializable()
class _$Complex with DiagnosticableTreeMixin implements Complex {
  const _$Complex(this.a, this.b);

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

  @JsonKey(ignore: true)
  @override
  $ComplexCopyWith<Complex> get copyWith =>
      _$ComplexCopyWithImpl<Complex>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int value) $default, {
    required TResult Function() loading,
    required TResult Function(String? message) error,
    required TResult Function(int a, String b) complex,
  }) {
    return complex(a, b);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int value)? $default, {
    TResult Function()? loading,
    TResult Function(String? message)? error,
    TResult Function(int a, String b)? complex,
    required TResult orElse(),
  }) {
    if (complex != null) {
      return complex(a, b);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Data value) $default, {
    required TResult Function(Loading value) loading,
    required TResult Function(ErrorDetails value) error,
    required TResult Function(Complex value) complex,
  }) {
    return complex(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Data value)? $default, {
    TResult Function(Loading value)? loading,
    TResult Function(ErrorDetails value)? error,
    TResult Function(Complex value)? complex,
    required TResult orElse(),
  }) {
    if (complex != null) {
      return complex(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$ComplexToJson(this)..['custom-key'] = 'Complex';
  }
}

abstract class Complex implements Union {
  const factory Complex(int a, String b) = _$Complex;

  factory Complex.fromJson(Map<String, dynamic> json) = _$Complex.fromJson;

  int get a => throw _privateConstructorUsedError;
  String get b => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ComplexCopyWith<Complex> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
class _$SharedPropertyTearOff {
  const _$SharedPropertyTearOff();

  SharedProperty0 person({String? name, int? age}) {
    return SharedProperty0(
      name: name,
      age: age,
    );
  }

  SharedProperty1 city({String? name, int? population}) {
    return SharedProperty1(
      name: name,
      population: population,
    );
  }
}

/// @nodoc
const $SharedProperty = _$SharedPropertyTearOff();

/// @nodoc
mixin _$SharedProperty {
  String? get name => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? name, int? age) person,
    required TResult Function(String? name, int? population) city,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? name, int? age)? person,
    TResult Function(String? name, int? population)? city,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SharedProperty0 value) person,
    required TResult Function(SharedProperty1 value) city,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SharedProperty0 value)? person,
    TResult Function(SharedProperty1 value)? city,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SharedPropertyCopyWith<SharedProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SharedPropertyCopyWith<$Res> {
  factory $SharedPropertyCopyWith(
          SharedProperty value, $Res Function(SharedProperty) then) =
      _$SharedPropertyCopyWithImpl<$Res>;
  $Res call({String? name});
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
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
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
  $Res call({String? name, int? age});
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
    Object? name = freezed,
    Object? age = freezed,
  }) {
    return _then(SharedProperty0(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      age: age == freezed
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$SharedProperty0
    with DiagnosticableTreeMixin
    implements SharedProperty0 {
  _$SharedProperty0({this.name, this.age});

  @override
  final String? name;
  @override
  final int? age;

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

  @JsonKey(ignore: true)
  @override
  $SharedProperty0CopyWith<SharedProperty0> get copyWith =>
      _$SharedProperty0CopyWithImpl<SharedProperty0>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? name, int? age) person,
    required TResult Function(String? name, int? population) city,
  }) {
    return person(name, age);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? name, int? age)? person,
    TResult Function(String? name, int? population)? city,
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
    required TResult Function(SharedProperty0 value) person,
    required TResult Function(SharedProperty1 value) city,
  }) {
    return person(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SharedProperty0 value)? person,
    TResult Function(SharedProperty1 value)? city,
    required TResult orElse(),
  }) {
    if (person != null) {
      return person(this);
    }
    return orElse();
  }
}

abstract class SharedProperty0 implements SharedProperty {
  factory SharedProperty0({String? name, int? age}) = _$SharedProperty0;

  @override
  String? get name => throw _privateConstructorUsedError;
  int? get age => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $SharedProperty0CopyWith<SharedProperty0> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SharedProperty1CopyWith<$Res>
    implements $SharedPropertyCopyWith<$Res> {
  factory $SharedProperty1CopyWith(
          SharedProperty1 value, $Res Function(SharedProperty1) then) =
      _$SharedProperty1CopyWithImpl<$Res>;
  @override
  $Res call({String? name, int? population});
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
    Object? name = freezed,
    Object? population = freezed,
  }) {
    return _then(SharedProperty1(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      population: population == freezed
          ? _value.population
          : population // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$SharedProperty1
    with DiagnosticableTreeMixin
    implements SharedProperty1 {
  _$SharedProperty1({this.name, this.population});

  @override
  final String? name;
  @override
  final int? population;

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

  @JsonKey(ignore: true)
  @override
  $SharedProperty1CopyWith<SharedProperty1> get copyWith =>
      _$SharedProperty1CopyWithImpl<SharedProperty1>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? name, int? age) person,
    required TResult Function(String? name, int? population) city,
  }) {
    return city(name, population);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? name, int? age)? person,
    TResult Function(String? name, int? population)? city,
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
    required TResult Function(SharedProperty0 value) person,
    required TResult Function(SharedProperty1 value) city,
  }) {
    return city(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SharedProperty0 value)? person,
    TResult Function(SharedProperty1 value)? city,
    required TResult orElse(),
  }) {
    if (city != null) {
      return city(this);
    }
    return orElse();
  }
}

abstract class SharedProperty1 implements SharedProperty {
  factory SharedProperty1({String? name, int? population}) = _$SharedProperty1;

  @override
  String? get name => throw _privateConstructorUsedError;
  int? get population => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $SharedProperty1CopyWith<SharedProperty1> get copyWith =>
      throw _privateConstructorUsedError;
}
