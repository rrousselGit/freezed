[![Build Status](https://travis-ci.org/rrousselGit/freezed.svg?branch=master)](https://travis-ci.org/rrousselGit/freezed)
[![pub package](https://img.shields.io/pub/v/freezed.svg)](https://pub.dartlang.org/packages/freezed)

Welcome to `Freezed`, yet another code generator for immutable classes / sealed classes / union types / copy.

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

**Say hello to `Freezed`~**, with a support for advanced use-cases _without_ compromising on the syntax.

See [the example](https://github.com/rrousselGit/freezed/blob/master/example/lib/main.dart) or [the index](#index) for a preview on what's available

# Index

- [How to use](#how-to-use)
- [The features](#the-features)
  - [copyWith](#copyWith)
  - [Unions/Sealed classes](#union)
    - [when](#when)
    - [maybeWhen](#maybeWhen)
    - [map](#map)
    - [maybeMap](#maybeMap)
    - [shared properties](#shared-properties)
  - [==](#==)
  - [toString](#toString)
  - [default values](#default-values)

# How to use

