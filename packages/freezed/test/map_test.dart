// ignore_for_file: prefer_const_constructors, omit_local_variable_types

import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'integration/multiple_constructors.dart';

void main() {
  group('when', () {
    test('works with no default ctr', () {
      var value = NoDefault.first('a');

      expect(
        value.map(
          first: (NoDefault1 value) => '${value.a} first',
          second: (NoDefault2 value) => throw Error(),
        ),
        'a first',
      );

      value = NoDefault.second('a');

      expect(
        value.map(
          first: (NoDefault1 value) => throw Error(),
          second: (NoDefault2 value) => '${value.a} second',
        ),
        'a second',
      );
    });

    group('default ctor', () {
      test("assert callbacks can't be null", () {
        final value = SwitchTest('a');

        expect(
          () => value.map(
            (a) {},
            first: null,
            second: (SwitchTest2 value) {},
          ),
          throwsA(isA<AssertionError>()),
        );
        expect(
          () => value.map(
            null,
            first: (SwitchTest1 value) {},
            second: (SwitchTest2 value) {},
          ),
          throwsA(isA<AssertionError>()),
        );
        expect(
          () => value.map(
            (a) {},
            first: (SwitchTest1 value) {},
            second: null,
          ),
          throwsA(isA<AssertionError>()),
        );
      });
      test('calls default callback', () {
        final value = SwitchTest('a');

        expect(
          value.map(
            (SwitchTest0 value) => '${value.a} 42',
            first: (SwitchTest1 value) => throw Error(),
            second: (SwitchTest2 value) => throw Error(),
          ),
          'a 42',
        );
      });
    });
    group('first ctor', () {
      test("assert callbacks can't be null", () {
        final value = SwitchTest.first('a');

        expect(
          () => value.map(
            (a) {},
            first: null,
            second: (SwitchTest2 value) {},
          ),
          throwsA(isA<AssertionError>()),
        );
        expect(
          () => value.map(
            null,
            first: (SwitchTest1 value) {},
            second: (SwitchTest2 value) {},
          ),
          throwsA(isA<AssertionError>()),
        );
        expect(
          () => value.map(
            (a) {},
            first: (SwitchTest1 value) {},
            second: null,
          ),
          throwsA(isA<AssertionError>()),
        );
      });
      test('calls first callback', () {
        final value = SwitchTest.first('a', b: false, d: .42);

        expect(
          value.map(
            (SwitchTest0 a) => throw Error(),
            first: (SwitchTest1 value) => '${value.a} ${value.b} ${value.d}',
            second: (SwitchTest2 value) => throw Error(),
          ),
          'a false 0.42',
        );
      });
    });
    group('second ctor', () {
      test("assert callbacks can't be null", () {
        final value = SwitchTest.second('a');

        expect(
          () => value.map(
            (a) {},
            first: null,
            second: (SwitchTest2 value) {},
          ),
          throwsA(isA<AssertionError>()),
        );
        expect(
          () => value.map(
            null,
            first: (SwitchTest1 value) {},
            second: (SwitchTest2 value) {},
          ),
          throwsA(isA<AssertionError>()),
        );
        expect(
          () => value.map(
            (a) {},
            first: (SwitchTest1 value) {},
            second: null,
          ),
          throwsA(isA<AssertionError>()),
        );
      });
      test('calls second callback', () {
        final value = SwitchTest.second('a', 21, .42);

        expect(
          value.map(
            (SwitchTest0 a) => throw Error(),
            first: (SwitchTest1 value) => throw Error(),
            second: (SwitchTest2 value) => '${value.a} ${value.c} ${value.d}',
          ),
          'a 21 0.42',
        );
      });
    });

    test('named parameters are marked as required', () async {
      final main = await resolveSources(
        {
          'freezed|test/integration/main.dart': r'''
library main;
import 'multiple_constructors.dart';

void main() {
  final value = SwitchTest.first('a', b: false, d: .42);

  value.map(
    (String a) => 42,
  );
}
''',
        },
        (r) => r.findLibraryByName('main'),
      );

      final errorResult =
          await main.session.getErrors('/freezed/test/integration/main.dart');

      expect(errorResult.errors, isNotEmpty);
    });
  });

  group('maybeWhen', () {
    test('returns callback result if has callback', () {
      var value = SwitchTest('a');

      expect(
        value.maybeMap((value) => '${value.a} default',
            orElse: () => throw Error()),
        'a default',
      );

      value = SwitchTest.first('a', b: false, d: .42);

      expect(
        value.maybeMap(
          null,
          first: (SwitchTest1 value) => '${value.a} ${value.b} ${value.d}',
          orElse: () => throw Error(),
        ),
        'a false 0.42',
      );

      value = SwitchTest.second('a', 21, 0.42);

      expect(
        value.maybeMap(
          null,
          second: (SwitchTest2 value) => '${value.a} ${value.c} ${value.d}',
          orElse: () => throw Error(),
        ),
        'a 21 0.42',
      );
    });

    test('assert orElse is passed', () {
      var value = SwitchTest('a');

      expect(
        () => value.maybeMap((a) => '$a default', orElse: null),
        throwsA(isA<AssertionError>()),
      );

      value = SwitchTest.first('a', b: false, d: .42);

      expect(
        () => value.maybeMap(
          null,
          first: (SwitchTest1 value) => '${value.a} ${value.b} ${value.d}',
          orElse: null,
        ),
        throwsA(isA<AssertionError>()),
      );

      value = SwitchTest.second('a', 21, 0.42);

      expect(
        () => value.maybeMap(
          null,
          second: (SwitchTest2 value) => '${value.a} ${value.c} ${value.d}',
          orElse: null,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('orElse is called', () {
      var value = SwitchTest('a');

      expect(value.maybeMap(null, orElse: () => 42), 42);

      value = SwitchTest.first('a', b: false, d: .42);

      expect(value.maybeMap(null, orElse: () => 42), 42);

      value = SwitchTest.second('a', 21, 0.42);

      expect(value.maybeMap(null, orElse: () => 42), 42);
    });

    test('named parameters are not required', () async {
      final main = await resolveSources(
        {
          'freezed|test/integration/main.dart': r'''
library main;
import 'multiple_constructors.dart';

void main() {
  final value = SwitchTest('a');

  value.maybeMap(null, orElse: () => 42);
}
''',
        },
        (r) => r.findLibraryByName('main'),
      );

      final errorResult =
          await main.session.getErrors('/freezed/test/integration/main.dart');

      expect(errorResult.errors, isEmpty);
    });

    test('orElse is required', () async {
      final main = await resolveSources(
        {
          'freezed|test/integration/main.dart': r'''
library main;
import 'multiple_constructors.dart';

void main() {
  final value = SwitchTest('a');

  value.maybeMap(null);
}
''',
        },
        (r) => r.findLibraryByName('main'),
      );

      final errorResult =
          await main.session.getErrors('/freezed/test/integration/main.dart');

      expect(errorResult.errors, isNotEmpty);
    });

    test('when is not marked @required', () async {
      final main = await resolveSources(
        {
          'freezed|test/integration/main.dart': r'''
library main;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'multiple_constructors.dart';

void main() {
  final value = RequiredParams(a: 'a');

  value.when((a) => a, second: (b) => b);
}

void redundant(@required String test) {
}
''',
        },
        (r) => r.findLibraryByName('main'),
      );

      // first make sure that the redundant @required annotation
      // actually produces a warning.
      final mainErrorResult =
          await main.session.getErrors('/freezed/test/integration/main.dart');
      expect(mainErrorResult.errors, hasLength(1));
      expect(mainErrorResult.errors.first.message, contains('Redundant'));

      // Now make sure the warning is not produced in the generated files.
      final errorResult = await main.session.getErrors(
          '/freezed/test/integration/multiple_constructors.freezed.dart');

      expect(errorResult.errors, isEmpty);
    });
  });
}
