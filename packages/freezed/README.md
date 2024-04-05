[English](https://github.com/rrousselGit/freezed/blob/master/packages/freezed/README.md) | [한국어](https://github.com/rrousselGit/freezed/blob/master/resources/translations/ko_KR/README.md) | [简体中文](https://github.com/rrousselGit/freezed/blob/master/resources/translations/zh_CN/README.md)

![Build](https://github.com/rrousselGit/freezed/workflows/Build/badge.svg)
[![pub package](https://img.shields.io/pub/v/freezed.svg)](https://pub.dartlang.org/packages/freezed)
<a href="https://discord.gg/Bbumvej"><img src="https://img.shields.io/discord/765557403865186374.svg?logo=discord&color=blue" alt="Discord"></a>

[<img src="https://raw.githubusercontent.com/rrousselGit/provider/master/resources/flutter_favorite.png" width="200" />](https://flutter.dev/docs/development/packages-and-plugins/favorites)

Welcome to [Freezed], yet another code generator for data-classes/unions/pattern-matching/cloning.

# Motivation

Dart is awesome, but defining a "model" can be tedious. We may have to:

- define a constructor + the properties
- override `toString`, `operator ==`, `hashCode`
- implement a `copyWith` method to clone the object
- handling de/serialization

Implementing all of this can take hundreds of lines, which are error-prone
and affect the readability of your model significantly.

Freezed tries to fix that by implementing most of this for you, allowing you
to focus on the definition of your model.

| Before                                                                                       | After                                                                                       |
| -------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| ![before](https://raw.githubusercontent.com/rrousselGit/freezed/master/resources/before.png) | ![before](https://raw.githubusercontent.com/rrousselGit/freezed/master/resources/after.png) |

# Index

- [Motivation](#motivation)
- [Index](#index)
- [How to use](#how-to-use)
  - [Install](#install)
    - [Disabling invalid\_annotation\_target warning and warning in generates files.](#disabling-invalid_annotation_target-warning-and-warning-in-generates-files)
  - [Run the generator](#run-the-generator)
  - [Creating a Model using Freezed](#creating-a-model-using-freezed)
    - [Defining a mutable class instead of an immutable one](#defining-a-mutable-class-instead-of-an-immutable-one)
    - [Allowing the mutation of Lists/Maps/Sets](#allowing-the-mutation-of-listsmapssets)
    - [How copyWith works](#how-copywith-works)
    - [Going further: Deep copy](#going-further-deep-copy)
    - [Adding getters and methods to our models](#adding-getters-and-methods-to-our-models)
    - [Asserts](#asserts)
    - [Default values](#default-values)
    - [Decorators and comments](#decorators-and-comments)
    - [Mixins and Interfaces for individual classes for union types](#mixins-and-interfaces-for-individual-classes-for-union-types)
  - [FromJson/ToJson](#fromjsontojson)
    - [fromJSON - classes with multiple constructors](#fromjson---classes-with-multiple-constructors)
    - [Deserializing generic classes](#deserializing-generic-classes)
  - [(Legacy) Union types and Sealed classes](#legacy-union-types-and-sealed-classes)
    - [Shared properties](#shared-properties)
    - [Using pattern matching to read non-shared properties](#using-pattern-matching-to-read-non-shared-properties)
      - [When](#when)
      - [Map](#map)
  - [Configurations](#configurations)
    - [Changing the behavior for a specific model](#changing-the-behavior-for-a-specific-model)
    - [Changing the behavior for the entire project](#changing-the-behavior-for-the-entire-project)
- [Utilities](#utilities)
    - [Freezed extension for VSCode](#freezed-extension-for-vscode)
    - [Freezed extension for IntelliJ/Android Studio](#freezed-extension-for-intellijandroid-studio)
  - [Third-party tools](#third-party-tools)
    - [DartJ](#dartj)
  - [Sponsors](#sponsors)

# How to use

## Install

To use [Freezed], you will need your typical [build_runner]/code-generator setup.\
First, install [build_runner] and [Freezed] by adding them to your `pubspec.yaml` file:

For a Flutter project:

```console
flutter pub add freezed_annotation
flutter pub add dev:build_runner
flutter pub add dev:freezed
# if using freezed to generate fromJson/toJson, also add:
flutter pub add json_annotation
flutter pub add dev:json_serializable
```

For a Dart project:

```console
dart pub add freezed_annotation
dart pub add dev:build_runner
dart pub add dev:freezed
# if using freezed to generate fromJson/toJson, also add:
dart pub add json_annotation
dart pub add dev:json_serializable
```

This installs three packages:

- [build_runner](https://pub.dev/packages/build_runner), the tool to run code-generators
- [freezed], the code generator
- [freezed_annotation](https://pub.dev/packages/freezed_annotation), a package containing annotations for [freezed].

### Disabling invalid_annotation_target warning and warning in generates files.

If you plan on using [Freezed] in combination with `json_serializable`, recent
versions of `json_serializable` and `meta` may require you to disable the
`invalid_annotation_target` warning.

To do that, you can add the following to the `analysis_options.yaml` file
at the root of your project:

```yaml
analyzer:
  errors:
    invalid_annotation_target: ignore
```

## Run the generator

To run the code generator, execute the following command:

```
dart run build_runner build
```

Note that like most code-generators, [Freezed] will need you to both import the annotation ([freezed_annotation])
and use the `part` keyword on the top of your files.

As such, a file that wants to use [Freezed] will start with:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_file.freezed.dart';

```

**CONSIDER** also importing `package:flutter/foundation.dart`.\
The reason being, importing `foundation.dart` also imports classes to make an
object nicely readable in Flutter's devtool.\
If you import `foundation.dart`, [Freezed] will automatically do it for you.

## Creating a Model using Freezed

An example is better than a long abstract explanation, so here's a typical Freezed class:

```dart
// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'main.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'main.g.dart';

@freezed
class Person with _$Person {
  const factory Person({
    required String firstName,
    required String lastName,
    required int age,
  }) = _Person;

  factory Person.fromJson(Map<String, Object?> json)
      => _$PersonFromJson(json);
}
```

The following snippet defines a model named `Person`:

- `Person` has 3 properties: `firstName`, `lastName` and `age`
- Because we are using `@freezed`, all of this class's properties are immutable.
- Since we defined a `fromJson`, this class is de/serializable.
  Freezed will add a `toJson` method for us.
- Freezed will also automatically generate:
  - a `copyWith` method, for cloning the object with different properties
  - a `toString` override listing all the properties of the object
  - an `operator ==` and `hashCode` override (since `Person` is immutable)

From this example, we can notice a few things:

- It is necessary to annotate our model with `@freezed` (or `@Freezed`/`@unfreezed`, more about that later).  
  This annotation is what tells Freezed to generate code for that class.

- We must also apply a mixin with the name of our class, prefixed by `_$`.
  This mixin is what defines the various properties/methods of our object.

- When defining a constructor in a Freezed class, we should use the `factory` keyword
  as showcased (`const` is optional).  
  The parameters of this constructor will be the list of all properties that this class contains.  
  Parameters **don't** have to be named and required. Feel free to use
  positional optional parameters if you want!

### Defining a mutable class instead of an immutable one

So far, we've seen how to define a model where all of its properties are `final`;
but you may want to define mutable properties in your model.

Freezed supports this, by replacing the `@freezed` annotation with `@unfreezed`:

```dart
@unfreezed
class Person with _$Person {
  factory Person({
    required String firstName,
    required String lastName,
    required final int age,
  }) = _Person;

  factory Person.fromJson(Map<String, Object?> json)
      => _$PersonFromJson(json);
}
```

This defines a model mostly identical to our previous snippets, but with the following
differences:

- `firstName` and `lastName` are now mutable. As such, we can write:

  ```dart
  void main() {
    var person = Person(firstName: 'John', lastName: 'Smith', age: 42);

    person.firstName = 'Mona';
    person.lastName = 'Lisa';
  }
  ```

- `age` is still immutable, because we explicitly marked the property as `final`.
- `Person` no-longer has a custom ==/hashCode implementation:

  ```dart
  void main() {
    var john = Person(firstName: 'John', lastName: 'Smith', age: 42);
    var john2 = Person(firstName: 'John', lastName: 'Smith', age: 42);

    print(john == john2); // false
  }
  ```

- Of course, since our `Person` class is mutable, it is no-longer possible
  to instantiate it using `const`.

### Allowing the mutation of Lists/Maps/Sets

By default when using `@freezed` (but not `@unfreezed`), properties of type `List`/`Map`/`Set`
are transformed to be immutable.

This means that writing the following will cause a runtime exception:

```dart
@freezed
class Example with _$Example {
  factory Example(List<int> list) = _Example;
}

void main() {
  var example = Example([]);
  example.list.add(42); // throws because we are mutating a collection
}
```

That behavior can be disabled by writing:

```dart
@Freezed(makeCollectionsUnmodifiable: false)
class Example with _$Example {
  factory Example(List<int> list) = _Example;
}

void main() {
  var example = Example([]);
  example.list.add(42); // OK
}
```

### How copyWith works

As explained before, when defining a model using Freezed, then the code-generator
will automatically generate a `copyWith` method for us.  
This method is used to clone an object with different values.

For example if we define:

```dart
@freezed
class Person with _$Person {
  factory Person(String name, int? age) = _Person;
}
```

Then we could write:

```dart
void main() {
  var person = Person('Remi', 24);

  // `age` not passed, its value is preserved
  print(person.copyWith(name: 'Dash')); // Person(name: Dash, age: 24)
  // `age` is set to `null`
  print(person.copyWith(age: null)); // Person(name: Remi, age: null)
}
```

Notice Freezed supports `person.copyWith(age: null)`.

### Going further: Deep copy

While `copyWith` is very powerful in itself, it becomes inconvenient on more complex objects.

Consider the following classes:

```dart
@freezed
class Company with _$Company {
  factory Company({String? name, required Director director}) = _Company;
}

@freezed
class Director with _$Director {
  factory Director({String? name, Assistant? assistant}) = _Director;
}

@freezed
class Assistant with _$Assistant {
  factory Assistant({String? name, int? age}) = _Assistant;
}
```

Then, from a reference on `Company`, we may want to perform changes on `Assistant`.\
For example, to change the `name` of an assistant, using `copyWith` we would have to write:

```dart
Company company;

Company newCompany = company.copyWith(
  director: company.director.copyWith(
    assistant: company.director.assistant.copyWith(
      name: 'John Smith',
    ),
  ),
);
```

This _works_, but is relatively verbose with a lot of duplicates.\
This is where we could use [Freezed]'s "deep copy".

If a Freezed model contains properties that are also Freezed models, then
the code-generator will offer an alternate syntax to the previous example:

```dart
Company company;

Company newCompany = company.copyWith.director.assistant(name: 'John Smith');
```

This snippet will achieve strictly the same result as the previous snippet
(creating a new company with an updated assistant name), but no longer has duplicates.

Going deeper in this syntax, if instead, we wanted to change the director's name
then we could write:

```dart
Company company;
Company newCompany = company.copyWith.director(name: 'John Doe');
```

Overall, based on the definitions of `Company`/`Director`/`Assistant` mentioned above,
all the following "copy" syntaxes will work:

```dart
Company company;

company = company.copyWith(name: 'Google', director: Director(...));
company = company.copyWith.director(name: 'Larry', assistant: Assistant(...));
```

**Null consideration**

Some objects may also be `null`. For example, using our `Company` class,
then `Director`'s `assistant` may be `null`.

As such, writing:

```dart
Company company = Company(name: 'Google', director: Director(assistant: null));
Company newCompany = company.copyWith.director.assistant(name: 'John');
```

doesn't make sense.  
We can't change the assistant's name if there is no assistant to begin with.

In that situation, `company.copyWith.director.assistant` will return `null`,
causing our code to fail to compile.

To fix it, we can use the `?.call` operator and write:

```dart
Company? newCompany = company.copyWith.director.assistant?.call(name: 'John');
```

### Adding getters and methods to our models

Sometimes, you may want to manually define methods/properties in our classes.  
But you will quickly notice that if you try to do:

```dart
@freezed
class Person with _$Person {
  const factory Person(String name, {int? age}) = _Person;

  void method() {
    print('hello world');
  }
}
```

then it won't work.

For that to work, we need an extra step: We need to define a private empty constructor:

```dart
@freezed
class Person with _$Person {
  // Added constructor. Must not have any parameter
  const Person._();

  const factory Person(String name, {int? age}) = _Person;

  void method() {
    print('hello world');
  }
}
```

### Asserts

Dart does not allow adding `assert(...)` statements to a `factory` constructor.  
As such, to add asserts to your Freezed classes, you will need the `@Assert` decorator:

```dart
class Person with _$Person {
  @Assert('name.isNotEmpty', 'name cannot be empty')
  @Assert('age >= 0')
  factory Person({
    String? name,
    int? age,
  }) = _Person;
}
```

### Default values

Similarly to asserts, Dart does not allow "redirecting factory constructors"
to specify default values.

As such, if you want to specify default values for your properties,
you will need the `@Default` annotation:

```dart
class Example with _$Example {
  const factory Example([@Default(42) int value]) = _Example;
}
```

**NOTE**:\
If you are using serialization/deserialization, this will automatically add
a `@JsonKey(defaultValue: <something>)` for you.

### Decorators and comments

[Freezed] supports property and class level decorators/documentation by
decorating/documenting their respective parameter and constructor definition.

Consider:

```dart
@freezed
class Person with _$Person {
  const factory Person({
    String? name,
    int? age,
    Gender? gender,
  }) = _Person;
}
```

If you want to document `name`, you can do:

```dart
@freezed
class Person with _$Person {
  const factory Person({
    /// The name of the user.
    ///
    /// Must not be null
    String? name,
    int? age,
    Gender? gender,
  }) = _Person;
}
```

If you want to mark the property `gender` as `@deprecated`, then you can do:

```dart
@freezed
class Person with _$Person {
  const factory Person({
    String? name,
    int? age,
    @deprecated Gender? gender,
  }) = _Person;
}
```

This will deprecate both:

- The constructor
  ```dart
  Person(gender: Gender.something); // gender is deprecated
  ```
- The generated class's constructor:
  ```dart
  _Person(gender: Gender.something); // gender is deprecated
  ```
- the property:
  ```dart
  Person person;
  print(person.gender); // gender is deprecated
  ```
- the `copyWith` parameter:
  ```dart
  Person person;
  person.copyWith(gender: Gender.something); // gender is deprecated
  ```

Similarly, if you want to decorate the generated class you can decorate the
defining factory constructor.

As such, to deprecate `_Person`, you could do:

```dart
@freezed
class Person with _$Person {
  @deprecated
  const factory Person({
    String? name,
    int? age,
    Gender? gender,
  }) = _Person;
}
```

### Mixins and Interfaces for individual classes for union types

When you have multiple types in the same class you might want one of those
types to implement an interface or mixin a class. You can do that using the
`@Implements` or `@With` decorators respectively. In the following example
`City` implements `GeographicArea`.

```dart
abstract class GeographicArea {
  int get population;
  String get name;
}

@freezed
sealed class Example with _$Example {
  const factory Example.person(String name, int age) = Person;

  @Implements<GeographicArea>()
  const factory Example.city(String name, int population) = City;
}
```

This also works for implementing or mixing in generic classes e.g.
`AdministrativeArea<House>` except when the class has a generic type parameter
e.g. `AdministrativeArea<T>`. In this case freezed will generate correct code
but dart will throw a load error on the annotation declaration when compiling.
To avoid this you should use the `@Implements.fromString` and
`@With.fromString` decorators as follows:

```dart
abstract class GeographicArea {}
abstract class House {}
abstract class Shop {}
abstract class AdministrativeArea<T> {}

@freezed
sealed class Example<T> with _$Example<T> {
  const factory Example.person(String name, int age) = Person<T>;

  @With.fromString('AdministrativeArea<T>')
  const factory Example.street(String name) = Street<T>;

  @With<House>()
  @Implements<Shop>()
  @Implements<GeographicArea>()
  @Implements.fromString('AdministrativeArea<T>')
  const factory Example.city(String name, int population) = City<T>;
}
```

**Note**: You need to make sure that you comply with the interface
requirements by implementing all the abstract members. If the interface
has no members or just fields, you can fulfill the interface contract by
adding them to the union type's constructor. Keep in mind that if
the interface defines a method or a getter, that you implement in the
class, you need to use the
[Adding getters and methods to our models](#adding-getters-and-methods-to-our-models) instructions.

**Note 2**: You cannot use `@With`/`@Implements` with freezed classes.
Freezed classes can neither be extended nor implemented.

## FromJson/ToJson

While [Freezed] will not generate your typical `fromJson`/`toJson` by itself, it knows
what [json_serializable] is.

Making a class compatible with [json_serializable] is very straightforward.

Consider this snippet:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

@freezed
sealed class Model with _$Model {
  factory Model.first(String a) = First;
  factory Model.second(int b, bool c) = Second;
}
```

The changes necessary to make it compatible with [json_serializable] consists of two lines:

- a new `part`: `part 'model.g.dart';`
- a new constructor on the targeted class: `factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);`

The end result is:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
sealed class Model with _$Model {
  factory Model.first(String a) = First;
  factory Model.second(int b, bool c) = Second;

  factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);
}
```

Don't forget to add `json_serializable` to your `pubspec.yaml` file:

```yaml
dev_dependencies:
  json_serializable:
```

That's it!\
With these changes, [Freezed] will automatically ask [json_serializable] to generate all the necessary
`fromJson`/`toJson`.

**Note**:  
Freezed will only generate a fromJson if the factory is using `=>`.

### fromJSON - classes with multiple constructors

For classes with multiple constructors, [Freezed] will check the JSON response
for a string element called `runtimeType` and choose the constructor to use based
on its value. For example, given the following constructors:

```dart
@freezed
sealed class MyResponse with _$MyResponse {
  const factory MyResponse(String a) = MyResponseData;
  const factory MyResponse.special(String a, int b) = MyResponseSpecial;
  const factory MyResponse.error(String message) = MyResponseError;

  factory MyResponse.fromJson(Map<String, dynamic> json) => _$MyResponseFromJson(json);
}
```

Then [Freezed] will use each JSON object's `runtimeType` to choose the constructor as follows:

```json
[
  {
    "runtimeType": "default",
    "a": "This JSON object will use constructor MyResponse()"
  },
  {
    "runtimeType": "special",
    "a": "This JSON object will use constructor MyResponse.special()",
    "b": 42
  },
  {
    "runtimeType": "error",
    "message": "This JSON object will use constructor MyResponse.error()"
  }
]
```

You can customize key and value with something different
using `@Freezed` and `@FreezedUnionValue` decorators:

```dart
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.pascal)
sealed class MyResponse with _$MyResponse {
  const factory MyResponse(String a) = MyResponseData;

  @FreezedUnionValue('SpecialCase')
  const factory MyResponse.special(String a, int b) = MyResponseSpecial;

  const factory MyResponse.error(String message) = MyResponseError;

  // ...
}
```

which would update the previous json to:

```json
[
  {
    "type": "Default",
    "a": "This JSON object will use constructor MyResponse()"
  },
  {
    "type": "SpecialCase",
    "a": "This JSON object will use constructor MyResponse.special()",
    "b": 42
  },
  {
    "type": "Error",
    "message": "This JSON object will use constructor MyResponse.error()"
  }
]
```

If you want to customize key and value for all the classes, you can specify it inside your
`build.yaml` file, for example:

```yaml
targets:
  $default:
    builders:
      freezed:
        options:
          union_key: type
          union_value_case: pascal
```

If you don't control the JSON response, then you can implement a custom converter.
Your custom converter will need to implement its own logic for determining which
constructor to use.

```dart
class MyResponseConverter implements JsonConverter<MyResponse, Map<String, dynamic>> {
  const MyResponseConverter();

  @override
  MyResponse fromJson(Map<String, dynamic> json) {
    // type data was already set (e.g. because we serialized it ourselves)
    if (json['runtimeType'] != null) {
      return MyResponse.fromJson(json);
    }
    // you need to find some condition to know which type it is. e.g. check the presence of some field in the json
    if (isTypeData) {
      return MyResponseData.fromJson(json);
    } else if (isTypeSpecial) {
      return MyResponseSpecial.fromJson(json);
    } else if (isTypeError) {
      return MyResponseError.fromJson(json);
    } else {
      throw Exception('Could not determine the constructor for mapping from JSON');
    }
 }

  @override
  Map<String, dynamic> toJson(MyResponse data) => data.toJson();
}
```

To then apply your custom converter pass the decorator to a constructor parameter.

```dart
@freezed
class MyModel with _$MyModel {
  const factory MyModel(@MyResponseConverter() MyResponse myResponse) = MyModelData;

  factory MyModel.fromJson(Map<String, dynamic> json) => _$MyModelFromJson(json);
}
```

By doing this, json serializable will use `MyResponseConverter.fromJson()` and `MyResponseConverter.toJson()` to convert `MyResponse`.

You can also use a custom converter on a constructor parameter contained in a `List`.

```dart
@freezed
class MyModel with _$MyModel {
  const factory MyModel(@MyResponseConverter() List<MyResponse> myResponse) = MyModelData;

  factory MyModel.fromJson(Map<String, dynamic> json) => _$MyModelFromJson(json);
}
```

**Note**:  
In order to serialize nested lists of freezed objects, you are supposed to either
specify a `@JsonSerializable(explicitToJson: true)` or change `explicit_to_json`
inside your `build.yaml` file ([see the documentation](https://github.com/google/json_serializable.dart/tree/master/json_serializable#build-configuration)).

### Deserializing generic classes

In order to de/serialize generic typed freezed objects, you can enable `genericArgumentFactories`.  
All you need to do is to change the signature of the `fromJson` method and add `genericArgumentFactories: true` to the freezed configuration.

```dart
@Freezed(genericArgumentFactories: true)
sealed class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse.data(T data) = ApiResponseData;
  const factory ApiResponse.error(String message) = ApiResponseError;

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) => _$ApiResponseFromJson(json, fromJsonT);
}
```

Alternatively, you can enable `genericArgumentFactories` for the whole project by modifying your `build.yaml` file to include the following:

```yaml
targets:
  $default:
    builders:
      freezed:
        options:
          generic_argument_factories: true
```

**What about `@JsonKey` annotation?**

All decorators passed to a constructor parameter are "copy-pasted" to the generated
property too.\
As such, you can write:

```dart
@freezed
class Example with _$Example {
  factory Example(@JsonKey(name: 'my_property') String myProperty) = _Example;

  factory Example.fromJson(Map<String, dynamic> json) => _$ExampleFromJson(json);
}
```

**What about `@JsonSerializable` annotation?**

You can pass `@JsonSerializable` annotation by placing it over constructor e.g.:

```dart
@freezed
class Example with _$Example {
  @JsonSerializable(explicitToJson: true)
  factory Example(@JsonKey(name: 'my_property') SomeOtherClass myProperty) = _Example;

  factory Example.fromJson(Map<String, dynamic> json) => _$ExampleFromJson(json);
}
```

If you want to define some custom json_serializable flags for all the classes (e.g. `explicit_to_json` or `any_map`) you can do it via `build.yaml` file as described [here](https://pub.dev/packages/json_serializable#build-configuration).

See also the [decorators](#decorators-and-comments) section

## (Legacy) Union types and Sealed classes

**Edit**: As of Dart 3, Dart now has built-in pattern-matching using sealed classes.  
As such, you no-longer need to rely on Freezed's generated methods for pattern
matching. Instead of using `when`/`map`, use the official Dart syntax.

The following docs are left unedited and kept for the Dart users who have yet to
migrate to Dart 3.  
But in the long term, you should stop relying on `when`/`map`.

---

Coming from other languages, you may be used to features like "union types"/"sealed classes"/pattern matching.  
These are powerful tools in combination with a type system, but Dart currently does not support them.

But fear not, [Freezed] supports them, generating a few utilities to help you with those.

Long story short, in any Freezed class, you can write multiple constructors:

```dart
@freezed
sealed class Union with _$Union {
  const factory Union.data(int value) = Data;
  const factory Union.loading() = Loading;
  const factory Union.error([String? message]) = Error;
}
```

By doing this, our model now can be in different mutually exclusive states.

In particular, this snippet defines a model `Union`, and that model has 3 possible states:

- data
- loading
- error

Note how we gave meaningful names to the right hand of the factory constructors we defined.
They will come in handy later.

One thing you may also notice is that with this example, then we can no-longer
write code such as:

```dart
void main() {
  Union union = Union.data(42);

  print(union.value); // compilation error: property value does not exist
}
```

Let's see why that is the case in the following section.

### Shared properties

When defining multiple constructors, you will lose the ability to read properties that are not common to all constructors:

For example, if you write:

```dart
@freezed
sealed class Example with _$Example {
  const factory Example.person(String name, int age) = Person;
  const factory Example.city(String name, int population) = City;
}
```

Then you will be unable to read `age` and `population` directly:

```dart
var example = Example.person('Remi', 24);
print(example.age); // does not compile!
```

On the other hand, you **can** read properties that are defined on all constructors.\
For example, the `name` variable is common to both `Example.person` and `Example.city` constructors.

As such we can write:

```dart
var example = Example.person('Remi', 24);
print(example.name); // Remi
example = Example.city('London', 8900000);
print(example.name); // London
```

The same logic can be applied to `copyWith` too.  
We can use `copyWith` with properties defined on all constructors:

```dart
var example = Example.person('Remi', 24);
print(example.copyWith(name: 'Dash')); // Example.person(name: Dash, age: 24)

example = Example.city('London', 8900000);
print(example.copyWith(name: 'Paris')); // Example.city(name: Paris, population: 8900000)
```

On the other hand, properties that are unique to a specific constructor aren't available:

```dart
var example = Example.person('Remi', 24);

example.copyWith(age: 42); // compilation error, parameter `age` does not exist
```

To solve this problem, we need check the state of our object using what we call "pattern matching".

### Using pattern matching to read non-shared properties

For this section, let's consider the following union:

```dart
@freezed
sealed class Example with _$Example {
  const factory Example.person(String name, int age) = Person;
  const factory Example.city(String name, int population) = City;
}
```

Let's see how we can use pattern matching to read the content of an `Example` instance.

For this, we have a few solutions:

- (preferred) Use Dart 3's built-in pattern matching using `switch`:
  ```dart
  switch (example) {
    Person(:final name) => print('Person $name'),
    City(:final population) => print('City ($population)'),
  }
  ```
- (legacy) If using Dart 2, you can use utilities ([when]/[map]) generated by Freezed to inspect the content of our object
- (discouraged) Using `is`/`as` to cast an `Example` variable into either a `Person` or a `City`

#### When

The [when] method is the equivalent to pattern matching with destructing.  
The prototype of the method depends on the constructors defined.

For example, with:

```dart
@freezed
sealed class Union with _$Union {
  const factory Union(int value) = Data;
  const factory Union.loading() = Loading;
  const factory Union.error([String? message]) = ErrorDetails;
}
```

Then [when] will be:

```dart
var union = Union(42);

print(
  union.when(
    (int value) => 'Data $value',
    loading: () => 'loading',
    error: (String? message) => 'Error: $message',
  ),
); // Data 42
```

Whereas if we defined:

```dart
@freezed
sealed class Model with _$Model {
  factory Model.first(String a) = First;
  factory Model.second(int b, bool c) = Second;
}
```

Then [when] will be:

```dart
var model = Model.first('42');

print(
  model.when(
    first: (String a) => 'first $a',
    second: (int b, bool c) => 'second $b $c'
  ),
); // first 42
```

Notice how each callback matches with a constructor's name and prototype.

**NOTE**:\
All callbacks are required and must not be `null`.\
If that is not what you want, consider using [maybeWhen].

#### Map

The [map] methods are equivalent to [when], but **without** destructuring.

Consider this class:

```dart
@freezed
sealed class Model with _$Model {
  factory Model.first(String a) = First;
  factory Model.second(int b, bool c) = Second;
}
```

With such class, while [when] will be:

```dart
var model = Model.first('42');

print(
  model.when(
    first: (String a) => 'first $a',
    second: (int b, bool c) => 'second $b $c'
  ),
); // first 42
```

[map] will instead be:

```dart
var model = Model.first('42');

print(
  model.map(
    first: (First value) => 'first ${value.a}',
    second: (Second value) => 'second ${value.b} ${value.c}'
  ),
); // first 42
```

This can be useful if you want to do complex operations, like [copyWith]/`toString` for example:

```dart
var model = Model.second(42, false)
print(
  model.map(
    first: (value) => value,
    second: (value) => value.copyWith(c: true),
  )
); // Model.second(b: 42, c: true)
```

## Configurations

Freezed offers various options to customize the generated code. For example, you
may want to disable the generation of `when` methods.

To do so, there are two possibilities:

### Changing the behavior for a specific model

If you want to customize the generated code for only one specific class,
you can do so by using a different annotation:

```dart
@Freezed()
class Person with _$Person {
  factory Person(String name, int age) = _Person;
}
```

By doing so, you can now pass various parameters to `@Freezed` to change the output:

```dart
@Freezed(
  // Disable the generation of copyWith/==
  copyWith: false,
  equal: false,
)
class Person with _$Person {...}
```

To view all the possibilities, see the documentation of `@Freezed`: https://pub.dev/documentation/freezed_annotation/latest/freezed_annotation/Freezed-class.html

### Changing the behavior for the entire project

Instead of applying your modification to a single class, you may want to apply it to
all Freezed models at the same time.

You can do so by customizing a file called `build.yaml`  
This file is an optional configuration file that should be placed next to your `pubspec.yaml`:

```
my_project_folder/
  pubspec.yaml
  build.yaml
  lib/
```

There, you will be able to change the same options as the options found in `@Freezed` (see above)
by writing:

```yaml
targets:
  $default:
    builders:
      freezed:
        options:
          # Tells Freezed not to format .freezed.dart files.
          # This can significantly speed up code-generation.
          format: false
          # Disable the generation of copyWith/== for the entire project
          copy_with: false
          equal: false
          # `when` and `map` can be enabled/disabled entirely by setting them to `true`/`false`
          map: false
          # We can also enable/disable specific variants of `when`/`map` by setting them to `true`/`false`:
          when:
            when: true
            maybe_when: true
            when_or_null: false
```

# Utilities

### Freezed extension for VSCode

The [Freezed](https://marketplace.visualstudio.com/items?itemName=blaxou.freezed) extension might help you work faster with freezed. For example :

- Use <kbd>Ctrl+Shift+B</kbd> (<kbd>Cmd+Shift+B</kbd> on Mac) to quickly build using `build_runner`.
- Quickly generate a Freezed class by using <kbd>Ctrl+Shift+P</kbd> (<kbd>Cmd+Shift+P</kbd> on Mac)> `Generate Freezed class`.

### Freezed extension for IntelliJ/Android Studio

You can get Live Templates for boiler plate code [here](https://github.com/Tinhorn/freezed_intellij_live_templates).

Example:

- type **freezedClass** and press <kbd>Tab</kbd> to generate a freezed class
  ```dart
  @freezed
  class Demo with _$Demo {
  }
  ```
- type **freezedFromJson** and press <kbd>Tab</kbd> to generate the fromJson method for json_serializable
  ```dart
  factory Demo.fromJson(Map<String, dynamic> json) => _$DemoFromJson(json);
  ```

## Third-party tools

This part contains community-made tools which integrate with Freezed.

### DartJ

[DartJ](https://dartj.web.app/#/) is Flutter application, maked by @ttpho, which will generate the Freezed classes from a JSON payload.

Example:

https://github.com/ttpho/ttpho/assets/3994863/5d529258-c02c-4066-925e-ca2ffc68a804

## Sponsors

<p align="center">
  <a href="https://raw.githubusercontent.com/rrousselGit/freezed/master/sponsorkit/sponsors.svg">
    <img src='https://raw.githubusercontent.com/rrousselGit/freezed/master/sponsorkit/sponsors.svg'/>
  </a>
</p>

[build_runner]: https://pub.dev/packages/build_runner
[freezed]: https://pub.dartlang.org/packages/freezed
[freezed_annotation]: https://pub.dartlang.org/packages/freezed_annotation
[copywith]: #how-copywith-works
[when]: #when
[maybewhen]: #maybeWhen
[map]: #map
[maybemap]: #mapMaybeMap
[json_serializable]: https://pub.dev/packages/json_serializable
