import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main.freezed.dart';

@freezed
abstract class MyClass with _$MyClass {
  factory MyClass({String a, int b}) = _MyClass;
}

@freezed
abstract class Union with _$Union {
  const factory Union(int value) = Data;

  const factory Union.loading() = Loading;

  const factory Union.error([String message]) = ErrorDetails;

  const factory Union.complex(int a, String b) = Complex;
}

@freezed
abstract class SingleCaseUnionWithData with _$SingleCaseUnionWithData {
  const factory SingleCaseUnionWithData.singleCase(int a, String b) = SingleCaseWithData;
}

@freezed
abstract class SingleCaseUnionWithoutData with _$SingleCaseUnionWithoutData {
  const factory SingleCaseUnionWithoutData.singleCase() = SingleCaseWithoutData;
}

@freezed
abstract class SharedProperty with _$SharedProperty {
  factory SharedProperty.person({String name, int age}) = SharedProperty0;

  factory SharedProperty.city({String name, int population}) = SharedProperty1;
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
  print(
    // `when` requires all callbacks to be not null
    unionExample.when(
      (value) => '$value',
      loading: () => 'loading',
      error: (message) => 'Error: $message',
      complex: (a, b) => 'complex $a $b',
    ),
  ); // 42

  print(
    // maybeWhen allows some callbacks to be missing, but requires an `orElse` callback
    unionExample.maybeWhen(
      null,
      loading: () => 'loading',
      // voluntarily didn't pass error/complex callbacks
      orElse: () => 42,
    ),
  ); // 42

  // ------------------

  // non-destructuring pattern-matching
  // works the same as `when`, but the callback is slightly different
  print(
    // `map` requires all callbacks to be not null
    unionExample.map(
      (Data value) => '$value',
      loading: (Loading value) => 'loading',
      error: (ErrorDetails error) => 'Error: ${error.message}',
      complex: (Complex value) => 'complex ${value.a} ${value.b}',
    ),
  ); // 42

  print(
    // maybeWhen allows some callbacks to be missing, but requires an `orElse` callback
    unionExample.maybeMap(
      null,
      error: (ErrorDetails value) => value.message,
      // voluntarily didn't pass error/complex callbacks
      orElse: () => 'fallthrough',
    ),
  ); // fallthrough

  // ------------------

  // nice toString
  print(const Union(42)); // Union(value: 42)
  print(const Union.loading()); // Union.loading()
  print(const Union.error('Failed to fetch')); // Union.error(message: Failed to fetch)

  // union with single case - with data
  const singleCaseUnionWithDataExample = SingleCaseUnionWithData.singleCase(43, 'string');

  // single-case supports `when`
  print(singleCaseUnionWithDataExample.when(
    singleCase: (a, b) {
      return 'single-case union with data: "$a" "$b"';
    },
  ));

  // and `map` too
  print(
    singleCaseUnionWithDataExample.map(
      singleCase: (SingleCaseWithData singleCase) => '$singleCase',
    ),
  );

  // even though it has single case, you still can use maybeWhen, so that your code is ready when you add more cases
  print(
    singleCaseUnionWithDataExample.maybeWhen(
      singleCase: (a, b) => '$a $b', // this is optional
      orElse: () => 'this will not be called, since all cases are covered',
    ),
  );

  // same goes for maybeMap
  print(
    singleCaseUnionWithDataExample.maybeMap(
      singleCase: (SingleCaseWithData a) => '$a', // this is optional
      orElse: () => 'this will not be called, since all cases are covered',
    ),
  );

  // union with single case - without data - works the same way as the single case with data.
  const singleCaseUnionWithoutDataExample = SingleCaseUnionWithoutData.singleCase();

  print(singleCaseUnionWithoutDataExample.when(
    singleCase: () {
      return 'single-case union without data';
    },
  ));

  print(
    singleCaseUnionWithoutDataExample.map(
      singleCase: (SingleCaseWithoutData singleCase) => '$singleCase',
    ),
  );

  print(
    singleCaseUnionWithoutDataExample.maybeWhen(
      singleCase: () => 'has no data', // this is optional
      orElse: () => 'this will not be called, since all cases are covered',
    ),
  );

  // same goes for maybeMap
  print(
    singleCaseUnionWithoutDataExample.maybeMap(
      singleCase: (SingleCaseWithoutData a) => '$a', // this is optional
      orElse: () => 'this will not be called, since all cases are covered',
    ),
  );

  // ------------------

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
