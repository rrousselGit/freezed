import 'package:analyzer/dart/analysis/results.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'common.dart';

void main() {
  test('has no issue', () async {
    final main = await resolveSources(
      {
        'freezed|test/integration/optionnal_maybe.dart': useAssetReader,
      },
      (r) => r.libraries.firstWhere(
          (element) => element.source.toString().contains('optionnal_maybe')),
    );

    final errorResult = await main.session.getErrors(
            '/freezed/test/integration/optionnal_maybe_test.freezed.dart')
        as ErrorsResult;

    expect(errorResult.errors, isEmpty);
  });

  test('does not generates maybeMap', () async {
    await expectLater(compile(r'''
      import 'optionnal_maybe.dart';

      void main() {
        final value = OptionnalMaybeMap.first();

        value.maybeMap(orElse: () => null);
      }
      '''), throwsCompileError);
  });

  test('does not generates maybeWhen', () async {
    await expectLater(compile(r'''
      import 'optionnal_maybe.dart';

      void main() {
        final value = OptionnalMaybeWhen.first();

        value.maybeWhen(orElse: () => null);
      }
      '''), throwsCompileError);
  });
}
