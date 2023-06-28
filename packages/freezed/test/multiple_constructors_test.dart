// ignore_for_file: prefer_const_constructors, omit_local_variable_types, deprecated_member_use_from_same_package
import 'dart:async';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'common.dart';
import 'integration/multiple_constructors.dart';
import 'matchers.dart';

Future<void> main() async {
  final sources = await resolveSources(
    {'freezed|test/integration/multiple_constructors.dart': useAssetReader},
    (r) {
      return r.libraries.firstWhere((element) =>
          element.source.toString().contains('multiple_constructors'));
    },
  );

  ClassElement _getClassElement(String elementName) {
    return sources.topLevelElements
        .whereType<ClassElement>()
        .firstWhere((element) => element.name == elementName);
  }

  test('recursive class does not generate dynamic', () async {
    final recursiveClass = _getClassElement('_RecursiveNext');

    expect(recursiveClass.getField('value')!.type, isA<InterfaceType>());
  });

  test('recursive class with dollar generates correctly', () async {
    final recursiveClass = _getClassElement('_RecursiveWith\$DollarNext');

    expect(
      recursiveClass
          .getField('value')!
          .type
          .getDisplayString(withNullability: true),
      'RecursiveWith\$DollarImpl',
    );
  });

  test('Regression358', () {
    expect(
      Regression358.withSpecificColor(),
      Regression358(number: 2),
    );
    expect(
      Regression358.withSpecificColor(count: 42),
      Regression358(number: 42),
    );
  });

  test('doc', () {
    final complex = _getClassElement('Complex');
    final complex0 = _getClassElement('Complex0');
    final complex1 = _getClassElement('Complex1');
    final complex2 = _getClassElement('Complex2');

    expect(
      complex.mixins.first.accessors.first,
      isA<PropertyAccessorElement>()
          .having((e) => e.name, 'name', 'a')
          .having((e) => e.documentationComment, 'doc', '/// Hello'),
    );

    expect(complex0.accessors.where((e) => e.name != 'copyWith'), [
      isA<PropertyAccessorElement>()
          .having((e) => e.name, 'name', 'a')
          .having((e) => e.documentationComment, 'doc', '/// Hello'),
    ]);

    expect(complex1.accessors.where((e) => e.name != 'copyWith'), [
      isA<PropertyAccessorElement>()
          .having((e) => e.name, 'name', 'a')
          .having((e) => e.documentationComment, 'doc', '/// World'),
      isA<PropertyAccessorElement>()
          .having((e) => e.name, 'name', 'b')
          .having((e) => e.documentationComment, 'doc', '/// B'),
      isA<PropertyAccessorElement>()
          .having((e) => e.name, 'name', 'd')
          .having((e) => e.documentationComment, 'doc', null),
    ]);

    expect(complex2.accessors.where((e) => e.name != 'copyWith'), [
      isA<PropertyAccessorElement>()
          .having((e) => e.name, 'name', 'a')
          // The doc is inherited from `Complex`
          .having((e) => e.documentationComment, 'doc', null),
      isA<PropertyAccessorElement>()
          .having((e) => e.name, 'name', 'c')
          .having((e) => e.documentationComment, 'doc', '/// C'),
      isA<PropertyAccessorElement>()
          .having((e) => e.name, 'name', 'd')
          .having((e) => e.documentationComment, 'doc', null),
    ]);
  });

  test('assert', () {
    Complex('a');
    expect(
      () => Complex(''),
      throwsAssertionError,
    );

    Complex.first('', b: true);
    expect(
      () => Complex.first('a', b: true),
      throwsAssertionError,
    );
    expect(
      () => Complex.first('', b: false),
      throwsAssertionError,
    );
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
              '/freezed/test/integration/multiple_constructors.freezed.dart')
          as ErrorsResult;

      expect(errorResult.errors, isEmpty);
    });

    // test('can mutate unfreezed unions', () {
    //   final unionFirst = MutableUnion0('a', 42);
    //   final unionSecond = MutableUnion1('a', 42);
    //   final MutableUnion downcast = unionFirst;

    //   unionFirst
    //     ..a = 'b'
    //     ..b = 21;

    //   unionSecond
    //     ..a = 'b'
    //     ..c = 21;

    //   downcast.a = 'b';
    // });

//     test(
//         'cannot mutate shared property if one of the union has an immutable variant',
//         () async {
//       DirectUnfreezedImmutableUnionNamed('a').a = '';
//       DirectUnfreezedImmutableUnion2('a').a = '';

//       await expectLater(compile(r'''
// import 'multiple_constructors.dart';

// void main() {
//   UnfreezedImmutableUnion('').a;
//   UnfreezedImmutableUnion2('').a;
// }
// '''), completes);

//       await expectLater(compile(r'''
// import 'multiple_constructors.dart';

// void main() {
//   UnfreezedImmutableUnion('').a = '';
//   UnfreezedImmutableUnion2('').a = '';
// }
// '''), throwsCompileError);
//     });

    test('when works on unnamed constructors', () {
      expect(RequiredParams(a: 'a').when((a) => 21, second: (_) => 42), 21);
      expect(
        RequiredParams.second(a: 'a').when((a) => 21, second: (_) => 42),
        42,
      );
    });

    test('whenOrNull works on unnamed constructors', () {
      expect(
        RequiredParams(a: 'a').whenOrNull((a) => 21, second: (_) => 42),
        21,
      );
      expect(
        RequiredParams.second(a: 'a').whenOrNull(
          (a) => 21,
          second: (_) => 42,
        ),
        42,
      );

      expect(
        RequiredParams(a: 'a').whenOrNull(null, second: (_) => 42),
        null,
      );
      expect(
        RequiredParams.second(a: 'a').whenOrNull((a) => 21),
        null,
      );
    });

    test('map works on unnamed constructors', () {
      expect(RequiredParams(a: 'a').map((a) => 21, second: (_) => 42), 21);
      expect(
        RequiredParams.second(a: 'a').map((a) => 21, second: (_) => 42),
        42,
      );
    });

    test('mapOrNull works on unnamed constructors', () {
      expect(RequiredParams(a: 'a').mapOrNull((a) => 21), 21);
      expect(
        RequiredParams.second(a: 'a').mapOrNull((a) => 21, second: (_) => 42),
        42,
      );

      expect(RequiredParams(a: 'a').mapOrNull(null), null);
      expect(
        RequiredParams.second(a: 'a').mapOrNull(null),
        null,
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

    test('mapOrNull can use FutureOr', () async {
      var res = NoDefault.first('a').mapOrNull<FutureOr<int>>(
        first: (a) => 21,
      );

      expect(res, 21);

      res = NoDefault.second('a').mapOrNull<FutureOr<int>>(
        second: (b) => Future.value(42),
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

    test('whenOrNull can use FutureOr', () async {
      var res = NoDefault.first('a').whenOrNull<FutureOr<int>>(
        first: (a) => 21,
      );

      expect(res, 21);

      res = NoDefault.second('a').whenOrNull<FutureOr<int>>(
        second: (b) => Future.value(42),
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
      int? b = ctor0.b;
      expect(a, 'a');
      expect(b, 42);

      var ctor1 = NoCommonParam1(.42);
      ctor1 = NoCommonParam1(.42, const Object());

      double c = ctor1.c;
      Object? d = ctor1.d;
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
      final nestedListClass = _getClassElement('ShallowNestedList');

      expect(
          nestedListClass
              .getField('children')!
              .type
              .getDisplayString(withNullability: true),
          'List<LeafNestedListItem>');
    });

    test('generates List of correct type for deeply nested case', () async {
      final nestedListClass = _getClassElement('DeepNestedList');

      expect(
          nestedListClass
              .getField('children')!
              .type
              .getDisplayString(withNullability: true),
          'List<InnerNestedListItem>');

      final nestedListItemClass = _getClassElement('InnerNestedListItem');

      expect(
          nestedListItemClass
              .getField('children')!
              .type
              .getDisplayString(withNullability: true),
          'List<LeafNestedListItem>');
    });
  });
  group('NestedMap', () {
    test('generates Map of correct type', () async {
      final nestedMapClass = _getClassElement('ShallowNestedMap');

      expect(
          nestedMapClass
              .getField('children')!
              .type
              .getDisplayString(withNullability: true),
          'Map<String, LeafNestedMapItem>');
    });

    test('generates Map of correct type for deeply nested case', () async {
      final nestedMapClass = _getClassElement('DeepNestedMap');

      expect(
          nestedMapClass
              .getField('children')!
              .type
              .getDisplayString(withNullability: true),
          'Map<String, InnerNestedMapItem>');

      final nestedMapItemClass = _getClassElement('InnerNestedMapItem');

      expect(
          nestedMapItemClass
              .getField('children')!
              .type
              .getDisplayString(withNullability: true),
          'Map<String, LeafNestedMapItem>');
    });
  });
}
