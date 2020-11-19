// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'diagnosticable.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$ExampleTearOff {
  const _$ExampleTearOff();

// ignore: unused_element
  _Example<T> call<T>(int a, String b) {
    return _Example<T>(
      a,
      b,
    );
  }

// ignore: unused_element
  _Example2<T> named<T>(T c) {
    return _Example2<T>(
      c,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $Example = _$ExampleTearOff();

/// @nodoc
mixin _$Example<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object>(
    TResult $default(int a, String b), {
    @required TResult named(T c),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>(
    TResult $default(int a, String b), {
    TResult named(T c),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>(
    TResult $default(_Example<T> value), {
    @required TResult named(_Example2<T> value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>(
    TResult $default(_Example<T> value), {
    TResult named(_Example2<T> value),
    @required TResult orElse(),
  });
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
    Object a = freezed,
    Object b = freezed,
  }) {
    return _then(_Example<T>(
      a == freezed ? _value.a : a as int,
      b == freezed ? _value.b : b as String,
    ));
  }
}

/// @nodoc
class _$_Example<T> with DiagnosticableTreeMixin implements _Example<T> {
  _$_Example(this.a, this.b)
      : assert(a != null),
        assert(b != null);

  @override
  final int a;
  @override
  final String b;

  bool _didtheAnswer = false;
  int _theAnswer;

  @override
  int get theAnswer {
    if (_didtheAnswer == false) {
      _didtheAnswer = true;
      _theAnswer = 42;
    }
    return _theAnswer;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Example<$T>(a: $a, b: $b, theAnswer: $theAnswer)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Example<$T>'))
      ..add(DiagnosticsProperty('a', a))
      ..add(DiagnosticsProperty('b', b))
      ..add(DiagnosticsProperty('theAnswer', theAnswer));
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
  TResult when<TResult extends Object>(
    TResult $default(int a, String b), {
    @required TResult named(T c),
  }) {
    assert($default != null);
    assert(named != null);
    return $default(a, b);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>(
    TResult $default(int a, String b), {
    TResult named(T c),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if ($default != null) {
      return $default(a, b);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>(
    TResult $default(_Example<T> value), {
    @required TResult named(_Example2<T> value),
  }) {
    assert($default != null);
    assert(named != null);
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>(
    TResult $default(_Example<T> value), {
    TResult named(_Example2<T> value),
    @required TResult orElse(),
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
    Object c = freezed,
  }) {
    return _then(_Example2<T>(
      c == freezed ? _value.c : c as T,
    ));
  }
}

/// @nodoc
class _$_Example2<T> with DiagnosticableTreeMixin implements _Example2<T> {
  _$_Example2(this.c) : assert(c != null);

  @override
  final T c;

  bool _didtheAnswer = false;
  int _theAnswer;

  @override
  int get theAnswer {
    if (_didtheAnswer == false) {
      _didtheAnswer = true;
      _theAnswer = 42;
    }
    return _theAnswer;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Example<$T>.named(c: $c, theAnswer: $theAnswer)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Example<$T>.named'))
      ..add(DiagnosticsProperty('c', c))
      ..add(DiagnosticsProperty('theAnswer', theAnswer));
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
  TResult when<TResult extends Object>(
    TResult $default(int a, String b), {
    @required TResult named(T c),
  }) {
    assert($default != null);
    assert(named != null);
    return named(c);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>(
    TResult $default(int a, String b), {
    TResult named(T c),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (named != null) {
      return named(c);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>(
    TResult $default(_Example<T> value), {
    @required TResult named(_Example2<T> value),
  }) {
    assert($default != null);
    assert(named != null);
    return named(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>(
    TResult $default(_Example<T> value), {
    TResult named(_Example2<T> value),
    @required TResult orElse(),
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

/// @nodoc
class _$ConcreteExampleTearOff {
  const _$ConcreteExampleTearOff();

// ignore: unused_element
  _ConcreteExample<T> call<T>() {
    return _ConcreteExample<T>();
  }
}

/// @nodoc
// ignore: unused_element
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
  _ConcreteExample._() : super._();
  factory _ConcreteExample() = _$_ConcreteExample<T>;
}
