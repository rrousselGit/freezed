[English](https://github.com/rrousselGit/freezed/blob/master/packages/freezed/README.md) | [한국어](https://github.com/rrousselGit/freezed/blob/master/resources/translations/ko_KR/README.md) | [简体中文](https://github.com/rrousselGit/freezed/blob/master/resources/translations/zh_CN/README.md)

![Build](https://github.com/rrousselGit/freezed/workflows/Build/badge.svg)
[![pub package](https://img.shields.io/pub/v/freezed.svg)](https://pub.dartlang.org/packages/freezed)
<a href="https://discord.gg/Bbumvej"><img src="https://img.shields.io/discord/765557403865186374.svg?logo=discord&color=blue" alt="Discord"></a>

[<img src="https://raw.githubusercontent.com/rrousselGit/provider/master/resources/flutter_favorite.png" width="200" />](https://flutter.dev/docs/development/packages-and-plugins/favorites)

Welcome to the Macro version of [Freezed]!  
Freezed is a tool that generates `toString`, `copyWith` (including `copyWith(field: null)`), `hashCode`, `==`
and more.
For the sake of letting people experiment with macros while still be able to use a stable Freezed version in their apps, the macro PoC has been renamed to `data_class`.

This is a very early proof of concept about what Freezed would look like when macros land in Dart.
Beware: Due to many missing Macro features, lots of Freezed features are
missing or broken. Use at your own risk :)

## Installation

To get started with the macro version of Freezed:

- Make sure that you use a Dart version >= 3.5.0-dev
- Enable `macros` in your `analysis_options.yaml` as followed:
  ```yaml
  # analysis_options.yaml
  analyzer:
    enable-experiment:
      - macros
  ```
- Install Freezed >= 3.0.0:

  ```yaml
  name: your_app
  environment:
    sdk: ">=3.5.0-0.0-dev <4.0.0"

  dependencies:
    # Freezed is now a "dependencies".
    # freezed_annotation is no-longer needed
    freezed: ^3.0.0-0.0.dev
  ```

## Usage

Two possible syntaxes are supported:

- Constructor-first.
  You define a class with a constructor, and the macro will
  generate fields for you.
  This gives fine-grained control over positional vs named parameters.
  It offers the ability to use asserts, `super`, ...
  Although macros have still lots of things related to this that don't work.
  So although the syntax is very flexible, lots of things are not supported yet.

- Field-first.
  You define a class with fields, and the macro will generate a constructor for you.
  This is the most stable syntax.
  But it is less flexible, and not very dart-like.
  If you want full control over constructors, you'll have to use the constructor-first syntax.

### Constructor-first usage

To use the constructor-first syntax, define a class with a constructor,
but no fields:

```dart
@Data()
class Example {
  Example({required int foo, required String bar});
}
```

The macro will generate the fields for you, along with
the various methods.

```dart
void main() {
  final example = Example(foo: 42, bar: '42');
  print(example.foo); // 42
}
```

#### Using named constructors.

Naturally, the macro expects that you use the default constructor.
If you wish to generate fields based on a named constructor instead,
specify `@Data(constructor: '<constructor name>')`.

```dart
@Data(constructor: 'custom')
class Example {
 Example.custom({required int foo, required String bar});
}
```

### Field-first usage

To use the field-first syntax, define a class with fields
but default constructor.
The macro will then generate a constructor for you, along
with the various methods.

```dart
@Data()
class Example {
 final int foo;
 final String bar;
}
```

Currently, all fields are "named" parameters, and they are optional if they are nullable.

```dart
void main() {
 final example = Example(foo: 42, bar: '42');
 print(example.foo); // 42
}
```

#### Specifying the constructor name

If you wish to generate a non-default constructor,
you can specify `@Data(constructor: '<constructor name>')`.

```dart
@Data(constructor: 'custom')
class Example {
  final int foo;
}

void main() {
  final example = Example.custom(foo: 42);
}
```

## Features

| features        | status | comment                                                                   |
| --------------- | ------ | ------------------------------------------------------------------------- |
| copyWith        | ✅     |                                                                           |
| toString        | ✅     |                                                                           |
| ==/hashCode     | ✅     |                                                                           |
| unions          | 🚧     | Supported, but macros are a bit bugged with regards to class inheritance. |
| json support    | 🚧     |                                                                           |
| default values  | ❌     | Requires macros to be more developed                                      |
| deep copy       | ❌     | Requires macros to be more developed                                      |
| generic classes | ❌     | Requires macros to be more developed                                      |

[build_runner]: https://pub.dev/packages/build_runner
[freezed]: https://pub.dartlang.org/packages/freezed
[freezed_annotation]: https://pub.dartlang.org/packages/freezed_annotation
[copywith]: #how-copywith-works
[when]: #when
[maybewhen]: #maybeWhen
[map]: #map
[maybemap]: #mapMaybeMap
[json_serializable]: https://pub.dev/packages/json_serializable
