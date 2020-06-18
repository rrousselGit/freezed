// ignore_for_file: prefer_const_constructors, omit_local_variable_types
import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'common.dart';
import 'integration/multiple_constructors.dart';

typedef NoCommonParamDefaultTearOff = NoCommonParam0 Function(
  String a, {
  int b,
});
typedef NoCommonParamNamedTearOff = NoCommonParam1 Function(
  double c, [
  Object d,
]);

void main() {
  test('recursive class does not generate dynamic', () async {
    final recursiveClass = await _getClassElement('_RecursiveNext');

    expect(recursiveClass.getField('value').type.isDynamic, isFalse);
  });
  test('tear off', () {
    expect(
      $NoCommonParam('a', b: 42),
      NoCommonParam('a', b: 42),
    );
    expect($NoCommonParam.call.runtimeType, NoCommonParamDefaultTearOff);
    expect(
      $NoCommonParam.named(42, 42),
      NoCommonParam.named(42, 42),
    );
    expect($NoCommonParam.named.runtimeType, NoCommonParamNamedTearOff);
  });
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
    test('when works on unnamed constructors', () {
      expect(RequiredParams(a: 'a').when((a) => 21, second: (_) => 42), 21);
      expect(
        RequiredParams.second(a: 'a').when((a) => 21, second: (_) => 42),
        42,
      );
    });
    test('map works on unnamed constructors', () {
      expect(RequiredParams(a: 'a').map((a) => 21, second: (_) => 42), 21);
      expect(
        RequiredParams.second(a: 'a').map((a) => 21, second: (_) => 42),
        42,
      );
    });
    test('maybeMap works on unnamed constructors', () {
      expect(RequiredParams(a: 'a').maybeMap((a) => 21, orElse: () => 42), 21);
      expect(
        RequiredParams.second(a: 'a').maybeMap((a) => 21, orElse: () => 42),
        42,
      );
      expect(RequiredParams(a: 'a').maybeMap(null, orElse: () => 42), 42);
      expect(
        RequiredParams.second(a: 'a').maybeMap(null, orElse: () => 42),
        42,
      );
    });
    test('maybeWhen works on unnamed constructors', () {
      expect(RequiredParams(a: 'a').maybeWhen((a) => 21, orElse: () => 42), 21);
      expect(
        RequiredParams.second(a: 'a').maybeWhen((a) => 21, orElse: () => 42),
        42,
      );
      expect(RequiredParams(a: 'a').maybeWhen(null, orElse: () => 42), 42);
      expect(
        RequiredParams.second(a: 'a').maybeWhen(null, orElse: () => 42),
        42,
      );
    });
    test('maybeMap can use FutureOr', () async {
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
    test('map can use FutureOr', () async {
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
    test('when can use FutureOr', () async {
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
'''), completes);
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
'''), completes);
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
  group('NestedList', () {
    test('generates List of correct type', () async {
      final nestedListClass = await _getClassElement('ShallowNestedList');

      expect(nestedListClass.getField('children').type.getDisplayString(),
          'List<LeafNestedListItem>');
    });

    test('generates List of correct type for deeply nested case', () async {
      final nestedListClass = await _getClassElement('DeepNestedList');

      expect(nestedListClass.getField('children').type.getDisplayString(),
          'List<InnerNestedListItem>');

      final nestedListItemClass = await _getClassElement('InnerNestedListItem');

      expect(nestedListItemClass.getField('children').type.getDisplayString(),
          'List<LeafNestedListItem>');
    });
  });
  group('NestedMap', () {
    test('generates Map of correct type', () async {
      final nestedMapClass = await _getClassElement('ShallowNestedMap');

      expect(nestedMapClass.getField('children').type.getDisplayString(),
          'Map<String, LeafNestedMapItem>');
    });

    test('generates Map of correct type for deeply nested case', () async {
      final nestedMapClass = await _getClassElement('DeepNestedMap');

      expect(nestedMapClass.getField('children').type.getDisplayString(),
          'Map<String, InnerNestedMapItem>');

      final nestedMapItemClass = await _getClassElement('InnerNestedMapItem');

      expect(nestedMapItemClass.getField('children').type.getDisplayString(),
          'Map<String, LeafNestedMapItem>');
    });
  });
}

Future<ClassElement> _getClassElement(String elementName) async {
  final sources = await resolveSources(
    {'freezed|test/integration/multiple_constructors.dart': useAssetReader},
    (r) {
      return r.libraries.firstWhere((element) =>
          element.source.toString().contains('multiple_constructors'));
    },
  );
  return sources.topLevelElements
      .whereType<ClassElement>()
      .firstWhere((element) => element.name == elementName);
}
