// ignore_for_file: prefer_const_constructors, omit_local_variable_types
// ignore_for_file: prefer_const_constructors, omit_local_variable_types
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';
import 'package:matcher/matcher.dart';

import 'common.dart';
import 'integration/json.dart';

Future<void> main() async {
  test('class decorators are applied on the generated class', () {
    expect(
      ClassDecorator('Complex name').toJson(),
      {
        'complex_name': 'Complex name',
      },
    );
  });

  test('@Default implies a @JsonKey', () {
    final value = DefaultValue();
    expect(
      value.toJson(),
      {'value': 42},
    );

    expect(
      DefaultValue.fromJson(<String, dynamic>{}),
      DefaultValue(42),
    );
  });

  test('@Default does not imply a @JsonKey if one is already specified', () {
    expect(
      DefaultValueJsonKey.fromJson(<String, dynamic>{}),
      DefaultValueJsonKey(21),
    );
  });

  group('generic json', () {
    test('fromJson', () {
      expect(
        Generic<int>.fromJson(<String, dynamic>{'a': 42}),
        Generic(42),
      );
    });

    test('tear-off', () {
      Generic<int> Function(Map<String, Object>) fromJson = $Generic.fromJson;

      expect(
        fromJson(<String, dynamic>{'a': 42}),
        Generic(42),
      );
    });
  });

  test('single ctor + json can access properties/copyWith', () {
    final value = Single(42);

    expect(value.a, 42);
    expect(value.copyWith(a: 24), Single(24));
  });

  test('has no issue', () async {
    final main = await resolveSources(
      {
        'freezed|test/integration/json.dart': useAssetReader,
      },
      (r) => r.libraries
          .firstWhere((element) => element.source.toString().contains('json')),
    );

    var errorResult = await main.session
        .getErrors('/freezed/test/integration/json.freezed.dart');
    expect(errorResult.errors, isEmpty);
  }, skip: true);

  test("single constructor fromJson doesn't require runtimeType", () {
    expect(
      Single.fromJson(<String, dynamic>{
        'a': 42,
      }),
      Single(42),
    );
  });

  test("single constructor toJson doesn't add runtimeType", () {
    expect(
      Single(42).toJson(),
      {
        'a': 42,
      },
    );
  });

  group('toJson', () {
    test('support JsonKeys', () {
      expect(Decorator('42').toJson(), {'what': '42'});
    });

    test('works', () {
      expect(
        Json().toJson(),
        {
          'runtimeType': 'default',
        },
      );

      expect(
        Json.first('42').toJson(),
        {
          'a': '42',
          'runtimeType': 'first',
        },
      );

      expect(
        Json.second(42).toJson(),
        {
          'b': 42,
          'runtimeType': 'second',
        },
      );
    });
  });

  test('throws if runtimeType matches nothing', () {
    expect(
      () => Json.fromJson(<String, dynamic>{}),
      throwsA(isA<FallThroughError>()),
    );
    expect(
      () => Json.fromJson(<String, dynamic>{'runtimeType': 'unknown'}),
      throwsA(isA<FallThroughError>()),
    );
  });

  test('fromJsom', () {
    expect(
      Json.fromJson(<String, dynamic>{
        'runtimeType': 'default',
      }),
      Json(),
    );
    expect(
      Json.fromJson(<String, dynamic>{
        'runtimeType': 'first',
        'a': '42',
      }),
      Json.first('42'),
    );
    expect(
      Json.fromJson(<String, dynamic>{
        'runtimeType': 'second',
        'b': 42,
      }),
      Json.second(42),
    );
  });

  test('if no fromJson exists, no constructors are made', () async {
    await expectLater(compile(r'''
import 'json.dart';

void main() {
  Json.fromJson(<String, dynamic>{});
}
'''), completes);
    await expectLater(compile(r'''
import 'json.dart';

void main() {
  NoFirst.fromJson(<String, dynamic>{});
}
'''), throwsCompileError);
    await expectLater(compile(r'''
import 'json.dart';

void main() {
  NoDefault.fromJson(<String, dynamic>{});
}
'''), throwsCompileError);
    await expectLater(compile(r'''
import 'json.dart';

void main() {
  NoSecond.fromJson(<String, dynamic>{});
}
'''), throwsCompileError);
  });
}
