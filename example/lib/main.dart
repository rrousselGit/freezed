// /// Creating a library is required for part generation to work
// library example.main;

// import 'dart:async';

// import 'package:flutter/foundation.dart';
// import 'package:immutable/immutable.dart' show Immutable;

// part 'main.g.dart';
// part 'main.immutable.dart';

// @immutable
// class Example = _$Example with _Example;

// abstract class _Example {
//   String get a;
//   String get b;
// }

// @immutable
// abstract class MyClass with _MyClassBase {
//   const factory MyClass({
//     String a,
//     int b,
//   }) = _MyClass;
// }

// void main() {
//   final example = MyClass(a: '42', b: 42);

//   example.copyWith(
//     a: null,
//   );

//   example.copyWith();

//   Union a = const Union(42);

//   final str = a.when(
//     (value) => '$value',
//     loading: () => 'loading',
//     error: (message) => 'Error: $message',
//     named: (foo) => 'foo $foo',
//   );
// }

// @immutable
// abstract class Union with _$Union {
//   const factory Union(int value) = Union0;
//   const factory Union.loading() = Union1;
//   const factory Union.error([String message]) = Union2;
//   const factory Union.named({String foo}) = Union3;
// }

// mixin _$Union {
//   R when<R>(
//     R $default(int value), {
//     @required R loading(),
//     @required R error(String message),
//     @required R named(String foo),
//   });

//   R maybeWhen<R>(
//     R $default(int value), {
//     R loading(),
//     R error(String message),
//     R named(String foo),
//   });

//   R map<R>(
//     R $default(Union0 value), {
//     @required R loading(Union1 value),
//     @required R error(Union2 value),
//     @required R named(Union3 value),
//   });

//   R maybeMap<R>(
//     R $default(Union0 value), {
//     R loading(Union1 value),
//     R error(Union2 value),
//     R named(Union3 value),
//   });
// }

// class _ConstFuture<T> implements Future<T> {
//   const _ConstFuture();

//   @override
//   dynamic noSuchMethod(Invocation i) {
//     super.noSuchMethod(i);
//   }
// }

// class Union0 implements Union {
//   const Union0._(int value) : _value = value;
//   const factory Union0(int value) = Union0._;

//   final int _value;

//   @override
//   R when<R>(
//     R Function(int value) $default, {
//     R Function() loading,
//     R Function(String message) error,
//     R Function(String foo) named,
//   }) {
//     assert(loading != null);
//     assert(error != null);
//     assert(named != null);
//     assert($default != null);
//     return $default(_value);
//   }

//   @override
//   R maybeWhen<R>(
//     R Function(int value) $default, {
//     R Function() loading,
//     R Function(String message) error,
//     R Function(String foo) named,
//     @required R Function() orElse,
//   }) {
//     assert(orElse != null);
//     if ($default != null) return $default(_value);
//     return orElse();
//   }

//   @override
//   R map<R>(
//     R Function(Union0 value) $default, {
//     R Function(Union1 value) loading,
//     R Function(Union2 value) error,
//     R Function(Union3 value) named,
//   }) {
//     assert(loading != null);
//     assert(error != null);
//     assert(named != null);
//     assert($default != null);
//     return $default(this);
//   }

//   @override
//   R maybeMap<R>(
//     R Function(Union0 value) $default, {
//     R Function(Union1 value) loading,
//     R Function(Union2 value) error,
//     R Function(Union3 value) named,
//     @required R Function() orElse,
//   }) {
//     assert(orElse != null);
//     if ($default != null) return $default(this);
//     return orElse();
//   }

//   Union0 copyWith({
//     FutureOr<int> value = const _ConstFuture(),
//   }) {
//     return Union0(
//       value is _ConstFuture ? _value : value as int,
//     );
//   }
// }

// class Union1 implements Union {
//   const Union1._();
//   const factory Union1() = Union1._;

//   @override
//   R when<R>(
//     R Function(int value) $default, {
//     R Function() loading,
//     R Function(String message) error,
//     R Function(String foo) named,
//   }) {
//     assert(loading != null);
//     assert(error != null);
//     assert(named != null);
//     assert($default != null);
//     return loading();
//   }

//   @override
//   R maybeWhen<R>(
//     R Function(int value) $default, {
//     R Function() loading,
//     R Function(String message) error,
//     R Function(String foo) named,
//     @required R Function() orElse,
//   }) {
//     assert(orElse != null);
//     if (loading != null) return loading();
//     return orElse();
//   }

//   @override
//   R map<R>(
//     R Function(Union0 value) $default, {
//     R Function(Union1 value) loading,
//     R Function(Union2 value) error,
//     R Function(Union3 value) named,
//   }) {
//     assert(loading != null);
//     assert(error != null);
//     assert(named != null);
//     assert($default != null);
//     return loading(this);
//   }

//   @override
//   R maybeMap<R>(
//     R Function(Union0 value) $default, {
//     R Function(Union1 value) loading,
//     R Function(Union2 value) error,
//     R Function(Union3 value) named,
//     @required R Function() orElse,
//   }) {
//     assert(orElse != null);
//     if (loading != null) return loading(this);
//     return orElse();
//   }
// }

// class Union2 implements Union {
//   const Union2._([String message]) : _message = message;
//   const factory Union2([String message]) = Union2._;

//   final String _message;

//   @override
//   R when<R>(
//     R Function(int value) $default, {
//     R Function() loading,
//     R Function(String message) error,
//     R Function(String foo) named,
//   }) {
//     assert(loading != null);
//     assert(error != null);
//     assert(named != null);
//     assert($default != null);
//     return error(_message);
//   }

//   @override
//   R maybeWhen<R>(
//     R Function(int value) $default, {
//     R Function() loading,
//     R Function(String message) error,
//     R Function(String foo) named,
//     @required R Function() orElse,
//   }) {
//     assert(orElse != null);
//     if (error != null) return error(_message);
//     return orElse();
//   }

//   @override
//   R map<R>(
//     R Function(Union0 value) $default, {
//     R Function(Union1 value) loading,
//     R Function(Union2 value) error,
//     R Function(Union3 value) named,
//   }) {
//     assert(loading != null);
//     assert(error != null);
//     assert(named != null);
//     assert($default != null);
//     return error(this);
//   }

//   @override
//   R maybeMap<R>(
//     R Function(Union0 value) $default, {
//     R Function(Union1 value) loading,
//     R Function(Union2 value) error,
//     R Function(Union3 value) named,
//     @required R Function() orElse,
//   }) {
//     assert(orElse != null);
//     if (error != null) return error(this);
//     return orElse();
//   }

//   Union2 copyWith({
//     FutureOr<String> message = const _ConstFuture(),
//   }) {
//     return Union2(
//       message is _ConstFuture ? _message : message as String,
//     );
//   }
// }

// class Union3 implements Union {
//   const Union3._({String foo}) : _foo = foo;
//   const factory Union3({String foo}) = Union3._;

//   final String _foo;

//   @override
//   R when<R>(
//     R Function(int value) $default, {
//     R Function() loading,
//     R Function(String message) error,
//     R Function(String foo) named,
//   }) {
//     assert(loading != null);
//     assert(error != null);
//     assert(named != null);
//     assert($default != null);
//     return named(_foo);
//   }

//   @override
//   R maybeWhen<R>(
//     R Function(int value) $default, {
//     R Function() loading,
//     R Function(String message) error,
//     R Function(String foo) named,
//     @required R Function() orElse,
//   }) {
//     assert(orElse != null);
//     if (named != null) return named(_foo);
//     return orElse();
//   }

//   @override
//   R map<R>(
//     R Function(Union0 value) $default, {
//     R Function(Union1 value) loading,
//     R Function(Union2 value) error,
//     R Function(Union3 value) named,
//   }) {
//     assert(loading != null);
//     assert(error != null);
//     assert(named != null);
//     assert($default != null);
//     return named(this);
//   }

//   @override
//   R maybeMap<R>(
//     R Function(Union0 value) $default, {
//     R Function(Union1 value) loading,
//     R Function(Union2 value) error,
//     R Function(Union3 value) named,
//     @required R Function() orElse,
//   }) {
//     assert(orElse != null);
//     if (named != null) return named(this);
//     return orElse();
//   }

//   Union3 copyWith({
//     FutureOr<String> foo = const _ConstFuture(),
//   }) {
//     return Union3(
//       foo: foo is _ConstFuture ? _foo : foo as String,
//     );
//   }
// }
