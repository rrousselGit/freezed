## Motivation

Fully immutable classes is a powerful pattern, but it relies a lot on a way to copy the class with new values.

The issue is, Dart does not support well such clone.

There are some existing code-generators to help with this (like `built_value`), but the syntax is usually not ideal.

We tend to have two approaches for the "copy" method:

- a `copyWith`, usually implemented this way:
  ```dart
  MyClass copyWith({ int a, String b }) {
      return MyClass(a: a ?? this.a, b: b ?? this.b);
  }
  ```

  The syntax is clean, but doesn't support some use-cases: nullable values.

  We can't do something like `myClass.copyWith(b: null)`

- a builder method combined with a temporary mutable object, usually used this way:

  ```dart
  myClass.rebuild((builder) {
    return builder
      ..a = 42
      ..b = null;
  })
  ```

  The benefits of this approach is that it _does_ support nullable values.

  On the other hand, the syntax is not very readable and fun to use.


That's where `immutable` brings the gap between both.

This is a code-generator that will generate a `copyWith` approach that _does_ work with nullable values, while having the same syntax as other `copyWith` implementation.

## How to use

// insert pubspec instructions

To use the generator, you basically need to declare the constructor of your class.

Then the generator will generate everything else; including the properties.


As such, if you want a class `MyClass` which has two fields:

- a non-nullable `int` named `a`
- a nullable `String` named `b`

then you can write:

```dart
abstract class MyClass extends _MyClassBase {
  const factory MyClass({
    @required int a,
    String b,
  }) = _MyClass;
}
```

Just about any constructor is supported, including named/positional parameters and default values.

From there, you can instantiate `MyClass` normally:

```dart
var myClass = MyClass(a: 42, b: 'hello world');
```

But you also have access to the `copyWith` method:

```dart
void main() {
  var myClass = MyClass(a: 42, b: 'hello world');

  print(myClass); // MyClass(a: 42, b: hello world)
  print(myClass.copyWith(a: 24)); // MyClass(a: 24, b: hello world)
  print(myClass.copyWith(b: null)); // MyClass(a: 24, b: null)
}
```

Notice how `myClass.copyWith(b: null)` properly made a clone where `b` is `null`, but `myClass.copyWith(a: 24))` did not.

This is voluntary.

As opposed to other approaches, `immutable` is able to differentiate between:

```dart
myClass.copyWith(b: null)
````

and:

```dart
myClass.copyWith()
```

which allows `copyWith` to work with nullable values.


## Serialization/Deserialization

By default, `immutable` will also generate a `toJSON` method:


```dart
Map<String, dynamic> json = myClass.toJSON();
```

As for a `fromJSON` method, it is possible to generate one by writing an extra named constructor.

If we take our previous `MyClass` example, then adding then to add a `fromJSON` constructor we'd write:

```dart
abstract class MyClass extends _MyClassBase {
  const factory MyClass({
    @required int a,
    String b,
  }) = _MyClass;

  factory MyClass.fromJSON(Map<String, dynamic> json) = _MyClass.fromJSON; // this line
}
```

