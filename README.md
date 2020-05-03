[![Build Status](https://travis-ci.org/rrousselGit/freezed.svg?branch=master)](https://travis-ci.org/rrousselGit/freezed)
[![pub package](https://img.shields.io/pub/v/freezed.svg)](https://pub.dartlang.org/packages/freezed)

Welcome to [Freezed], yet another code generator for unions/pattern-matching/copy.

# Motivation

While there are many code-generators available to help you deal with immutable objects, they usually come with a trade-off.\
Either they have a simple syntax but lack in feature, or they have very advanced
features but with complex syntax.

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

  The benefits of this approach are that it _does_ support nullable values.\
  On the other hand, the syntax is not very readable and fun to use.

**Say hello to [Freezed]~**, with support for advanced use-cases _without_ compromising on the syntax.

See [the example](https://github.com/rrousselGit/freezed/blob/master/example/lib/main.dart) or [the index](#index) for a preview on what's available

# Index

- [How to use](#how-to-use)
  - [Install](#install)
  - [Run the generator](#run-the-generator)
- [The features](#the-features)
  - [The syntax](#the-syntax)
    - [basics](#basics)
    - [custom getters and methods](#custom-getters-and-methods)
    - [non-nullable](#non-nullable)
    - [default values](#default-values)
    - [late](#late)
    - [constructor tear-off](#constructor-tear-off)
    - [decorators](#decorators)
  - [==/toString](#toString)
  - [copyWith](#copyWith)
    - [deep copy](#deep-copy)
  - [Unions/Sealed classes](#unionssealed-classes)
    - [shared properties](#shared-properties)
    - [when](#when)
    - [maybeWhen](#maybeWhen)
    - [map/maybeMap](#mapMaybeMap)
  - [fromJson/toJson](#fromjsontojson)

# How to use

## Install

To use [Freezed], you will need your typical [build_runner]/code-generator setup.\
First, install [build_runner] and [Freezed] by adding them to your `pubspec.yaml` file:

```yaml
# pubspec.yaml
dependencies:
  freezed_annotation:

dev_dependencies:
  build_runner:
  freezed:
```

This install three packages:

- build_runner, the tool to run code-generators
- [freezed], the code generator
- freezed_annotation, a package containing annotations for [freezed].

## Run the generator

Like most code-generators, [Freezed] will need you to both imports the annotation ([meta]),
and use the `part` keyword on the top of your files.

As such, a file that wants to use [Freezed] will start with:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_file.freezed.dart';
```

**CONSIDER**: also importing `package:flutter/foundation.dart`.\
The reason being, importing `foundation.dart` also imports classes to make an
object nicely readable in Flutter's devtool.\
If you import `foundation.dart`, [Freezed] will automatically do it for you.

A full example would be:

```dart
// main.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'main.freezed.dart';

@freezed
abstract class Union with _$Union {
  const factory Union(int value) = Data;
  const factory Union.loading() = Loading;
  const factory Union.error([String message]) = ErrorDetails;
}
```

From there, to run the code generator, you have two possibilities:

- `flutter pub run build_runner build`, if your package depends on Flutter
- `pub run build_runner build` otherwise

# The features

## The syntax

### Basics

[Freezed] works differently than most generators. To define a class using [Freezed],
you will not declare properties but factory constructors instead.

For example, if you want to define a `Person` class, which has 2 properties:

- name, a `String`
- age, an `int`

To do so, you will have to define a _factory constructor_ that takes these properties as parameter:

```dart
@freezed
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

All valid parameter syntax is supported. As such you could write:

```dart
@freezed
abstract class Person with _$Person {
  factory Person(String name, int age) = _Person;
}

Person('Remi', 24)
```

```dart
@freezed
abstract class Person with _$Person {
  const factory Person(String name, {int age}) = _Person;
}

Person('Remi', age: 24)
```

...

You are also not limited to one constructor and non-generic class.\
From example, you should write:

```dart
@freezed
abstract class Union<T> with _$Union<T> {
  const factory Union(T value) = Data<T>;
  const factory Union.loading() = Loading<T>;
  const factory Union.error([String message]) = ErrorDetails<T>;
}
```

See [unions/Sealed classes](#unionssealed-classes) for more information.

### Custom getters and methods

Sometimes, you may want to manually define methods/properties on that class.

But you will quickly notice that if you try to do:

```dart
@freezed
abstract class Person with _$Person {
  const factory Person(String name, {int age}) = _Person;

  void method() {
    print('hello world');
  }
}
```

then it won't work.

This is because by default, [Freezed] has no way of "extending" the class and
instead "implements" it.

To fix it, we need to give [Freezed] a way to use that `extends` keyword.\
To do so, we have to define a single private constructor as such:

```dart
@freezed
abstract class Person implements _$Person { // uses implements instead of with
  const Person._(); // Added constructor
  const factory Person(String name, {int age}) = _Person;

  void method() {
    print('hello world');
  }
}
```

### Non-nullable

[Freezed] is non-nullable ready and will promote null-safe code.\
This is done by automatically adding `assert(my_property != null)` whenever
non-nullable types would not compile.

What this means is, using [Freezed] you have to explicitly tell when a property
is nullable.

**What [Freezed] considers to be non-nullable**:

- non-optional parameters.
- optional positional parameters using `@Default`.
- named parameters decorated by `@required`

**What [Freezd] considers to be nullable**:

- optional parameters
- parameters decorated with `@nullable`

More concretely, if we define a `Person` class as such:

```dart
@freezed
abstract class Person with _$Person {
  const factory Person(
    String name, {
    @required int age,
    Gender gender,
  }) = _Person;
}
```

Then both `name` and `age` will be considered as **non-nullable**.\
On the other hand, `gender` will be nullable.
**nullable**.

Which means you could write:

```dart
Person('Remi', age: 24);
Person('Remi', age: 24, gender: Gender.male);
Person('Remi', age: 24, gender: null);
```

On the other hand, writing the following will result in an exception:

```dart
Person(null) // name cannot be null
Person('Remi') // age cannot be null
```

Then, when the time comes for to migrate to actual non-nullable types, you could
update your code to:

```dart
@freezed
abstract class Person with _$Person {
  const factory Person(
    String name, {
    required int age,
    Gender? gender,
  }) = _Person;
}
```

**Forcing a variable to be nullable**:

Sometimes, you may want to go against these rules and, for example, have a named
required parameter that is nullable.

To do so, you can decorate the desired property with `@nullable`.\
For example, if we wanted to make `age` from our previous example nullable, then
we would write:

```dart
@freezed
abstract class Person with _$Person {
  const factory Person(
    String name, {
    @nullable @required int age,
    Gender gender,
  }) = _Person;
}
```

This then allows us to write:

```dart
Person('Remi') // no longer throws an exception
```

### Default values

Unfortunately, Dart does not allow constructors with the syntax used by [Freezed]
to specify default values.

Which means you cannot write:

```dart
abstract class Example with _$Example {
  const factory Example([int value = 42]) = _Example;
}
```

But [Freezed] offers an alternative for this: `@Default`\
As such, you could rewrite the previous snippet this way:

```dart
abstract class Example with _$Example {
  const factory Example([@Default(42) int value]) = _Example;
}
```

**NOTE**:\
If you are using serialization/deserialization, this will automatically add
a `@JsonKey(defaultValue: <something>)` for you.

### Late

[Freezed] also contains early access to the upcoming `late` keyword.

If you are unfamiliar with that keyword, what `late` does is it allows variables
to be lazily initialized.

You may be familiar with such syntax:

```dart
Model _model;
Model get model => _model ?? _model = Model();
```

With Dart's `late` keyword, we could instead write:

```dart
late final model = Model();
```

And with [Freezed], we could write:

```dart
@late
Model get model => Model();
```

---

Since [Freezed] relies on immutable classes only, then this may be very helpful
for computed properties.

For example, you may write:

```dart
abstract class Todos with _$Todos {
  factory Todos(List<Todo> todos) = _Todos;

  @late
  List<Todo> get completed => todos.where((t) => t.completed).toList();
}
```

As opposed to a normal getter, this will _cache_ the result of `completed`, which
is more efficient.

**NOTE**:

Getters decorated with `@late` will also be visible on the generated `toString`.

### Constructor tear-off

A common use-case is to do a one-to-one mapping between the parameters of a callback
and a constructor.\
For example, you may write:

```dart
future.catchError((error) => MyClass.error(error))
```

But that's kind of redundant. As such, [Freezed] offers a simpler syntax:

```dart
future.catchError($MyClass.error)
```

This new code is strictly equivalent to the previous snippet, just shorter.

Note that this is both compatible with [default values](#default-values) and generics.

### Decorators

[Freezed] supports property and class level decorators by decorating their
respective parameter and constructor definition.

Consider:

```dart
@freezed
abstract class Person with _$Person {
  const factory Person({
    String name,
    int age,
    Gender gender,
  }) = _Person;
}
```

If you want to mark the property `gender` as `@deprecated`, then you can do:

```dart
@freezed
abstract class Person with _$Person {
  const factory Person({
    String name,
    int age,
    @deprecated Gender gender,
  }) = _Person;
}
```

This will deprecate both:

- The constructor
  ```dart
  Person(gender: Gender.something); // gender is deprecated
  ```
- The generated class's constructor:
  ```dart
  _Person(gender: Gender.something); // gender is deprecated
  ```
- the property:
  ```dart
  Person person;
  print(person.gender); // gender is deprecated
  ```
- the `copyWith` parameter:
  ```dart
  Person person;
  person.copyWith(gender: Gender.something); // gender is deprecated
  ```

Similarly, if you want to decorate the generated class you can decorate the
defining factory constructor.

As such, to deprecate `_Person`, you could do:

```dart
@freezed
abstract class Person with _$Person {
  @deprecated
  const factory Person({
    String name,
    int age,
    Gender gender,
  }) = _Person;
}
```

## ==/toString

When using [Freezed], the `toString`, `hashCode` and `==` methods are overridden
as you would expect:

```dart
@freezed
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
@freezed
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
print(person.copyWith(age: null)); // Person(name: Remi, age: null)
```

Notice how `copyWith` correctly was able to understand `null` parameters.

### Deep copy

While `copyWith` is very powerful in itself, it starts to get inconvenient on more complex objects.

Consider the following classes:

```dart
@freezed
abstract class Company with _$Company {
  factory Company({String name, Director director}) = _Company;
}

@freezed
abstract class Director with _$Director {
  factory Director({String name, Assistant assistant}) = _Director;
}

@freezed
abstract class Assistant with _$Assistant {
  factory Assistant({String name, int age}) = _Assistant;
}
```

Then, from a reference on `Company`, we may want to perform changes on `Assistant`.\
For example, to change the `name` of an assistant, using `copyWith` we would have to write:

```dart
Company company;

Company newCompany = company.copyWith(
  director: company.director.copyWith(
    assistant: company.director.assistant.copyWith(
      name: 'John Smith',
    ),
  ),
);
```

This _works_, but is relatively verbose with a lot of duplicates.\
This is where we could use [Freezed]'s "deep copy".

If an object decorated using `@freezed` contains other objects decorated with
`@freezed`, then [Freezed] will offer an alternate syntax to the previous example:

```dart
Company company;

Company newCompany = company.copyWith.director.assistant(name: 'John Smith');
```

This snippet will achieve strictly the same result as the previous snippet
(creating a new company with an updated assistant name), but no longer has duplicates.

Going deeper in this syntax, if instead, we wanted to change the director's name
then we could write:

```dart
Company company;
Company newCompany = company.copyWith.director(name: 'John Doe');
```

Overall, from the definition of `Company`/`Director`/`Assistant` mentionned above,
then these are all the potential "copy" syntaxes that we can do:

```dart
Company company;

company = company.copyWith(name: 'Google', director: Director(...));
company = company.copyWith.director(name: 'Larry', assistant: Assistant(...));
company = company.copyWith.director.assistant(name: 'John', age: 42);
```

**Null consideration**

Some objects may have for value `null`. For example, using our `Company` class,
then `Director` may be `null`.

As such, writing:

```dart
Company company = Company(name: 'Google', director: null);
Company newCompany = company.copyWith.director.assistant(name: 'John');
```

doesn't make sense.\
We can't change the director's assistant if there is no director to begin with.\

In that situation, `company.copyWith.director` will return `null`, and our previous
example will result in a null exception.

To fix it, we can use the `?.` operator and write:

```dart
Company newCompany = company.copyWith.director?.assistant(name: 'John');
```

## Unions/Sealed classes

Coming from other languages, you may be used with features like "tagged union types" / sealed classes/pattern matching.\
These are powerful tools in combination with a type system, but Dart currently does not support them.

But fear not, [Freezed] supports them all, by using a syntax similar to Kotlin.

Defining a union/sealed class with [Freezed] is simple: write multiple constructors:

```dart
@freezed
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

When defining multiple constructors, you will lose the ability to do read properties that are not common to all constructors:

For example, if you write:

```dart
@freezed
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
- [map](#mapMaybeMap)
- [maybeMap](#mapMaybeMap)

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
@freezed
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
@freezed
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

On the other hand, it adds an extra `orElse` required parameter, for fallback behavior.

As such, using:

```dart
@freezed
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
@freezed
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
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

@freezed
abstract class Model with _$Model {
  factory Model.first(String a) = First;
  factory Model.second(int b, bool c) = Second;
}
```

The changes necessary to make it compatible with [json_serializable] consists of two lines:

- a new `part`: `part 'model.g.dart';`
- a new constructor on the targeted class: `factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);`

The end result is:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
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

**What about `@JsonKey` annotation?**

All decorators passed to a constructor parameter are "copy-pasted" to the generated property too.\
As such, you can write:

```dart
@freezed
abstract class Example with _$Example {
  factory Example(@Jsonkey(name: 'my_property') String myProperty) = _Example;

  factory Example.fromJson(Map<String, dynamic> json) => _$ExampleFromJson(json);
}
```

**What about `@JsonSerializable` annotation?**

You can pass `@JsonSerializable` annotation by placing it over constructor e.g.:

```dart
@freezed
abstract class Example with _$Example {
  @JsonSerializable(explicit_to_json: true)
  factory Example(@Jsonkey(name: 'my_property') SomeOtherClass myProperty) = _Example;

  factory Example.fromJson(Map<String, dynamic> json) => _$ExampleFromJson(json);
}
```

If you want to define some custom json_serializable flags for all the classes (e.g. `explicit_to_json` or `any_map`) you can do it via `build.yaml` file as described [here](https://pub.dev/packages/json_serializable#build-configuration).

See also the [decorators](#decorators) section

[build_runner]: https://pub.dev/packages/build_runner
[freezed]: https://pub.dartlang.org/packages/freezed
[meta]: https://pub.dartlang.org/packages/meta
[copywith]: #copyWith
[when]: #when
[maybewhen]: #maybeWhen
[map]: #mapMaybeMap
[maybemap]: #mapMaybeMap
[json_serializable]: https://pub.dev/packages/json_serializable
