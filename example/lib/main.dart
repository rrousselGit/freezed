
import 'package:flutter/foundation.dart';

part 'main.g.dart';

@immutable
abstract class MyClass with _$MyClass {
  factory MyClass({String a, int b}) = _MyClass;
}

@immutable
abstract class Union with _$Union {
  const factory Union(int value) = Union0;
  const factory Union.loading() = Union1;
  const factory Union.error([String message]) = Union2;
  const factory Union.complex(int a, String b) = Union3;
}

@immutable
abstract class SharedProperty with _$SharedProperty {
  factory SharedProperty.person(String name, int age) = SharedProperty0;
  factory SharedProperty.city(String name, int population) = SharedProperty1;
}

void main() {
  final myClassexample = MyClass(a: '42', b: 42);

  // clone
  print(myClassexample.copyWith(a: null)); // MyClass(a: null, b: 42)
  print(myClassexample.copyWith()); // MyClass(a: '42', b: 42)


  // == override
  print(MyClass(a: '42', b: 42) == MyClass(a: '42', b: 42)); // true
  print(MyClass(a: '42', b: 42) == MyClass()); // false

  // union type/sealed class
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

  // shared properties between union possibilities
  var example = SharedProperty.person('Remi', 24);
  // OK, `name` is shared between both .person and .city constructor
  print(example.name); // Remi
  example = SharedProperty.city('London', 200000);
  print(example.name); // London

  // COMPILE ERROR
  // print(example.age);
  // print(example.population);
}
