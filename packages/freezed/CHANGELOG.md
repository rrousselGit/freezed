## 2.3.4 - 2023-05-13

- Fix allow dollar ($) in recursive class names (thanks to @andreasgangso)
- Fix deprecated warning with analyzer 5.12.0 (thanks to @SunlightBro)
- Remove warning when marking a class as `abstract`

## 2.3.3

- Fixed an issue with the generated code when classes contains a `$` in
  their property/constructor/class name (thanks to @medz)

## 2.3.2

Fix more issues with `copyWith`

## 2.3.1

Fix various issues with `copyWith`

## 2.3.0

- Union types now expose properties with the same name but different type on the
  shared interface. (Thanks to @DevNico)

  This allows doing:

  ```dart
  @freezed
  class Union with _$Union {
    factory Union.first(int value) = _UnionFirst;
    factory Union.second(double value) = _UnionSecond;
  }

  void main() {
    Union union;

    num value = union.value;
    // No need for casting as "num" is the shared interface between int/double
  }
  ```

- Fixes copyWith not working with `null` on some scenarios.
- Fixes a stackoverflow error when continuously passing unmodifiable collections as parameter to freezed classes
- fix: Deep copy now correctly handles cases where a property is a Freezed class with disabled `copyWith`

## 2.2.1

Upgrade analyzer

## 2.2.0

- The generated `copyWith` is now annotated by `@useResult` (thanks to @miDeb)
- Improved performance of `copyWith` (thanks to @miDeb)
- Improved type inference when using `mapOrNull`/`whenOrNull` (thanks to @DevNico)
- Re-introduced `@With.fromString` and `@Implements.fromString` to allow unions
  to implement generic types. (thanks to @rorystephenson)
- fixes @Default for Strings containing (, [ or { (thanks to @hugobrancowb)
- fix Freezed incorrectly comparing primitives using `DeepCollectionEquality` (thanks to @knaeckeKami)
- fix image links (thanks to @SunlightBro)

## 2.1.1

- Bump Analyzer to 5.0.0
- Fix an issuee where Freezed fails to detect that the `Diagnosticable` API is available

## 2.1.0+1

Improve pub score

## 2.1.0

- Add support for de/serializing generic Freezed classes (Thanks to @TimWhiting)
- Fixed a StackOverflow error when defining circular `export`s (Thanks to @TimWhiting)

## 2.0.5

Increase minimum analyzer version.

## 2.0.4

Fixes a bug where using `@unfreezed` on unions somehow still generated immutable properties.

## 2.0.3+1

Update warning message when using abstract freezed classes

## 2.0.3

- fix: performance regression with ==/hashCode/copyWith due to immutable collections (#653)
- fix: build.yaml decoding crash
- fix: remove annotations on internal properties related to immutable collections (#659)

## 2.0.2

Fixed invalid generated code when defining nullable collections.

## 2.0.1

- Fixed a bug where the generated when/map methods were potentially invalid when
  using default values
- Fixed a bug where when/map methods were generated even when not necessary

## 2.0.0

- **Breaking**: freezed_annotation no-longer exports the entire package:collection
- **Breaking**: Freezed no-longer generates `$MyClassTearOff`. This feature is now available in Dart
- **Breaking** Removed `@Freezed(maybeMap: )` & `@Freezed(maybeWhen: )` in favor of a separate:

  ```Dart
  @Freezed(map: FreezedMap(...), when: FreezedWhenOptions(...))
  ```

- **Breaking**: Freezed now converts Lists/Maps/Sets into UnmodifiableListView/UnmodifiableMapView/UnmodifiableSetView.
  This can be disabled for one class by specifying `@Freezed(makeCollectionsUnmodifiable: false)`.
  Alternatively, this can be configured inside the `build.yaml` file

- Added parameters of `@Freezed` to customize the generated code.
  This includes: fromJson, toJson, map, when, equal, toStringOverride, copyWith.

  These parameters allow disabling code that would otherwise be generated.
  It also allows forcing the generation even if it would otherwise not be generated.

- Feat: Add screaming snake union case type (#617) (thanks to @zbarbuto)
- Fix null exceptions in some cases when using typedefs (thanks to @smiLLe)
- Support analyzer 4.0.0
- Fix an issue with generic Freezed classes failing to compile when using `@With<Mixin<T>>()` #614
- Added `@unfreezed` as a variant to `@freezed`, for mutable classes

## 1.1.1

- Lints are now disabled inside generated files (requires Dart 2.15)
- Upgraded the analyzer version to 3.0.0

## 1.1.0

Added support for disabling the generation of `maybeMap`/`maybeWhen` (thanks to @Lyokone)

## 1.0.2+1

Updated the README

## 1.0.2

Fixed a regression with the ==/hashCode implementation generated for
classes with custom implementations of `List`/`Map`/... (see https://github.com/rrousselGit/freezed/issues/561)

## 1.0.1

Fixed an issue where some `build.yaml` options were not properly considered.
This includes changing where the generated files should be placed. (Thanks to @sperochon)

## 1.0.0

Freezed is now stable

This release also:

- reverted an involuntary change of how union types were de/serialized, breaking
  existing code.
- fixed an issue with generic typedefs (thanks to @SunlightBro #552)
- fixed a potential null exception

## 0.15.1+1

- Fixed a bug where the generated code for serializable unions with a base class was invalid

## 0.15.1

- The union key is no longer passed `json_serializable` when deserializing avoid the case of being an `unrecognized_key` in some cases.
- Updated dependencies
- Increased minimum Dart SDK required to 2.14.0
- Fixed an issue where classes with a $ in their name could cause Freezed to fail (Thanks to @comigor #542)
- When using typedefs, the generated code now tries to use the typedef too
  if possible, instead of the aliased type (Thanks to @Norbert515 #536).
- Added support for custom ==/hashCode implementation (Thanks to @casvanluijtelaa #526)
- When writing a custom `toJson` function, it will now always take precedence over
  the default implementation generated by Freezed.

## 0.15.0+1

Fixed the generated `hashCode` not compiling for objects with a large number
of properties. (#531)

## 0.15.0

- **Breaking** Changed the syntax for `@With` and `@Implements` to use a generic annotation.
  Before:

  ```dart
  @With(MyClass)
  @With.fromString('Generic<int>')
  ```

  After:

  ```dart
  @With<MyClass>()
  @With<Generic<int>>()
  ```

- Fixed an issue with fromJson tear-offs not allowing `Object?` as map value. (#520)
- Optimized the generated implementation of `hashCode` and `==`
- Fixed an issue when `MyClass<Object>()` and `MyClass<int>()` could be considered equal
- Require Dart SDK >=2.14.0.

## 0.14.5

- fixed a bug when using alias imports, potentially using the prefix on every variables.
- When `@Freezed(fallback: '...')` is specified and using `fromJson`, now
  support cases where the JSON does not contain the "key".

## 0.14.4

- Now supports types coming from `import '...' as alias;`
- generated .freezed.dart are now excluded from code coverage reports.
- if `toString` is overridden, Freezed no-longer applies `Diagnosticable` which would break the `toString` (fixes #221)
- Add `union.whenOrNull` and `union.mapOrNull`, similar to `maybeWhen` and `maybeMap`
  but instead of an `orElse` they return `null`.

## 0.14.3

- Upgraded to support json_serializable 5.0.0
- `fromJson` now throws `CheckedFromJsonException` if it fails to deserialize an object.
- fixed an issue where optional dynamic keys were not allowed.

## 0.14.2

- Added the ability to specify a fallback constructor when deserializing unions (thanks to @Brazol)

## 0.14.1+3

Upgrade dependencies

## 0.14.1+2

Fixed examples in the README

## 0.14.1+1

- Fixed issues with recursive Freezed classes that could cause the parameter type to be inferred as `dynamic` (see #399)
- Updated `build` and other similar dependencies to latest

## 0.14.1

- Added the ability to customise the JSON value of a union. See https://github.com/rrousselGit/freezed#fromjson---classes-with-multiple-constructors for more information (Thanks to @ookami-kb)

- Fix an issue where Freezed would not generate code properly if `freezed_annotation`
  was indirectly imported (by importing a library that exports `freezed_annotation`) (Thanks to @ookami-kb)

## 0.14.0+2

- Fix `@Assert` no-longer working
- Fixed an issue where a `factory` using the `=>` syntax (so not managed by Freezed)
  with default values could break code-generation.

## 0.14.0+1

- fix `sort_unnamed_constructors_first` and `cast_nullable_to_non_nullable` in the generated code (Thanks to @gaetschwartz #372)

## 0.14.0

- Stable null-safety release
- Upgraded `analyzer` to support latest versions
- Freezed classes no-longer need to be abstract.  
  Before:

  ```dart
  @freezed
  abstract class Example with _$Example {
    factory Example(int value) = _Example;
  }
  ```

  after:

  ```dart
  @freezed
  class Example with _$Example {
    factory Example(int value) = _Example;
  }
  ```

  This leads to better error messages when a Freezed class uses interfaces/mixins
  but the class is missing a specific property.

- It is now allowed to add unimplemented getter to Freezed classes.
  This can be useful to guarantee that union-types all have a common property:

  ```dart
  @freezed
  class Union with _$Union {
    const factory Union.left(int value) = _Left;
    const factory Union.right(int value) = _Left;

    @override
    int get value; // adding this forces all union cases to possess a `value` property
  }
  ```

- Excluded getters and late variables from the generated `toString` as they could potentially cause a StackOverflow
- Fixed a bug causing properties with annotations to generate the annotations _before_
  the `required keyword, leading to a compilation error (see #351).

## 0.14.0-nullsafety.1

- Upgraded `analyzer` to support latest versions

## 0.14.0-nullsafety.0

- Freezed classes no-longer need to be abstract.  
  Before:

  ```dart
  @freezed
  abstract class Example with _$Example {
    factory Example(int value) = _Example;
  }
  ```

  after:

  ```dart
  @freezed
  class Example with _$Example {
    factory Example(int value) = _Example;
  }
  ```

  This leads to better error messages when a Freezed class uses interfaces/mixins
  but the class is missing a specific property.

- It is now allowed to add unimplemented getter to Freezed classes.
  This can be useful to guarantee that union-types all have a common property:

  ```dart
  @freezed
  class Union with _$Union {
    const factory Union.left(int value) = _Left;
    const factory Union.right(int value) = _Left;

    @override
    int get value; // adding this forces all union cases to possess a `value` property
  }
  ```

## 0.13.0-nullsafety.2

- Excluded getters and late variables from the generated `toString` as they could potentially cause a StackOverflow

## 0.13.0-nullsafety.1

- Fixed a bug causing properties with annotations to generate the annotations _before_
  the `required keyword, leading to a compilation error (see #351).

## 0.13.0-nullsafety.0

Migrated to null safety

## 0.12.7

- fixed a bug where `///` above a constructor could cause the generation to stop working (see also https://github.com/rrousselGit/freezed/issues/326)

## 0.12.6

- Fix Freezed generating code from constructors that do not rely on Freezed (https://github.com/rrousselGit/freezed/issues/323)

## 0.12.5

- Fixes a bug where comments on named parameters could break generation (https://github.com/rrousselGit/freezed/issues/317)

## 0.12.4

- fixed a bug that caused the code-generation to never complete (https://github.com/rrousselGit/freezed/issues/312)

## 0.12.3

- Renamed `Result` in generated code to `TResult` to avoid naming conflicts
- Fixes `InconsistentAnalysisException` sometimes being thrown (https://github.com/rrousselGit/freezed/issues/294)

## 0.12.3-dev

- Renamed `Result` in generated code to `TResult` to avoid naming conflicts
- Fixes `InconsistentAnalysisException` sometimes being thrown (https://github.com/rrousselGit/freezed/issues/294)

## 0.12.2

- Upgrade the dependencies (analyzer, build_runner)
- fixed a bug where a custom `fromJson` constructor still generated the `fromJson`
  constructor with json_serializable
  (see also https://github.com/rrousselGit/freezed/issues/280)
- fixed a generation issue when `unionKey` contains special characters
  (see also https://github.com/rrousselGit/freezed/issues/274)

## 0.12.1

- Removed dependency on `_fe_analyzer_shared`

## 0.12.0

- Added `/// @nodoc` on objects generated by Freezed that starts with `$`
  to not pollute dartdoc.

- Added support for documenting properties, by documenting the constructor parameters:

  ```dart
  @freezed
  abstract class Example with _$Example {
    const factory Example(
      /// Some documentation
      String parameter,
    ) = Person;
  }
  ```

- Added `Assert` decorator to generate `assert(...)` statements on Freezed classes:

  ```dart
  @freezed
  abstract class Person with _$Person {
    @Assert('name.trim().isNotEmpty', 'name cannot be empty')
    @Assert('age >= 0')
    factory Person({
      String name,
      int age,
    }) = _Person;
  }
  ```

- Now generates a constructor tear-off for `fromJson` too:

  ```dart
  @freezed
  abstract class Person with _$Person {
    factory Person({ String name, int age}) = _Person;

    factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  }

  List<Map<String, dynamic>> list;

  List<MyClass> persons = list.map($Person.fromJson).toList();
  ```

- Added a way to customize the de/serialization of union types using the
  `@Freezed(unionKey: 'my-key')` decorator.

  See also https://github.com/rrousselGit/freezed#fromjson---classes-with-multiple-constructors

## 0.11.6

- Fixed a bug where deep-copy did not work properly for recursive classes (https://github.com/rrousselGit/freezed/issues/213)

- Fixed a situation where `@late` properties could trigger a `RangeError` (https://github.com/rrousselGit/freezed/issues/219)

## 0.11.5

- Fixed a bug in which case Freezed generated an invalid `copyWith` implementation

## 0.11.4

- No-longer generate `when`/... for private constructors.

## 0.11.3

- Fixed a bug where the generated class incorrectly used `Diagnosticable` event if `package:flutter/foundation` wasn't imported. (Thanks to @avbk)

## 0.11.2

- Generate `when`/`map`/... even for classes with a single constructors (thanks @andrzejchm)

## 0.11.1

- Further improve the parsing of recursive freezed class to avoid `dynamic`s

## 0.11.0

- Added `@With` and `@Implements` decorators to allow only a specific constructor
  of a union type to implement an interface:

  ```dart
  @freezed
  abstract class Example with _$Example {
    const factory Example.person(String name, int age) = Person;

    @Implements(GeographicArea)
    const factory Example.city(String name, int population) = City;
  }
  ```

  Thanks to @long1eu

- Fixed a bug where a recursive freezed class may generate a property as dynamic (thanks to @maks)

- Improved the readme (Thanks to @scopendo and @Matsue)

## 0.10.9

- Fixes a bug where code-generation could end-up in a Stack Overflow if a class depends on itself

## 0.10.8

- Fix code-generation issue for deep-copy of generic objects (https://github.com/rrousselGit/freezed/issues/128)

## 0.10.7

- Fixes a bug where classes with both getters and consts constructors caused an exception. (https://github.com/rrousselGit/freezed/issues/142)

## 0.10.6

- do not create `@required` annotation for positional arguments on `when`/`map` functions (thanks to @hpoul)
- Fix == returning false for classes with "other" prop (thanks to @mhmdanas)

## 0.10.5

Fixes classes with getters and a private `MyClass._()` constructor not properly generating.

## 0.10.4

Fixed Freezed trying to generate code for factory constructors with a complex body.

## 0.10.3

- Fixes Freezed trying to generate code for files that don't use it

## 0.10.2

- Fixes a bug where deep copy did not compile if the class definitions were
  spread on multiple files.

## 0.10.1

- Fixed a stack-overflow during generation on recursive classes
- Fixed invalid generated code for classes with a concrete constructor + using Diagnosticable

## 0.10.0

- Consider optional parameters with a default value as non-nullable
- Add deep-copy support
- Allow the class to define methods/getters
- Do not override `toString` if the user-defined class already overrides `toString`

## 0.9.2

Fixes parsing of recursive classes

## 0.9.1

Support enum and static const default values

## 0.9.0

Support class-level decorators (see https://github.com/rrousselGit/freezed/issues/50)

## 0.8.2

Generated file now ignores `invalid_override_different_default_values_named`

## 0.8.0

Now also generate constructor tear-off.

## 0.7.3

Fixes `@Default` generating invalid code if the default value explicitly used `const`.

## 0.7.2

Fix null/bool default value support

## 0.7.1

Fixes a bug where `@Default` only worked with strings/numbers/functions/types.

## 0.7.0

Add support for default values

## 0.6.3

- Make `freezed` ignore `use_function_type_syntax_for_parameters` warnings (see https://github.com/rrousselGit/freezed/issues/57)

## 0.6.2

- Fixes an issue with inconsistent `hashCode` when using collections
- Fixes a parsing bug with complex concrete factory constructors.

## 0.6.1

Fixed a bug where `@late` could incorrectly parse the getter

## 0.6.0

Add support for cached getters using `@late`.

## 0.5.1

- Document `@nullable`
- fix a bug where static members where not allows (thanks @knaeckeKami)

## 0.5.0

The generated == now works with collections too.

If a class created has a List/Map/Set/Iterable, then the == will deeply compare these
instead of comparing their reference.

## 0.4.0

Automatically generate `assert(property != null)` on both constructors and `copyWith`
methods.\
This also adds a `@nullable` decorator to disable this assertion.

## 0.3.0

Now use a custom `@freezed` annotation instead of `@immutable`.

## 0.2.5

Fixed a bug where generic json deserialization didn't apply generic parameters (https://github.com/rrousselGit/freezed/issues/32)

## 0.2.4

Make the generated interface a mixin to fix `prefer_mixin` lints (https://github.com/rrousselGit/freezed/issues/28)

## 0.2.3

Fixes a bug where constructors with generic parameters caused the parsing of the
redirected constructor to fail. (https://github.com/rrousselGit/freezed/issues/25)

## 0.2.2

Fixes a bug where the code would not compile if a property had the same name as a
named constructor.

## 0.2.1

Fixes a bug where classes with a single constructor + fromJson did not generate
properties/copyWith.

## 0.2.0

Transfer all parameters decorators to the generated properties.

## 0.1.4

- Fixed a bug where `map`/`maybeMap` on generic classes didn't pass the generic parameters.

## 0.1.3+1

- Fix README's index

## 0.1.3

- Don't generate anything for factory constructors with a body.
  (https://github.com/rrousselGit/freezed/issues/9)

## 0.1.2

- `fromJson`/`toJson` no longer require/add a `runtimeType` key for classes with a
  single constructor. (https://github.com/rrousselGit/freezed/issues/7)

- don't generate anything for classes that add `@freezed` but define real properties
  (https://github.com/rrousselGit/freezed/issues/5)

## 0.1.1

Upgrade min range of `analyzer` dependency

## 0.1.0

Add support for `json_serializable`

## 0.0.2

Implicitly generate `debugFillProperties` if the necessary classes are imported.

## 0.0.1

Add generic support

## 0.0.0

Initial release
