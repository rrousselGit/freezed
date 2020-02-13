export "package:collection/collection.dart";
export "package:json_annotation/json_annotation.dart";

class Freezed {
  const Freezed();
}

/// An annotation for the `freezed` package.
///
/// Annotating a class with this annotation will flag it as needing to be
/// processed by the `freezed` code generator.
const freezed = Freezed();
