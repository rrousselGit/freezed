// ignore_for_file: prefer_const_constructors, omit_local_variable_types
// ignore_for_file: prefer_const_constructors, omit_local_variable_types
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';
import 'package:matcher/matcher.dart';
import 'package:collection/collection.dart';

import 'common.dart';
import 'integration/json.dart';

final bool Function(Object o, Object o2) deepEquals = DeepCollectionEquality().equals;

Future<void> main() async {
  test('has no issue', () async {
    final main = await resolveSources(
      {
        'freezed|test/integration/json.dart': useAssetReader,
      },
      (r) => r.libraries.firstWhere((element) => element.source.toString().contains('json')),
    );

    var errorResult = await main.session.getErrors('/freezed/test/integration/json.freezed.dart');
    expect(errorResult.errors, isEmpty);
  });

  test('toJson', () {
    expect(
      deepEquals(Json().toJson(), {
        'runtimeType': 'default',
      }),
      isTrue,
    );

    expect(
      deepEquals(Json.first('42').toJson(), {
        'a': '42',
        'runtimeType': 'first',
      }),
      isTrue,
    );

    expect(
      deepEquals(Json.second(42).toJson(), {
        'b': 42,
        'runtimeType': 'second',
      }),
      isTrue,
    );
  });
  test('throws if runtimeType matches nothing', () {
    expect(
      () => Json.fromJson(<String, dynamic>{}),
      throwsA(isA<AssertionError>()),
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
