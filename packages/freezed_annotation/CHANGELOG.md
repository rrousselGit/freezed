# [Unreleased]

- Added `Assert` decorator to generate `assert(...)` statements on Freezed classes:

  ```dart
  abstract class Person with _$Person {
    @Assert('name.trim().isNotEmpty', 'name cannot be empty')
    @Assert('age >= 0')
    factory Person({
      String name,
      int age,
    }) = _Person;
  }
  ```

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

  Thanks to @long1eu~

# 0.7.1

Minor change to `@Default` to fix an issue with complex default values.

# 0.7.0

Add `@Default` annotation

# 0.6.0

Added `@late` annotation.

# 0.4.0

Added a `@nullable` annotation.

# 0.3.1

Change version of `collection` to work with `flutter_test`.

# 0.3.0

Initial release of the annotation package.
