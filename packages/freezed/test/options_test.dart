import 'package:analyzer/dart/analysis/results.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'common.dart';
import 'integration/optional_maybe.dart';

void main() {
  test('has no issue', () async {
    final main = await resolveSources(
      {'freezed|test/integration/optional_maybe.dart': useAssetReader},
      (r) => r.libraries.firstWhere(
        (element) => element.source.toString().contains('optional_maybe'),
      ),
    );

    final errorResult = await main.session.getErrors(
      '/freezed/test/integration/optional_maybe_test.freezed.dart',
    ) as ErrorsResult;

    expect(errorResult.errors, isEmpty);
  });

  test('can disable copyWith', () async {
    await expectLater(
      compile(r'''
import 'optional_maybe.dart';

void main() {
  OptionalCopyWith().copyWith;
}
'''),
      throwsCompileError,
    );
  });

  test('can disable toString', () {
    expect(
      const OptionalToString().toString(),
      r"Instance of '_OptionalToString'",
    );
  });

  test('can disable ==/hash', () {
    expect(OptionalEqual(), isNot(OptionalEqual()));
    expect(OptionalEqual().hashCode, isNot(OptionalEqual().hashCode));
  });

  test('can disable toJson', () async {
    OptionalToJson();
    OptionalToJson.fromJson({});

    await expectLater(
      compile(r'''
import 'optional_maybe.dart';

void main() {
  OptionalToJson().toJson;
}
'''),
      throwsCompileError,
    );
  });

  test('can force toJson', () async {
    expect(ForceToJson(42).toJson(), {'a': 42});
  });
}
