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
