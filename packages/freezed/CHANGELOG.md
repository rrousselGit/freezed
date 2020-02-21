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
