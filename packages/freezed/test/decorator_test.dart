// @dart=2.9

import 'package:analyzer/dart/analysis/results.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

void main() {
  // TODO: Tear off deprecated
  test('has no issue', () async {
    final main = await resolveSources(
      {
        'freezed|test/integration/decorator.dart': useAssetReader,
      },
      (r) => r.libraries.firstWhere(
          (element) => element.source.toString().contains('decorator')),
    );

    var errorResult = await main.session
            .getErrors2('/freezed/test/integration/decorator.freezed.dart')
        as ErrorsResult;
    expect(errorResult.errors, isEmpty);
    errorResult = await main.session
        .getErrors2('/freezed/test/integration/decorator.dart') as ErrorsResult;
  });

  test('warns if try to use deprecated property', () async {
    final main = await resolveSources(
      {
        'freezed|test/integration/main.dart': r'''
import 'decorator.dart';

void main() {
  final value = Decorator(a: 'a');
  print(value.a);

  value.copyWith(
    a: 'a',
  );

  final value2 = Decorator0(a: 'a');

  print(value2.a);

  value2.copyWith(
    a: 'a',
  );
}
''',
      },
      (r) => r.libraries.firstWhere(
          (element) => element.source.toString().contains('decorator')),
    );

    var errorResult = await main.session
        .getErrors2('/freezed/test/integration/main.dart') as ErrorsResult;
    expect(
        errorResult.errors.map((e) => e.errorCode.name),
        anyOf([
          [
            'DEPRECATED_MEMBER_USE_FROM_SAME_PACKAGE',
            'DEPRECATED_MEMBER_USE_FROM_SAME_PACKAGE',
            'DEPRECATED_MEMBER_USE_FROM_SAME_PACKAGE',
            'DEPRECATED_MEMBER_USE_FROM_SAME_PACKAGE',
            // TODO: find out why copyWith doesn't warn even if deprecated
            // 'DEPRECATED_MEMBER_USE_FROM_SAME_PACKAGE',
            // 'DEPRECATED_MEMBER_USE_FROM_SAME_PACKAGE',
          ],
          [
            'DEPRECATED_MEMBER_USE',
            'DEPRECATED_MEMBER_USE',
            'DEPRECATED_MEMBER_USE',
            'DEPRECATED_MEMBER_USE',
            // TODO: find out why copyWith doesn't warn even if deprecated
            // 'DEPRECATED_MEMBER_USE',
            // 'DEPRECATED_MEMBER_USE',
          ],
        ]));
  });
}
