// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'diagnosticable.dart';

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

class _$_Example<T> extends _Example<T> with DiagnosticableTreeMixin {
  _$_Example(this.a, this.b) : super._();

  @override
  final int a;
  @override
  final String b;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Example<$T>(a: $a, b: $b)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Example<$T>'))
      ..add(DiagnosticsProperty('a', a))
      ..add(DiagnosticsProperty('b', b));
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

abstract class _Example<T> extends Example<T> {
  factory _Example(int a, String b) = _$_Example<T>;
  _Example._() : super._();

  int get a => throw _privateConstructorUsedError;
  String get b => throw _privateConstructorUsedError;
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

class _$_Example2<T> extends _Example2<T> with DiagnosticableTreeMixin {
  _$_Example2(this.c) : super._();

  @override
  final T c;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Example<$T>.named(c: $c)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Example<$T>.named'))
      ..add(DiagnosticsProperty('c', c));
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

abstract class _Example2<T> extends Example<T> {
  factory _Example2(T c) = _$_Example2<T>;
  _Example2._() : super._();

  T get c => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$Example2CopyWith<T, _Example2<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$ConcreteExampleTearOff {
  const _$ConcreteExampleTearOff();

  _ConcreteExample<T> call<T>() {
    return _ConcreteExample<T>();
  }
}

/// @nodoc
const $ConcreteExample = _$ConcreteExampleTearOff();

/// @nodoc
mixin _$ConcreteExample<T> {}

/// @nodoc
abstract class $ConcreteExampleCopyWith<T, $Res> {
  factory $ConcreteExampleCopyWith(
          ConcreteExample<T> value, $Res Function(ConcreteExample<T>) then) =
      _$ConcreteExampleCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$ConcreteExampleCopyWithImpl<T, $Res>
    implements $ConcreteExampleCopyWith<T, $Res> {
  _$ConcreteExampleCopyWithImpl(this._value, this._then);

  final ConcreteExample<T> _value;
  // ignore: unused_field
  final $Res Function(ConcreteExample<T>) _then;
}

/// @nodoc
abstract class _$ConcreteExampleCopyWith<T, $Res> {
  factory _$ConcreteExampleCopyWith(
          _ConcreteExample<T> value, $Res Function(_ConcreteExample<T>) then) =
      __$ConcreteExampleCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$ConcreteExampleCopyWithImpl<T, $Res>
    extends _$ConcreteExampleCopyWithImpl<T, $Res>
    implements _$ConcreteExampleCopyWith<T, $Res> {
  __$ConcreteExampleCopyWithImpl(
      _ConcreteExample<T> _value, $Res Function(_ConcreteExample<T>) _then)
      : super(_value, (v) => _then(v as _ConcreteExample<T>));

  @override
  _ConcreteExample<T> get _value => super._value as _ConcreteExample<T>;
}

/// @nodoc

class _$_ConcreteExample<T> extends _ConcreteExample<T>
    with DiagnosticableTreeMixin {
  _$_ConcreteExample() : super._();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ConcreteExample<$T>()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'ConcreteExample<$T>'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _ConcreteExample<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _ConcreteExample<T> extends ConcreteExample<T> {
  factory _ConcreteExample() = _$_ConcreteExample<T>;
  _ConcreteExample._() : super._();
}
