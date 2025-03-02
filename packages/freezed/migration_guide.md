## Migrate from v2 to v3

### Require keyword (`sealed` / `abstract`)

Classes using the factory constructor now require a keyword `sealed` / `abstract`.

```diff
@freezed
-class Person with _$Person {
+abstract class Person with _$Person {
  const factory Person({
    required String firstName,
    required String lastName,
    required int age,
  }) = _Person;

  factory Person.fromJson(Map<String, Object?> json)
      => _$PersonFromJson(json);
}
```

```diff
@freezed
-class Model with _$Model {
+sealed class Model with _$Model {
  factory Model.first(String a) = First;
  factory Model.second(int b, bool c) = Second;
}
```

### Pattern matching

Freezed no longer generates `.map`/`.when` extensions and their derivatives for freezed classes used for pattern matching. Instead, use Dart's built-in [pattern matching](https://dart.dev/language/patterns#matching) syntax.

```diff
final model = Model.first('42');

-final res = model.map(
-  first: (String a) => 'first $a',
-  second: (int b, bool c) => 'second $b $c',
-);
+final res = switch (model) {
+  First(:final a) => 'first $a',
+  Second(:final b, :final c) => 'second $b $c',
+};

```
