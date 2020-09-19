export 'package:collection/collection.dart';
export 'package:json_annotation/json_annotation.dart';
export 'package:meta/meta.dart';

class Freezed {
  const Freezed._();
}

/// A decorator that allowed adding `assert(...)` on the generated classes.
///
/// Usage example:
///
/// ```dart
/// abstract class Person with _$Person {
///   @Assert('name.trim().isNotEmpty', 'name cannot be empty')
///   @Assert('age >= 0')
///   factory Person({
///     String name,
///     int age,
///   }) = _Person;
/// }
/// ```
class Assert {
  const Assert(this.eval, [this.message]);

  /// A string representation of the source code that will be executed by the assert.
  final String eval;

  /// An optional message to show if the assertion failed.
  final String message;
}

/// An annotation for the `freezed` package.
///
/// Annotating a class with this annotation will flag it as needing to be
/// processed by the `freezed` code generator.
const freezed = Freezed._();

class _Nullable {
  const _Nullable._();
}

/// Mark the generated property as nullable.
///
/// This disables the generation of `assert(property != null)` on both the
/// constructor and clone methods for the decorated property.
const nullable = _Nullable._();

class _Late {
  const _Late._();
}

/// Mark a getter as safe to cache.
///
/// Getters marked with `late` will be called **at most** once per instane of the
/// object.\
/// Only getters using the `=>` syntax are supported. Getters with `{}` are not.
///
/// This makes the getter behave similarly to the upcoming `late` keyword:
///
/// ```dart
/// @late
/// String get fullName => '$firstName $lastName';
/// ```
///
/// is the equivalent to the upcoming:
///
/// ```dart
/// late final fullName = '$firstName $lastName';
/// ```
const late = _Late._();

/// Allows passing default values to a constructor:
///
/// ```dart
/// abstract class Example with _$Example {
///   factory Example(@Default(42) int value) = _Example;
/// }
/// ```
///
/// is equivalent to:
///
/// ```dart
/// abstract class Example with _$Example {
///   factory Example(@JsonKey(defaultValue: 42) int value = 42) = _Example;
/// }
/// ```
class Default {
  const Default(this.defaultValue);

  final Object defaultValue;
}

/// Marks a union type to implement the interface [type] or [stringType].
/// In the case below `City` will implement `GeographicArea`.
/// ```dart
/// @freezed
/// abstract class Example with _$Example {
///   const factory Example.person(String name, int age) = Person;
///
///   @Implements(GeographicArea)
///   const factory Example.city(String name, int population) = City;
/// }
/// ```
///
/// In case you need to implement a generic class, due to the fact that
/// annotations can't have type arguments, you must use the
/// [Implements.fromString(stringType)] constructor and provide the type as a
/// String.
/// ```dart
/// @freezed
/// abstract class Example with _$Example {
///   const factory Example.person(String name, int age) = Person;
///
///   @Implements.fromString('AdministrativeArea<House>')
///   const factory Example.street(String name) = Street;
///
///   @Implements(GeographicArea)
///   const factory Example.city(String name, int population) = City;
/// }
/// ```
///
/// Note: You need to make sure that you comply with the interface requirements
/// by implementing all the abstract members. If the interface has no members or
/// just fields you can fulfil the interface contract by adding them in the
/// constructor of the union type. Keep in mind that if the interface defines a
/// method or a getter, that you implement in the class, you need to use the
/// [Custom getters and methods](#custom-getters-and-methods) instructions.
class Implements {
  const Implements(this.type) : stringType = null;

  const Implements.fromString(this.stringType) : type = null;

  final Type type;
  final String stringType;
}

/// Marks a union type to mixin the class [type] or [stringType].
/// In the case below `City` will mixin with `GeographicArea`.
/// ```dart
/// @freezed
/// abstract class Example with _$Example {
///   const factory Example.person(String name, int age) = Person;
///
///   @With(GeographicArea)
///   const factory Example.city(String name, int population) = City;
/// }
/// ```
///
/// In case you need to mixin a generic class, due to the fact that
/// annotations can't have type arguments, you must use the
/// [With.fromString('stringType')] constructor and provide the type as a
/// String.
/// ```dart
/// @freezed
/// abstract class Example with _$Example {
///   const factory Example.person(String name, int age) = Person;
///
///   @With.fromString('AdministrativeArea<House>')
///   const factory Example.street(String name) = Street;
///
///   @With(GeographicArea)
///   const factory Example.city(String name, int population) = City;
/// }
/// ```
///
/// Note: You need to make sure that you comply with the interface requirements
/// by implementing all the abstract members. If the mixin has no members or
/// just fields, you can fulfil the interface contract by adding them in the
/// constructor of the union type. Keep in mind that if the mixin defines a
/// method or a getter, that you implement in the class, you need to use the
/// [Custom getters and methods](#custom-getters-and-methods) instructions.
class With {
  const With(this.type) : stringType = null;

  const With.fromString(this.stringType) : type = null;

  final Type type;
  final String stringType;
}
