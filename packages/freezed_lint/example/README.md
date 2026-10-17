## Testing freezed_lint

Files in `lib/` are fixtures for the lints.
Valid cases use real freezed code generation. Cases that freezed knowingly
rejects live in separate `*_failing.dart` files, which are excluded from
code generation in `build.yaml` and use fake generated code instead.


- Every expected lint is marked with an `// ignore: freezed_lint/<lint>`
  comment. `dart analyze --fatal-infos` fails if a lint is reported
  without being ignored.
- Quick-fixes are tested with snapshot testing: `dart test` applies each fix
  and compares the result with the `*.fix.dart` goldens.
  To update the goldens, run:

```sh
goldens=true dart test
```
