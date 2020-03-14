import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

void main() {
  // Tear off deprecated
  test('has no issue', () async {
    final main = await resolveSources(
      {
        'freezed|test/integration/decorator.dart': useAssetReader,
      },
      (r) => r.libraries.firstWhere(
          (element) => element.source.toString().contains('decorator')),
    );

    var errorResult = await main.session
        .getErrors('/freezed/test/integration/decorator.freezed.dart');
    expect(errorResult.errors, isEmpty);
    errorResult = await main.session
        .getErrors('/freezed/test/integration/decorator.dart');
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

    var errorResult =
        await main.session.getErrors('/freezed/test/integration/main.dart');
    expect(
      errorResult.errors.map((e) => e.errorCode.name),
      [
        'DEPRECATED_MEMBER_USE_FROM_SAME_PACKAGE',
        'DEPRECATED_MEMBER_USE_FROM_SAME_PACKAGE',
        'DEPRECATED_MEMBER_USE_FROM_SAME_PACKAGE',
        'DEPRECATED_MEMBER_USE_FROM_SAME_PACKAGE',
        // TODO: find out why copyWith doesn't warn even if deprecated
        // 'DEPRECATED_MEMBER_USE_FROM_SAME_PACKAGE',
        // 'DEPRECATED_MEMBER_USE_FROM_SAME_PACKAGE',
      ],
    );
  });
}
