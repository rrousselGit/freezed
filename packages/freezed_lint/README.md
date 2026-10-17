# Lints for [freezed].

Written as an [analyzer plugin][analysis_server_plugin] to help with
miss-typed/configured freezed classes.

## How to use

Analyzer plugins require Dart 3.10 (Flutter 3.38) or later.

Enable freezed_lint as a plugin in your `analysis_options.yaml`:

```yaml
plugins:
  freezed_lint: ^0.1.0
```

There is no need to add freezed_lint to your `pubspec.yaml`.

You might need to restart your IDE for it to pick up the new lints.
The lints are reported by both your IDE and `dart analyze`/`flutter analyze`.

To silence a lint, prefix its name with `freezed_lint/`:

```dart
// ignore: freezed_lint/freezed_missing_mixin
```

## List of supported lint

- `freezed_missing_mixin` ✅
- `freezed_missing_private_empty_constructor` ✅

[freezed]: https://pub.dev/packages/freezed
[analysis_server_plugin]: https://pub.dev/packages/analysis_server_plugin
