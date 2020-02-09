[![pub package](https://img.shields.io/pub/v/freezed.svg)](https://pub.dartlang.org/packages/freezed)

Welcome to [Freezed], yet another code generator for unions/pattern-patching/copy.

# Motivation

While there are many code-generators available to help you deal with immutable objects, they usually come with a trade-off.\
Either they have a simple syntax but lack in feature, or they have very advanced
features but with a complex syntax.

A typical example would be a "clone" method.\
Current generators have two approaches:

- a `copyWith`, usually implemented using `??`:

  ```dart
  MyClass copyWith({ int a, String b }) {
      return MyClass(a: a ?? this.a, b: b ?? this.b);
  }
  ```

  The syntax is very simple to use, but doesn't support some use-cases: nullable values.\
  We cannot use such `copyWith` to assign `null` to a property like so:

  ```dart
  person.copyWith(location: null)
  ```

* a builder method combined with a temporary mutable object, usually used this way:

  ```dart
  person.rebuild((person) {
    return person
      ..b = person;
  })
  ```

  The benefits of this approach is that it _does_ support nullable values.\
  On the other hand, the syntax is not very readable and fun to use.

**Say hello to [Freezed]~**, with a support for advanced use-cases _without_ compromising on the syntax.

See [the example](https://github.com/rrousselGit/freezed/blob/master/example/lib/main.dart) or [the index](#index) for a preview on what's available

# Index

- [How to use](#how-to-use)
  - [Install](#install)
  - [Run the generator](#run-the-generator)
- [The features](#the-features)
  - [The syntax](#the-syntax)
  - [==/toString](#==/toString)
  - [copyWith](#copyWith)
  - [Unions/Sealed classes](#unions/sealed-classes)
    - [shared properties](#shared-properties)
    - [when](#when)
    - [maybeWhen](#maybeWhen)
    - [map/maybeMap](#map/maybemap)
  - [fromJson/toJson](#fromJson/toJson)
- [Roadmap](#roadmap)

# How to use

## Install

To use [Freezed], you will need your typical [build_runner]/code-generator setup.\
First, install [build_runner] and [Freezed] by adding them to your `pubspec.yaml` file:

```yaml
# pubspec.yaml
dev_dependencies:
  build_runner:
  freezed:
```

As opposed to other code-generators, [Freezed] does **not** have custom annotations.\
Instead it uses `@immutable` from [meta], which comes built-in Flutter (but can be installed
separatly if needed).

## Run the generator

Like most code-generators, [Freezed] will need you to both import the annotation ([meta]),
and use the `part` keyword on the top of your files.

As such, a file that wants to use [Freezed] may either start with:

```dart
import 'package:flutter/foundation.dart';

part 'my_file.freezed.dart';
```

or:

```dart
import 'package:meta/meta.dart';

part 'my_file.freezed.dart';
```

**PREFER**: importing `package:flutter/foundation.dart` over `package:meta/meta.dart`.\
The reason being, importing `foundation.dart` also imports the necessary
classes to make an object nicely readable in Flutter's devtool.\
If you import `foundation.dart`, [Freezed] will automatically them.

A full example would be:

```dart
// main.dart
import 'package:flutter/foundation.dart';

part 'main.freezed.dart';

@immutable
abstract class Union with _$Union {
  const factory Union(int value) = Data;
  const factory Union.loading() = Loading;
  const factory Union.error([String message]) = ErrorDetails;
}
```

From there, to run the code-generator, you have two possibilities:

- `flutter pub pub run build_runner build`, if your package depends on Flutter
- `pub run build_runner build` otherwise

# The features

## The syntax

[Freezed] works differently than most generators. To define a class using [Freezed],
you will not declare properties but factory constructors instead.

For example, if you want to define a `Person` class, which has 2 properties:

- name, a `String`
- age, an `int`

To do so, you will have to define a _factory constructor_ that takes these properties as parameter:

```dart
@immutable
abstract class Person with _$Person {
  factory Person({ String name, int age }) = _Person;
}
```

Which then allows you to write:

```dart
var person = Person(name: 'Remi', age: 24);
print(person.name); // Remi
print(person.age); // 24
```

**NOTE**:\
You do not have to use named parameters for your constructor.

All valid parameter syntax are supported. As such you could write:

```dart
@immutable
abstract class Person with _$Person {
  factory Person(String name, int age) = _Person;
}

Person('Remi', 24)
```

```dart
@immutable
abstract class Person with _$Person {
  const factory Person(String name, {int age = 42}) = _Person;
}

Person('Remi', age: 24)
```

...

You are also not limited to one constructor and non-generic class.\
From example, you should write:

```dart
@immutable
abstract class Union<T> with _$Union<T> {
  const factory Union(T value) = Data<T>;
  const factory Union.loading() = Loading<T>;
  const factory Union.error([String message]) = ErrorDetails<T>;
}
```

See [unions/Sealed classes](#unions/sealed-classes) for more information.

## ==/toString

When using [Freezed], the `toString`, `hashCode` and `==` methods are overriden
as you would expect:

```dart
@immutable
abstract class Person with _$Person {
  factory Person({ String name, int age }) = _Person;
}


void main() {
  print(Person(name: 'Remi', age: 24)); // Person(name: Remi, age: 24)

  print(
    Person(name: 'Remi', age: 24) == Person(name: 'Remi', age: 24),
  ); // true
}
```

## copyWith

As stated in the very beginning of this readme, [Freezed] does not compromise
on the syntax to have a powerful copy.

The `copyWith` method generated by [Freezed] **does** support assigning a value
to `null`.\
For example, if we take our previous `Person` class:

```dart
@immutable
abstract class Person with _$Person {
  factory Person(String name, int age) = _Person;
}
```

Then we could write:

```dart
var person = Person('Remi', 24);

// `age` not passed, its value is preserved
print(person.copyWith(name: 'Dash')); // Person(name: Dash, age: 24)
// `age` is set to `null`
print(person.copyWith(age: null)); // Person(name: Person, age: null)
```

Notice how `copyWith` correctly was able to understand `null` parameters.

## Unions/Sealed classes

Coming from other languages, you may be used with features like "tagged union types" / sealed clases / pattern matching.\
These are powerful tool in combination with a type system, but Dart currently does not support them.

But fear not, [Freezed] supports them all, by using a syntax similar to Kotlin.

Defining a union/sealed class with [Freezed] is simple: write multiple constructors:

```dart
@immutable
abstract class Union with _$Union {
  const factory Union(int value) = Data;
  const factory Union.loading() = Loading;
  const factory Union.error([String message]) = ErrorDetails;
}
```

This snippet defines a class with three states.\
Note how we gave meaningful names to the right hand of the factory constructors we defined.
They will come in handy later.

### Shared properties

When defining multiple constructors, you will loose the ability to do read properties that are not common to all constructors:

For example, if you write:

```dart
@immutable
abstract class Example with _$Example {
  const factory Example.person(String name, int age) = Person;
  const factory Example.city(String name, int population) = City;
}
```

Then you will be unable to read `age` and `population` directly:

```dart
var example = Example.person('Remi', 24);
print(example.age); // does not compile!
```

On the other hand, you **can** read properties that are defined on all constructors.\
For example, the `name` variable is common to both `Example.person` and `Example.city` constructors.

As such we can write:

```dart
var example = Example.person('Remi', 24);
print(example.name); // Remi
example = Example.city('London', 8900000);
print(example.name); // London
```

You also **can** use `copyWith` with properties defined on all constructors:

```dart
var example = Example.person('Remi', 24);
print(example.copyWith(name: 'Dash')); // Example.person(name: Dash, age: 24)

example = Example.city('London', 8900000);
print(example.copyWith(name: 'Paris')); // Example.city(name: Paris, population: 8900000)
```

To be able to read the other properties, you can use pattern matching thanks to the generated methods:

- [when](#when)
- [maybeWhen](#maybeWhen)
- [map](#map/maybeMap)
- [maybeMap](#map/maybeMap)

Alternatively, you can use the `is` operator:

```dart
var example = Example.person('Remi', 24);
if (example is Person) {
  print(example.age); // 24
}
```

### When

The [when] method is the equivalent to pattern matching with destructing.\
Its prototype depends on the constructors defined.

For example, with:

```dart
@immutable
abstract class Union with _$Union {
  const factory Union(int value) = Data;
  const factory Union.loading() = Loading;
  const factory Union.error([String message]) = ErrorDetails;
}
```

Then [when] will be:

```dart
var union = Union(42);

print(
  union.when(
    (int value) => 'Data $data',
    loading: () => 'loading',
    error: (String message) => 'Error: $message',
  ),
); // Data 42
```

Whereas if we defined:

```dart
@immutable
abstract class Model with _$Model {
  factory Model.first(String a) = First;
  factory Model.second(int b, bool c) = Second;
}
```

Then [when] will be:

```dart
var model = Model.first('42');

print(
  model.when(
    first: (String a) => 'first $a',
    second: (int b, bool c) => 'second $b $c'
  ),
); // first 42
```

Notice how each callback matches with a constructor's name and prototype.

**NOTE**:\
All callbacks are required and must not be `null`.\
If that is not what you want, consider using [maybeWhen].

### MaybeWhen

The [maybeWhen] method is equivalent to [when], but doesn't require all callbacks
to be specified.

On the other hand, it adds an extra `orElse` required parameter, for a fallback behavior.

As such, using:

```dart
@immutable
abstract class Union with _$Union {
  const factory Union(int value) = Data;
  const factory Union.loading() = Loading;
  const factory Union.error([String message]) = ErrorDetails;
}
```

Then we could write:

```dart
var union = Union(42);

print(
  union.maybeWhen(
    null, // ignore the default case
    loading: () => 'loading',
    // did not specify an `error` callback
    orElse: () => 'fallback',
  ),
); // fallback
```

This is equivalent to:

```dart
var union = Union(42);

String label;
if (union is Loading) {
  label = 'loading';
} else {
  label = 'fallback';
}
```

But it is safer as you are forced to handle the fallback case, and it is easier to write.

### Map/MaybeMap

The [map] and [maybeMap] methods are equivalent to [when]/[maybeWhen], but **without** destructuring.

Consider this class:

```dart
@immutable
abstract class Model with _$Model {
  factory Model.first(String a) = First;
  factory Model.second(int b, bool c) = Second;
}
```

With such class, while [when] will be:

```dart
var model = Model.first('42');

print(
  model.when(
    first: (String a) => 'first $a',
    second: (int b, bool c) => 'second $b $c'
  ),
); // first 42
```

[map] will instead be:

```dart
var model = Model.first('42');

print(
  model.map(
    first: (First value) => 'first ${value.a}',
    second: (Second value) => 'second ${value.b} ${value.c}'
  ),
); // first 42
```

This can be useful if you want to do complex operations, like [copyWith]/`toString` for example:

```dart
var model = Model.second(42, false)
print(
  model.map(
    first: (value) => value,
    second: (value) => value.copyWith(c: true),
  )
); // Model.second(b: 42, c: true)
```

## FromJson/ToJson

While [Freezed] will not generate your typical `fromJson`/`toJson` by itself, it knowns
what [json_serializable] is.

Making a class compatible with [json_serializable] is very straightforward.

Consider this snippet:

```dart
import 'package:flutter/foundation.dart';

part 'model.freezed.dart';

@immutable
abstract class Model with _$Model {
  factory Model.first(String a) = First;
  factory Model.second(int b, bool c) = Second;
}
```

The changes necessary to make it compatible with [json_serializable] consists of three lines:

- a new import: `import 'package:json_annotation/json_annotation.dart'`
- a new `part`: `part 'model.g.dart';`
- a new constructor on the desired targeted: `factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);`

The end result is:

```dart
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@immutable
abstract class Model with _$Model {
  factory Model.first(String a) = First;
  factory Model.second(int b, bool c) = Second;

  factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);
}
```

That's it!\
With these changes, [Freezed] will automatically ask [json_serializable] to generate all the necessary
`fromJson`/`toJson`.

Then, for classes with multiple constructors, [Freezed] will take care of deciding which
constructor should be used.

# Roadmap

- support for properties shared between multiple constructors but with a different type.
- default variable support on the custom generated constructors.

[build_runner]: https://pub.dev/packages/build_runner
[freezed]: https://pub.dartlang.org/packages/freezed
[meta]: https://pub.dartlang.org/packages/meta
[copywith]: #copyWith
[when]: #when
[maybewhen]: #maybeWhen
[map]: #map/maybeMap
[maybemap]: #map/maybeMap
[json_serializable]: https://pub.dev/packages/json_serializable
