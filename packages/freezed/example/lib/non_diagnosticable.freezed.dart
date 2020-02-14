// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_cast, prefer_const_constructors

part of 'non_diagnosticable.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

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

  _Example<T> copyAsDefault({@required int a, @required String b});
  _Example2<T> copyAsNamed({@required T c});
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
  int get hashCode => runtimeType.hashCode ^ a.hashCode ^ b.hashCode;

  @override
  _$_Example<T> copyWith({
    Object a = freezed,
    Object b = freezed,
  }) {
    assert(a != null);
    assert(b != null);
    return _$_Example<T>(
      a == freezed ? this.a : a as int,
      b == freezed ? this.b : b as String,
    );
  }

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

  @override
  _Example<T> copyAsDefault({Object a = freezed, Object b = freezed}) {
    return _Example<T>(
      a == freezed ? this.a : a as int,
      b == freezed ? this.b : b as String,
    );
  }

  @override
  _Example2<T> copyAsNamed({@required T c}) {
    return _Example2<T>(
      c as T,
    );
  }
}

abstract class _Example<T> implements Example<T> {
  factory _Example(int a, String b) = _$_Example<T>;

  int get a;
  String get b;
  _Example<T> copyWith({int a, String b});

  @override
  _Example<T> copyAsDefault({int a, String b});
  @override
  _Example2<T> copyAsNamed({@required T c});
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
  int get hashCode => runtimeType.hashCode ^ c.hashCode;

  @override
  _$_Example2<T> copyWith({
    Object c = freezed,
  }) {
    assert(c != null);
    return _$_Example2<T>(
      c == freezed ? this.c : c as T,
    );
  }

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

  @override
  _Example<T> copyAsDefault({@required int a, @required String b}) {
    return _Example<T>(
      a as int,
      b as String,
    );
  }

  @override
  _Example2<T> copyAsNamed({Object c = freezed}) {
    return _Example2<T>(
      c == freezed ? this.c : c as T,
    );
  }
}

abstract class _Example2<T> implements Example<T> {
  factory _Example2(T c) = _$_Example2<T>;

  T get c;
  _Example2<T> copyWith({T c});

  @override
  _Example<T> copyAsDefault({@required int a, @required String b});
  @override
  _Example2<T> copyAsNamed({T c});
}
