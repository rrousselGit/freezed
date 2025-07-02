import 'package:analyzer/dart/analysis/results.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'common.dart';
import 'integration/optional_maybe.dart';

void main() {
  test('has no issue', () async {
    final main = await resolveSources(
      {
        'freezed|test/integration/optional_maybe.dart': useAssetReader,
      },
      (r) => r.libraries.firstWhere(
          (element) => element.source.toString().contains('optional_maybe')),
    );

    final errorResult = await main.session
            .getErrors('/freezed/test/integration/optional_maybe.freezed.dart')
        as ErrorsResult;

    expect(errorResult.errors, isEmpty);
  });

  test('does not generates maybeMap', () async {
    await expectLater(compile(r'''
      import 'optional_maybe.dart';

      void main() {
        final value = OptionalMaybeMap.first();

        value.maybeMap(orElse: () => null);
        value.map(
          first: (_) {},
          second: (_) {},
        );
        value.mapOrNull();
      }
      '''), throwsCompileError);

    const OptionalMaybeMap.first()
      ..whenOrNull()
      ..maybeWhen(orElse: () {})
      ..when(
        first: () {},
        second: () {},
      );
  });

  test('does not generates maybeWhen', () async {
    await expectLater(compile(r'''
      import 'optional_maybe.dart';

      void main() {
        final value = OptionalMaybeWhen.first();

        value.maybeWhen(orElse: () => null);
        value.when(
          first: () {},
          second: () {},
        );
        value.whenOrNull();
      }
      '''), throwsCompileError);

    const OptionalMaybeWhen.first()
      ..mapOrNull()
      ..maybeMap(orElse: () {})
      ..map(
        first: (_) {},
        second: (_) {},
      );
  });

  test('can disable copyWith', () async {
    await expectLater(compile(r'''
import 'optional_maybe.dart';

void main() {
  OptionalCopyWith().copyWith;
}
'''), throwsCompileError);
  });

  test('can disable toString', () {
    expect(
      const OptionalToString().toString(),
      r"Instance of '_OptionalToString'",
    );
  });

  test('can disable ==/hash', () {
    expect(
      OptionalEqual(),
      isNot(OptionalEqual()),
    );
    expect(
      OptionalEqual().hashCode,
      isNot(OptionalEqual().hashCode),
    );
  });

  test('can force the generation of when/map', () {
    ForceUnionMethod2.two()
      ..map(two: (_) {})
      ..mapOrNull()
      ..maybeMap(orElse: () {})
      ..when(two: () {})
      ..whenOrNull()
      ..maybeWhen(orElse: () {});

    ForceUnionMethod()
      ..map((value) => null)
      ..mapOrNull((value) => null)
      ..maybeMap((value) => null, orElse: () {})
      ..when(() => null)
      ..whenOrNull(() => null)
      ..maybeWhen(() => null, orElse: () {});
  });

  test('can disable toJson', () async {
    OptionalToJson();
    OptionalToJson.fromJson({});

    await expectLater(compile(r'''
import 'optional_maybe.dart';

void main() {
  OptionalToJson().toJson;
}
'''), throwsCompileError);
  });

  test('can force toJson', () async {
    expect(ForceToJson(42).toJson(), {'a': 42});
  });
}
