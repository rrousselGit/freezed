// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Either<First, Second> _$EitherFromJson<First, Second>(
    Map<String, dynamic> json,
    First Function(Object? json) fromJsonFirst,
    Second Function(Object? json) fromJsonSecond) {
  switch (json['type'] as String) {
    case 'First':
      return _EitherFirst<First, Second>.fromJson(
          json, fromJsonFirst, fromJsonSecond);
    case 'Second':
      return _EitherSecond<First, Second>.fromJson(
          json, fromJsonFirst, fromJsonSecond);

    default:
      throw FallThroughError();
  }
}

/// @nodoc
class _$EitherTearOff {
  const _$EitherTearOff();

  _EitherFirst<First, Second> first<First, Second>(First value) {
    return _EitherFirst<First, Second>(
      value,
    );
  }

  _EitherSecond<First, Second> second<First, Second>(Second value) {
    return _EitherSecond<First, Second>(
      value,
    );
  }

  Either<First, Second> fromJson<First, Second>(
      Map<String, Object> json,
      First Function(Object? json) fromJsonFirst,
      Second Function(Object? json) fromJsonSecond) {
    return Either<First, Second>.fromJson(json, fromJsonFirst, fromJsonSecond);
  }
}

/// @nodoc
const $Either = _$EitherTearOff();

/// @nodoc
mixin _$Either<First, Second> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(First value) first,
    required TResult Function(Second value) second,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(First value)? first,
    TResult Function(Second value)? second,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EitherFirst<First, Second> value) first,
    required TResult Function(_EitherSecond<First, Second> value) second,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EitherFirst<First, Second> value)? first,
    TResult Function(_EitherSecond<First, Second> value)? second,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson(Object Function(First value) toJsonFirst,
          Object Function(Second value) toJsonSecond) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EitherCopyWith<First, Second, $Res> {
  factory $EitherCopyWith(Either<First, Second> value,
          $Res Function(Either<First, Second>) then) =
      _$EitherCopyWithImpl<First, Second, $Res>;
}

/// @nodoc
class _$EitherCopyWithImpl<First, Second, $Res>
    implements $EitherCopyWith<First, Second, $Res> {
  _$EitherCopyWithImpl(this._value, this._then);

  final Either<First, Second> _value;
  // ignore: unused_field
  final $Res Function(Either<First, Second>) _then;
}

/// @nodoc
abstract class _$EitherFirstCopyWith<First, Second, $Res> {
  factory _$EitherFirstCopyWith(_EitherFirst<First, Second> value,
          $Res Function(_EitherFirst<First, Second>) then) =
      __$EitherFirstCopyWithImpl<First, Second, $Res>;
  $Res call({First value});
}

/// @nodoc
class __$EitherFirstCopyWithImpl<First, Second, $Res>
    extends _$EitherCopyWithImpl<First, Second, $Res>
    implements _$EitherFirstCopyWith<First, Second, $Res> {
  __$EitherFirstCopyWithImpl(_EitherFirst<First, Second> _value,
      $Res Function(_EitherFirst<First, Second>) _then)
      : super(_value, (v) => _then(v as _EitherFirst<First, Second>));

  @override
  _EitherFirst<First, Second> get _value =>
      super._value as _EitherFirst<First, Second>;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_EitherFirst<First, Second>(
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as First,
    ));
  }
}

@JsonSerializable(genericArgumentFactories: true)

/// @nodoc
class _$_EitherFirst<First, Second> implements _EitherFirst<First, Second> {
  _$_EitherFirst(this.value);

  factory _$_EitherFirst.fromJson(
          Map<String, dynamic> json,
          First Function(Object? json) fromJsonFirst,
          Second Function(Object? json) fromJsonSecond) =>
      _$_$_EitherFirstFromJson(json, fromJsonFirst, fromJsonSecond);

  @override
  final First value;

  @override
  String toString() {
    return 'Either<$First, $Second>.first(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _EitherFirst<First, Second> &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(value);

  @JsonKey(ignore: true)
  @override
  _$EitherFirstCopyWith<First, Second, _EitherFirst<First, Second>>
      get copyWith => __$EitherFirstCopyWithImpl<First, Second,
          _EitherFirst<First, Second>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(First value) first,
    required TResult Function(Second value) second,
  }) {
    return first(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(First value)? first,
    TResult Function(Second value)? second,
    required TResult orElse(),
  }) {
    if (first != null) {
      return first(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EitherFirst<First, Second> value) first,
    required TResult Function(_EitherSecond<First, Second> value) second,
  }) {
    return first(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EitherFirst<First, Second> value)? first,
    TResult Function(_EitherSecond<First, Second> value)? second,
    required TResult orElse(),
  }) {
    if (first != null) {
      return first(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson(Object Function(First value) toJsonFirst,
      Object Function(Second value) toJsonSecond) {
    return _$_$_EitherFirstToJson(this, toJsonFirst, toJsonSecond)
      ..['type'] = 'First';
  }
}

abstract class _EitherFirst<First, Second> implements Either<First, Second> {
  factory _EitherFirst(First value) = _$_EitherFirst<First, Second>;

  factory _EitherFirst.fromJson(
          Map<String, dynamic> json,
          First Function(Object? json) fromJsonFirst,
          Second Function(Object? json) fromJsonSecond) =
      _$_EitherFirst<First, Second>.fromJson;

  First get value => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$EitherFirstCopyWith<First, Second, _EitherFirst<First, Second>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$EitherSecondCopyWith<First, Second, $Res> {
  factory _$EitherSecondCopyWith(_EitherSecond<First, Second> value,
          $Res Function(_EitherSecond<First, Second>) then) =
      __$EitherSecondCopyWithImpl<First, Second, $Res>;
  $Res call({Second value});
}

/// @nodoc
class __$EitherSecondCopyWithImpl<First, Second, $Res>
    extends _$EitherCopyWithImpl<First, Second, $Res>
    implements _$EitherSecondCopyWith<First, Second, $Res> {
  __$EitherSecondCopyWithImpl(_EitherSecond<First, Second> _value,
      $Res Function(_EitherSecond<First, Second>) _then)
      : super(_value, (v) => _then(v as _EitherSecond<First, Second>));

  @override
  _EitherSecond<First, Second> get _value =>
      super._value as _EitherSecond<First, Second>;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_EitherSecond<First, Second>(
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as Second,
    ));
  }
}

@JsonSerializable(genericArgumentFactories: true)

/// @nodoc
class _$_EitherSecond<First, Second> implements _EitherSecond<First, Second> {
  _$_EitherSecond(this.value);

  factory _$_EitherSecond.fromJson(
          Map<String, dynamic> json,
          First Function(Object? json) fromJsonFirst,
          Second Function(Object? json) fromJsonSecond) =>
      _$_$_EitherSecondFromJson(json, fromJsonFirst, fromJsonSecond);

  @override
  final Second value;

  @override
  String toString() {
    return 'Either<$First, $Second>.second(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _EitherSecond<First, Second> &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(value);

  @JsonKey(ignore: true)
  @override
  _$EitherSecondCopyWith<First, Second, _EitherSecond<First, Second>>
      get copyWith => __$EitherSecondCopyWithImpl<First, Second,
          _EitherSecond<First, Second>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(First value) first,
    required TResult Function(Second value) second,
  }) {
    return second(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(First value)? first,
    TResult Function(Second value)? second,
    required TResult orElse(),
  }) {
    if (second != null) {
      return second(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EitherFirst<First, Second> value) first,
    required TResult Function(_EitherSecond<First, Second> value) second,
  }) {
    return second(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EitherFirst<First, Second> value)? first,
    TResult Function(_EitherSecond<First, Second> value)? second,
    required TResult orElse(),
  }) {
    if (second != null) {
      return second(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson(Object Function(First value) toJsonFirst,
      Object Function(Second value) toJsonSecond) {
    return _$_$_EitherSecondToJson(this, toJsonFirst, toJsonSecond)
      ..['type'] = 'Second';
  }
}

abstract class _EitherSecond<First, Second> implements Either<First, Second> {
  factory _EitherSecond(Second value) = _$_EitherSecond<First, Second>;

  factory _EitherSecond.fromJson(
          Map<String, dynamic> json,
          First Function(Object? json) fromJsonFirst,
          Second Function(Object? json) fromJsonSecond) =
      _$_EitherSecond<First, Second>.fromJson;

  Second get value => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$EitherSecondCopyWith<First, Second, _EitherSecond<First, Second>>
      get copyWith => throw _privateConstructorUsedError;
}

Another _$AnotherFromJson(Map<String, dynamic> json) {
  return _Another.fromJson(json);
}

/// @nodoc
class _$AnotherTearOff {
  const _$AnotherTearOff();

  _Another call(Either<int, String> value) {
    return _Another(
      value,
    );
  }

  Another fromJson(Map<String, Object> json) {
    return Another.fromJson(json);
  }
}

/// @nodoc
const $Another = _$AnotherTearOff();

/// @nodoc
mixin _$Another {
  Either<int, String> get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AnotherCopyWith<Another> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnotherCopyWith<$Res> {
  factory $AnotherCopyWith(Another value, $Res Function(Another) then) =
      _$AnotherCopyWithImpl<$Res>;
  $Res call({Either<int, String> value});

  $EitherCopyWith<int, String, $Res> get value;
}

/// @nodoc
class _$AnotherCopyWithImpl<$Res> implements $AnotherCopyWith<$Res> {
  _$AnotherCopyWithImpl(this._value, this._then);

  final Another _value;
  // ignore: unused_field
  final $Res Function(Another) _then;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as Either<int, String>,
    ));
  }

  @override
  $EitherCopyWith<int, String, $Res> get value {
    return $EitherCopyWith<int, String, $Res>(_value.value, (value) {
      return _then(_value.copyWith(value: value));
    });
  }
}

/// @nodoc
abstract class _$AnotherCopyWith<$Res> implements $AnotherCopyWith<$Res> {
  factory _$AnotherCopyWith(_Another value, $Res Function(_Another) then) =
      __$AnotherCopyWithImpl<$Res>;
  @override
  $Res call({Either<int, String> value});

  @override
  $EitherCopyWith<int, String, $Res> get value;
}

/// @nodoc
class __$AnotherCopyWithImpl<$Res> extends _$AnotherCopyWithImpl<$Res>
    implements _$AnotherCopyWith<$Res> {
  __$AnotherCopyWithImpl(_Another _value, $Res Function(_Another) _then)
      : super(_value, (v) => _then(v as _Another));

  @override
  _Another get _value => super._value as _Another;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_Another(
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as Either<int, String>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Another implements _Another {
  _$_Another(this.value);

  factory _$_Another.fromJson(Map<String, dynamic> json) =>
      _$_$_AnotherFromJson(json);

  @override
  final Either<int, String> value;

  @override
  String toString() {
    return 'Another(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Another &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(value);

  @JsonKey(ignore: true)
  @override
  _$AnotherCopyWith<_Another> get copyWith =>
      __$AnotherCopyWithImpl<_Another>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_AnotherToJson(this);
  }
}

abstract class _Another implements Another {
  factory _Another(Either<int, String> value) = _$_Another;

  factory _Another.fromJson(Map<String, dynamic> json) = _$_Another.fromJson;

  @override
  Either<int, String> get value => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AnotherCopyWith<_Another> get copyWith =>
      throw _privateConstructorUsedError;
}
