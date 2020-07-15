# 0.11.3

- Fixed a bug where the generated class incorrectly used `Diagnosticable` event if `package:flutter/foundation` wasn't imported. (Thanks to @avbk)

# 0.11.2

- Generate `when`/`map`/... even for classes with a single constructors (thanks @andrzejchm)

# 0.11.1

- Further improve the parsing of recursive freezed class to avoid `dynamic`s

# 0.11.0

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

# 0.10.9

- Fixes a bug where code-generation could end-up in a Stack Overflow if a class depends on itself

# 0.10.8

- Fix code-generation issue for deep-copy of generic objects (https://github.com/rrousselGit/freezed/issues/128)

# 0.10.7

- Fixes a bug where classes with both getters and consts constructors caused an exception. (https://github.com/rrousselGit/freezed/issues/142)

# 0.10.6

- do not create `@required` annotation for positional arguments on `when`/`map` functions (thanks to @hpoul)
- Fix == returning false for classes with "other" prop (thanks to @mhmdanas)

# 0.10.5

Fixes classes with getters and a private `MyClass._()` constructor not properly generating.

# 0.10.4

Fixed Freezed trying to generate code for factory constructors with a complex body.

# 0.10.3

- Fixes Freezed trying to generate code for files that don't use it

# 0.10.2

- Fixes a bug where deep copy did not compile if the class definitions were
  spread on multiple files.

# 0.10.1

- Fixed a stack-overflow during generation on recursive classes
- Fixed invalid generated code for classes with a concrete constructor + using Diagnosticable

# 0.10.0

- Consider optional parameters with a default value as non-nullable
- Add deep-copy support
- Allow the class to define methods/getters
- Do not override `toString` if the user-defined class already overrides `toString`

# 0.9.2

Fixes parsing of recursive classes

# 0.9.1

Support enum and static const default values

# 0.9.0

Support class-level decorators (see https://github.com/rrousselGit/freezed/issues/50)

# 0.8.2

Generated file now ignores `invalid_override_different_default_values_named`

# 0.8.0

Now also generate constructor tear-off.

# 0.7.3

Fixes `@Default` generating invalid code if the default value explicitly used `const`.

# 0.7.2

Fix null/bool default value support

# 0.7.1

Fixes a bug where `@Default` only worked with strings/numbers/functions/types.

# 0.7.0

Add support for default values

# 0.6.3

- Make `freezed` ignore `use_function_type_syntax_for_parameters` warnings (see https://github.com/rrousselGit/freezed/issues/57)

# 0.6.2

- Fixes an issue with inconsistent `hashCode` when using collections
- Fixes a parsing bug with complex concrete factory constructors.

# 0.6.1

Fixed a bug where `@late` could incorrectly parse the getter

# 0.6.0

Add support for cached getters using `@late`.

# 0.5.1

- Document `@nullable`
- fix a bug where static members where not allows (thanks @knaeckeKami)

# 0.5.0

The generated == now works with collections too.

If a class created has a List/Map/Set/Iterable, then the == will deeply compare these
instead of comparing their reference.

# 0.4.0

Automatically generate `assert(property != null)` on both constructors and `copyWith`
methods.\
This also adds a `@nullable` decorator to disable this assertion.

# 0.3.0

Now use a custom `@freezed` annotation instead of `@immutable`.

# 0.2.5

Fixed a bug where generic json deserialization didn't apply generic parameters (https://github.com/rrousselGit/freezed/issues/32)

# 0.2.4

Make the generated interface a mixin to fix `prefer_mixin` lints (https://github.com/rrousselGit/freezed/issues/28)

# 0.2.3

Fixes a bug where constructors with generic parameters caused the parsing of the
redirected constructor to fail. (https://github.com/rrousselGit/freezed/issues/25)

# 0.2.2

Fixes a bug where the code would not compile if a property had the same name as a
named constructor.

# 0.2.1

Fixes a bug where classes with a single constructor + fromJson did not generate
properties/copyWith.

# 0.2.0

Transfer all parameters decorators to the generated properties.

# 0.1.4

- Fixed a bug where `map`/`maybeMap` on generic classes didn't pass the generic parameters.

# 0.1.3+1

- Fix README's index

# 0.1.3

- Don't generate anything for factory constructors with a body.
  (https://github.com/rrousselGit/freezed/issues/9)

# 0.1.2

- `fromJson`/`toJson` no longer require/add a `runtimeType` key for classes with a
  single constructor. (https://github.com/rrousselGit/freezed/issues/7)

- don't generate anything for classes that add `@freezed` but define real properties
  (https://github.com/rrousselGit/freezed/issues/5)

# 0.1.1

Upgrade min range of `analyzer` dependency

# 0.1.0

Add support for `json_serializable`

# 0.0.2

Implicitly generate `debugFillProperties` if the necessary classes are imported.

# 0.0.1

Add generic support

# 0.0.0

Initial release
