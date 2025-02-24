// ignore_for_file: prefer_const_constructors, omit_local_variable_types, deprecated_member_use_from_same_package
import 'package:analyzer/dart/analysis/results.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'common.dart';
import 'integration/generic.dart';

Future<void> main() async {
  test('regression 399', () async {
    await expectLater(
      compile(r'''
import 'regression399/a.dart';
import 'regression399/b.dart';

void main() {
  GenericRegression399A<int>(
    b: GenericRegression399BImpl(),
  );
}
'''),
      completes,
    );

    await expectLater(
      compile(r'''
import 'regression399/a.dart';
import 'regression399/b.dart';

void main() {
  GenericRegression399A<int>(
    b: 42,
  );
}
'''),
      throwsCompileError,
    );
  });

  test('has no issue', () async {
    final main = await resolveSources(
      {'freezed|test/integration/generic.dart': useAssetReader},
      (r) => r.libraries.firstWhere(
        (element) => element.source.toString().contains('generic'),
      ),
    );

    final errorResult =
        await main.session.getErrors(
              '/freezed/test/integration/generic.freezed.dart',
            )
            as ErrorsResult;

    expect(errorResult.errors, isEmpty);
  });

  test('is generic', () {
    Generic<Model<int>> value = Generic(Model(42));
    Model<int> model = value.model;

    expect(model.value, 42);
  });

  test('is generic2', () {
    MultiGeneric<int, Model<int>> value = MultiGeneric(Model(42));
    Model<int> model = value.model;

    expect(model.value, 42);
  });

  test('toString', () {
    expect(
      '${MultipleConstructors<int, String>.first(42)}',
      'MultipleConstructors<int, String>.first(a: 42)',
    );

    expect(
      '${MultipleConstructors<int, String>.second('42')}',
      'MultipleConstructors<int, String>.second(b: 42)',
    );

    expect(
      '${MultipleConstructors<int, String>(false)}',
      'MultipleConstructors<int, String>(flag: false)',
    );
  });

  test('copy returns generic ', () {
    Generic<Model<int>> generic = Generic(Model(42));
    generic = generic.copyWith(model: Model(24));
    expect(generic.model.value, 24);

    MultiGeneric<int, Model<int>> generic2 = MultiGeneric(Model(42));
    generic2 = generic2.copyWith(model: Model(24));
    expect(generic2.model.value, 24);
  });

  test('supports copyWith(value: null) vs copyWith() on nullable generics', () {
    expect(
      GenericOrNull<int>(42).copyWith(value: null),
      GenericOrNull<int>(null),
    );
    expect(GenericOrNull<int>(42).copyWith(), GenericOrNull<int>(42));

    expect(
      NullableGeneric<int?>(42).copyWith(value: null),
      NullableGeneric<int?>(null),
    );
    expect(NullableGeneric<int?>(42).copyWith(), NullableGeneric<int?>(42));
  });

  test('did pass generic constraints', () async {
    await expectLater(
      compile(r'''
import 'generic.dart';

void main() {
  Generic<Model<int>>(Model(42));
}
'''),
      completes,
    );

    await expectLater(
      compile(r'''
import 'generic.dart';

void main() {
  Generic<int>(42);
}
'''),
      throwsCompileError,
    );
  });
}
