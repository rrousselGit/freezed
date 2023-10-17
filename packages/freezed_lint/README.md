# Lints for [freezed].

Written with [custom_lint] to help with miss-typed/configured freezed classes.

## How to use

Add freezed_lint and custom_lint to your projects `pubspec.yaml`.

```console
flutter pub add dev:custom_lint
flutter pub add dev:freezed_lint
```

And add custom_lint as a plugin in the `analysis_options.yaml`

```yaml
analyzer:
  plugins:
    - custom_lint
```

You might need to restart your IDE for it to pick up the new lints

## List of supported lint

- `freezed_missing_mixin` ✅
- `freezed_missing_private_empty_constructor` ✅

[freezed]: https://pub.dev/packages/freezed
[custom_lint]: https://pub.dev/packages/custom_lint
