export "package:meta/meta.dart";
export "package:collection/collection.dart";
export "package:json_annotation/json_annotation.dart";

class Freezed {
  const Freezed._();
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
///  factory Example(@Default(42) int value) = _Example;
/// }
/// ```
///
/// is equivalent to:
///
/// ```dart
/// abstract class Example with _$Example {
///  factory Example(@JsonKey(defaultValue: 42) int value = 42) = _Example;
/// }
/// ```
class Default {
  const Default(this.defaultValue);

  final Object defaultValue;
}
