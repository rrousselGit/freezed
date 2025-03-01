import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main.freezed.dart';
part 'main.g.dart';

@freezed
abstract class MyClass with _$MyClass {
  factory MyClass({String? a, int? b}) = _MyClass;
}

@freezed
sealed class Union with _$Union {
  const factory Union(int value) = Data;
  const factory Union.loading() = Loading;
  const factory Union.error([String? message]) = ErrorDetails;
  const factory Union.complex(int a, String b) = Complex;

  factory Union.fromJson(Map<String, Object?> json) => _$UnionFromJson(json);
}

@freezed
abstract class SharedProperty with _$SharedProperty {
  factory SharedProperty.person({
    String? name,
    int? age,
  }) = SharedProperty0;

  factory SharedProperty.city({
    String? name,
    int? population,
  }) = SharedProperty1;
}

void main() {
  final myClassexample = MyClass(a: '42', b: 42);

  // clone
  print(myClassexample.copyWith(a: null)); // MyClass(a: null, b: 42)
  print(myClassexample.copyWith()); // MyClass(a: '42', b: 42)

  // ------------------

  // == override
  print(MyClass(a: '42', b: 42) == MyClass(a: '42', b: 42)); // true
  print(MyClass(a: '42', b: 42) == MyClass()); // false

  // ------------------

  // destructuring pattern-matching
  const unionExample = Union(42);
  print(switch (unionExample) {
    Data value => '$value',
    Loading _ => 'loading',
    ErrorDetails(:final message) => 'Error: $message',
    Complex(:final a, :final b) => 'complex $a $b',
  }); // 42

  print(
    switch (unionExample) {
      Loading _ => 'loading',
      // voluntarily didn't handle error/complex cases
      _ => 42,
    },
  ); // 42

  // ------------------

  // non-destructuring pattern-matching
  // works the same as `when`, but the callback is slightly different
  print(
    switch (unionExample) {
      Data value => '$value',
      Loading _ => 'loading',
      ErrorDetails(:final message) => 'Error: $message',
      Complex(:final a, :final b) => 'complex $a $b',
    },
  ); // 42

  print(
    switch (unionExample) {
      ErrorDetails(:final message) => message,
      // voluntarily didn't handle error/complex cases
      _ => 'fallthrough',
    },
  ); // fallthrough

  // ------------------

  // nice toString
  print(const Union(42)); // Union(value: 42)
  print(const Union.loading()); // Union.loading()
  print(const Union.error(
      'Failed to fetch')); // Union.error(message: Failed to fetch)

  // ------------------

  // shared properties between union possibilities
  var example = SharedProperty.person(name: 'Remi', age: 24);
  // OK, `name` is shared between both .person and .city constructor
  print(example.name); // Remi
  example = SharedProperty.city(name: 'London', population: 8900000);
  print(example.name); // London

  // COMPILE ERROR
  // print(example.age);
  // print(example.population);
}
