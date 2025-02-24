import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

void main() {
  test('has no issue', () async {
    final main = await resolveSources(
      {'freezed|test/integration/decorator.dart': useAssetReader},
      (r) => r.libraries.firstWhere(
        (element) => element.source.toString().contains('decorator'),
      ),
    );

    var errorResult =
        await main.session.getErrors(
              '/freezed/test/integration/decorator.freezed.dart',
            )
            as ErrorsResult;
    expect(errorResult.errors, isEmpty);
    errorResult =
        await main.session.getErrors('/freezed/test/integration/decorator.dart')
            as ErrorsResult;
  });

  test(
    'internal raw collection is not decorated when using immutable collections',
    () async {
      final main = await resolveSources(
        {
          'freezed|test/integration/main.dart': r'''
import 'decorator.dart';
''',
        },
        (r) => r.libraries.firstWhere(
          (element) => element.library.name == 'decorator',
        ),
      );

      final concrete = main.topLevelElements
          .whereType<ClassElement>()
          .firstWhere((e) => e.name == r'ListDecorator0');

      expect(
        concrete.fields.firstWhere((element) => element.name == '_a').metadata,
        isEmpty,
      );

      final unmodifiableGetter =
          concrete.fields.firstWhere((element) => element.name == 'a').getter!;

      expect(unmodifiableGetter.metadata.length, 2);
      expect(unmodifiableGetter.metadata.last.toSource(), '@Foo()');
    },
  );

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
        (element) => element.source.toString().contains('decorator'),
      ),
    );

    var errorResult =
        await main.session.getErrors('/freezed/test/integration/main.dart')
            as ErrorsResult;
    expect(
      errorResult.errors.map((e) => e.errorCode.name),
      anyOf([
        [
          'UNUSED_RESULT',
          'UNUSED_RESULT',
          'DEPRECATED_MEMBER_USE_FROM_SAME_PACKAGE',
          'DEPRECATED_MEMBER_USE_FROM_SAME_PACKAGE',
          'DEPRECATED_MEMBER_USE_FROM_SAME_PACKAGE',
          'DEPRECATED_MEMBER_USE_FROM_SAME_PACKAGE',
        ],
        [
          'UNUSED_RESULT',
          'UNUSED_RESULT',
          'DEPRECATED_MEMBER_USE',
          'DEPRECATED_MEMBER_USE',
          'DEPRECATED_MEMBER_USE',
          'DEPRECATED_MEMBER_USE',
        ],
      ]),
    );
  });
}
