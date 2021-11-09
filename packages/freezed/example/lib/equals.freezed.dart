// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'equals.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$EqualsTearOff {
  const _$EqualsTearOff();

  _Equals call({String? name, int? age}) {
    return _Equals(
      name: name,
      age: age,
    );
  }
}

/// @nodoc
const $Equals = _$EqualsTearOff();

/// @nodoc
mixin _$Equals {
  String? get name => throw _privateConstructorUsedError;
  int? get age => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EqualsCopyWith<Equals> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EqualsCopyWith<$Res> {
  factory $EqualsCopyWith(Equals value, $Res Function(Equals) then) =
      _$EqualsCopyWithImpl<$Res>;
  $Res call({String? name, int? age});
}

/// @nodoc
class _$EqualsCopyWithImpl<$Res> implements $EqualsCopyWith<$Res> {
  _$EqualsCopyWithImpl(this._value, this._then);

  final Equals _value;
  // ignore: unused_field
  final $Res Function(Equals) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? age = freezed,
  }) {
    return _then(_value.copyWith(
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
abstract class _$EqualsCopyWith<$Res> implements $EqualsCopyWith<$Res> {
  factory _$EqualsCopyWith(_Equals value, $Res Function(_Equals) then) =
      __$EqualsCopyWithImpl<$Res>;
  @override
  $Res call({String? name, int? age});
}

/// @nodoc
class __$EqualsCopyWithImpl<$Res> extends _$EqualsCopyWithImpl<$Res>
    implements _$EqualsCopyWith<$Res> {
  __$EqualsCopyWithImpl(_Equals _value, $Res Function(_Equals) _then)
      : super(_value, (v) => _then(v as _Equals));

  @override
  _Equals get _value => super._value as _Equals;

  @override
  $Res call({
    Object? name = freezed,
    Object? age = freezed,
  }) {
    return _then(_Equals(
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

class _$_Equals implements _Equals {
  _$_Equals({this.name, this.age});

  @override
  final String? name;
  @override
  final int? age;

  @override
  String toString() {
    return 'Equals(name: $name, age: $age)';
  }

  @JsonKey(ignore: true)
  @override
  _$EqualsCopyWith<_Equals> get copyWith =>
      __$EqualsCopyWithImpl<_Equals>(this, _$identity);
}

abstract class _Equals implements Equals {
  factory _Equals({String? name, int? age}) = _$_Equals;

  @override
  String? get name => throw _privateConstructorUsedError;
  @override
  int? get age => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$EqualsCopyWith<_Equals> get copyWith => throw _privateConstructorUsedError;
}
