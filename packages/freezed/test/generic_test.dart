// @dart=2.9

// ignore_for_file: prefer_const_constructors, omit_local_variable_types
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';
import 'package:matcher/matcher.dart';

import 'common.dart';
import 'integration/generic.dart';

Future<void> main() async {
  test('tear off', () {
    expect(
      $Union<int>(42),
      Union<int>(42),
    );

    expect(
      $Union.loading<int>(),
      const Union<int>.loading(),
    );

    expect(
      $Union.error<int>('msg'),
      const Union<int>.error('msg'),
    );
  });

  test('has no issue', () async {
    final main = await resolveSources(
      {
        'freezed|test/integration/generic.dart': useAssetReader,
      },
      (r) => r.libraries.firstWhere(
          (element) => element.source.toString().contains('generic')),
    );

    final errorResult = await main.session
        .getErrors('/freezed/test/integration/generic.freezed.dart');

    expect(errorResult.errors, isEmpty);
  });

  test('is generic', () {
    Generic<Model<int>> value = Generic(Model(42));
    Model<int> model = value.model;

    expect(model.value, 42);
  });

  test('map is generic too', () {
    var result = MultipleConstructors<int, double>(false)
        .map<MultipleConstructors<int, double>>(
      (Default<int, double> value) => value,
      first: (First<int, double> value) => value,
      second: (Second<int, double> value) => value,
    );

    expect(result, MultipleConstructors<int, double>(false));

    MultipleConstructors<int, double>(false)
        .maybeMap<MultipleConstructors<int, double>>(
      (Default<int, double> value) => value,
      first: (First<int, double> value) => value,
      second: (Second<int, double> value) => value,
      orElse: () => throw Error(),
    );

    expect(result, MultipleConstructors<int, double>(false));
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

  test('did pass generic constraints', () async {
    await expectLater(compile(r'''
import 'generic.dart';

void main() {
  Generic<Model<int>>(Model(42));
}
'''), completes);

    await expectLater(compile(r'''
import 'generic.dart';

void main() {
  Generic<int>(42);
}
'''), throwsCompileError);
  });
}
