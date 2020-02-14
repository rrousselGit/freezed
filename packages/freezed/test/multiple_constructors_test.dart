// ignore_for_file: prefer_const_constructors, omit_local_variable_types
import 'dart:async';

import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'common.dart';
import 'integration/multiple_constructors.dart';

void main() {
  group('NoSharedParam', () {
    test("doesn't have public properties/methods", () async {
      await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final param = NoCommonParam('a', b: 42);
  dynamic a = param.a;
}
'''), throwsCompileError);
      await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final param = NoCommonParam('a', b: 42);
  dynamic b = param.b;
}
'''), throwsCompileError);
      await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final param = NoCommonParam('a', b: 42);
  param.copyWith;
}
'''), throwsCompileError);
    });
    test('no warning', () async {
      final main = await resolveSources(
        {
          'freezed|test/integration/multiple_constructors.dart': useAssetReader,
        },
        (r) => r.libraries.firstWhere((element) =>
            element.source.toString().contains('multiple_constructors')),
      );

      final errorResult = await main.session.getErrors(
          '/freezed/test/integration/multiple_constructors.freezed.dart');

      expect(errorResult.errors, isEmpty);
    });
    test('maybeMap  can use FutureOr', () async {
      var res = NoDefault.first('a').maybeMap<FutureOr<int>>(
        first: (a) => 21,
        orElse: () => Future.value(42),
      );

      expect(res, 21);

      res = NoDefault.second('a').maybeMap<FutureOr<int>>(
        second: (b) => Future.value(42),
        orElse: () => 21,
      );

      await expectLater(res, completion(42));
    });
    test('map  can use FutureOr', () async {
      var res = NoDefault.first('a').map<FutureOr<int>>(
        first: (a) => 21,
        second: (b) => Future.value(42),
      );

      expect(res, 21);

      res = NoDefault.second('a').map<FutureOr<int>>(
        first: (a) => 21,
        second: (b) => Future.value(42),
      );

      await expectLater(res, completion(42));
    });

    test('maybeWhen  can use FutureOr', () async {
      var res = NoDefault.first('a').maybeWhen<FutureOr<int>>(
        first: (a) => 21,
        orElse: () => Future.value(42),
      );

      expect(res, 21);

      res = NoDefault.second('a').maybeWhen<FutureOr<int>>(
        second: (b) => Future.value(42),
        orElse: () => 21,
      );

      await expectLater(res, completion(42));
    });
    test('when  can use FutureOr', () async {
      var res = NoDefault.first('a').when<FutureOr<int>>(
        first: (a) => 21,
        second: (b) => Future.value(42),
      );

      expect(res, 21);

      res = NoDefault.second('a').when<FutureOr<int>>(
        first: (a) => 21,
        second: (b) => Future.value(42),
      );

      await expectLater(res, completion(42));
    });
    test('redirected constructors do have public properties', () {
      final ctor0 = NoCommonParam0('a', b: 42);
      String a = ctor0.a;
      int b = ctor0.b;
      expect(a, 'a');
      expect(b, 42);

      var ctor1 = NoCommonParam1(.42);
      ctor1 = NoCommonParam1(.42, const Object());

      double c = ctor1.c;
      Object d = ctor1.d;
      expect(c, .42);
      expect(d, const Object());
    });
    test('redirected can be cloned', () {
      var ctor0 = NoCommonParam0('a', b: 42);
      ctor0 = ctor0.copyWith(a: '2', b: 21);
      expect(ctor0.a, '2');
      expect(ctor0.b, 21);

      var ctor1 = NoCommonParam1(.42);
      ctor1 = ctor1.copyWith(c: .21, d: const Object());
      expect(ctor1.c, .21);
      expect(ctor1.d, const Object());
    });
    test("redirected's copyWith doesn't have parameters of other constructors",
        () async {
      await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final param = NoCommonParam0('a', b: 42);
  param.copyWith(c: .42);
}
'''), throwsCompileError);
      await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final param = NoCommonParam0('a', b: 42);
  param.copyWith(d: Object());
}
'''), throwsCompileError);

      await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final param = NoCommonParam1(.42);
  param.copyWith(a: 'a');
}
'''), throwsCompileError);
      await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final param = NoCommonParam1(.42);
  param.copyWith(b: 42);
}
'''), throwsCompileError);
    });
  });
  group('SharedParam', () {
    test('has the common properties available', () {
      SharedParam value = SharedParam('a', 42);
      expect(value.a, 'a');

      value = SharedParam.named('b', 24);
      expect(value.a, 'b');
    });
    test("doesn't have the non-shared properties", () async {
      await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final param = SharedParam('a', 42);
  param.a;
}
'''), succeed);
      await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final param = SharedParam('a', 42);
  param.b;
}
'''), throwsCompileError);
      await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final param = SharedParam('a', 42);
  param.c;
}
'''), throwsCompileError);
    });
    test('copyWith on common properties', () {
      SharedParam value = SharedParam('a', 42);
      expect(value.a, 'a');
      value = value.copyWith(a: '2');
      expect(value.a, '2');
    });
    test("copy doesn't have the non-shared params", () async {
      await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final param = SharedParam('a', 42);
  param.copyWith(a: '2');
}
'''), succeed);
      await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final param = SharedParam('a', 42);
  param.copyWith(b: 42);
}
'''), throwsCompileError);
      await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final param = SharedParam('a', 42);
  param.copyWith(c: 42);
}
'''), throwsCompileError);
    });

    // TODO: shared property name but different type
  });

  test('Can have a named constructor and a property using the same name', () {
    var error = Error();
    final value = NameConflict.error(error);

    expect(
      value.when(something: (_) => 42, error: (err) => err),
      error,
    );
  });

  group('copyAs', () {
    test('exposes one method per constructor', () {
      var value = NoDefault.first('a');

      NoDefault1 first = value.copyAsFirst();
      expect(first, NoDefault.first('a'));

      NoDefault2 second = value.copyAsSecond();
      expect(second, NoDefault.second('a'));
    });
    test('can modify the value', () {
      var value = NoDefault.first('a');

      NoDefault1 first = value.copyAsFirst(a: 'b');
      expect(first, NoDefault.first('b'));

      NoDefault2 second = value.copyAsSecond(a: 'c');
      expect(second, NoDefault.second('c'));
    });
    test(
        'Converting from a case that may not have a given property makes the parameter of the same name required',
        () async {
      await expectLater(
        compile(r'''
import 'multiple_constructors.dart';

void main() {
  final value = NoCommonParam('a');
  value.copyAsNamed();
}
'''),
        completion([HintCode.MISSING_REQUIRED_PARAM]),
      );
    });
    test('nothing is required if all properties are compatible', () async {
      await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final value = Complex('a');
  value.copyAsDefault();
}
'''), succeed);
    });
    test(
        'do not require properties that are not in the current interface if the target property is optional',
        () async {
      await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final value = Complex('a');
  value.copyAsFirst();
}
'''), succeed);
    });
    // TODO: copyAs asserts != null
    // TODO: copyAs same name but different type
    // TODO: private namer ctor geenrates private copyAs
    // TODO: test default ctor ame
  });
}
