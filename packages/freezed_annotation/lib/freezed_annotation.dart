export 'package:collection/collection.dart';
export 'package:json_annotation/json_annotation.dart';
export 'package:meta/meta.dart';

/// {@template freezed_annotation.freezed}
/// Flags a class as needing to be processed by Freezed and allows passing options.
/// {@endtemplate}
class Freezed {
  /// {@template freezed_annotation.freezed}
  const Freezed({
    this.unionKey,
    this.unionValueCase = FreezedUnionCase.none,
  });

  /// Determines what key should be used to de/serialize union types.
  ///
  /// Consider:
  ///
  /// {@template freezed_annotation.freezed.example}
  /// ```dart
  /// @freezed
  /// class Union with _$Union {
  ///   factory Union.first() = _First;
  ///   factory Union.second() = _Second;
  ///
  ///   factory Union.fromJson(Map<String, Object> json) => _$UnionFromJson(json);
  /// }
  /// ```
  ///
  /// When serializing or deserializing `Union`, Freezed will ask/demand for an
  /// extra json key, which represents which constructor should be used.
  ///
  /// More specifically, when calling `Union.toJson`, we will have:
  ///
  /// ```dart
  /// void main() {
  ///   print(Union.first().toJson()); // { 'runtimeType': 'first' }
  ///   print(Union.second().toJson()); // { 'runtimeType': 'second' }
  /// }
  /// ```
  /// {@endtemplate}
  ///
  /// This variable allows customizing the key used ("runtimeType" by default).
  ///
  /// For example, we could change our previous `Union` implementation to:
  ///
  /// ```dart
  /// @Freezed(unionKey: 'type')
  /// abstract class Union with _$Union {
  ///   // ...
  /// }
  /// ```
  ///
  /// which changes how `fromJson`/`toJson` behaves:
  ///
  /// ```dart
  /// void main() {
  ///   print(Union.first().toJson()); // { 'type': 'first' }
  ///   print(Union.second().toJson()); // { 'type': 'second' }
  /// }
  /// ```
  final String? unionKey;

  /// Determines how the value used to de/serialize union types would be
  /// renamed.
  ///
  /// Consider:
  ///
  /// {@macro freezed_annotation.freezed.example}
  ///
  /// This variable allows customizing the value used (constructor name by
  /// default).
  ///
  /// For example, we could change our previous `Union` implementation to:
  ///
  /// ```dart
  /// @Freezed(unionValueCase: FreezedUnionCase.pascal)
  /// class Union with _$Union {
  ///   // ...
  /// }
  /// ```
  ///
  /// which changes how `fromJson`/`toJson` behaves:
  ///
  /// ```dart
  /// void main() {
  ///   print(Union.first().toJson()); // { 'runtimeType': 'First' }
  ///   print(Union.second().toJson()); // { 'runtimeType': 'Second' }
  /// }
  /// ```
  ///
  /// You can also use [FreezedUnionValue] annotation to customize single
  /// union case.
  final FreezedUnionCase unionValueCase;
}

/// An annotation for the `freezed` package.
///
/// Annotating a class with this annotation will flag it as needing to be
/// processed by the `freezed` code generator.
const freezed = Freezed();

/// {@template freezed_annotation.assert}
/// A decorator that allows adding `assert(...)` on the generated classes.
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
/// {@endtemplate}
class Assert {
  /// {@macro freezed_annotation.assert}
  const Assert(this.eval, [this.message]);

  /// A string representation of the source code that will be executed by the assert.
  final String eval;

  /// An optional message to show if the assertion failed.
  final String? message;
}

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

  final Object? defaultValue;
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

  final Type? type;
  final String? stringType;
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

  final Type? type;
  final String? stringType;
}

/// An annotation used to specify how a union type will be serialized.
///
/// By default, Freezed generates the value based on the name of the
/// constructor. You can override this behavior by annotating constructor and
/// providing custom value.
///
/// ```dart
/// @freezed
/// class MyResponse with _$MyResponse {
///   const factory MyResponse(String a) = MyResponseData;
///
///   @FreezedUnionValue('SpecialCase')
///   const factory MyResponse.special(String a, int b) = MyResponseSpecial;
///
///   factory MyResponse.fromJson(Map<String, dynamic> json) => _$MyResponseFromJson(json);
/// }
/// ```
///
/// The constructor will be chosen as follows:
///
/// ```json
/// [
///   {
///     "runtimeType": "default",
///     "a": "This JSON object will use constructor MyResponse()"
///   },
///   {
///     "runtimeType": "SpecialCase",
///     "a": "This JSON object will use constructor MyResponse.special()",
///     "b": 42
///   }
/// ]
class FreezedUnionValue {
  const FreezedUnionValue(this.value);

  final String value;
}

/// An annotation used to specify fallback constructor used when union type is not matched
///
/// By default, Freezed generates code that will throw FallThroughError when type
/// is not matched through constructor name or using [FreezedUnionValue].
/// You can override this behavior by annotating constructor and using it as a fallback one
///
/// ```dart
/// @freezed
/// class MyResponse with _$MyResponse {
///   const factory MyResponse.special(String a, int b) = MyResponseSpecial;
///
///   @FreezedUnionFallback()
///   const factory MyResponse.fallback(String a, int b) = MyResponseFallback;
///
///   factory MyResponse.fromJson(Map<String, dynamic> json) => _$MyResponseFromJson(json);
/// }
/// ```
///
/// The constructor will be chosen as follows:
///
/// ```json
/// [
///   {
///     "runtimeType": "default",
///     "a": "This JSON object will use constructor MyResponse()"
///   },
///   {
///     "runtimeType": "SpecialCase",
///     "a": "This JSON object will use constructor MyResponse.special()",
///     "b": 42
///   }
/// ]
class FreezedUnionFallback {
  const FreezedUnionFallback();
}

/// Options for automatic union values renaming.
enum FreezedUnionCase {
  /// Use the name without changes.
  none,

  /// Encodes a constructor named `kebabCase` with a JSON value `kebab-case`.
  kebab,

  /// Encodes a constructor named `pascalCase` with a JSON value `PascalCase`.
  pascal,

  /// Encodes a constructor named `snakeCase` with a JSON value `snake_case`.
  snake,
}
