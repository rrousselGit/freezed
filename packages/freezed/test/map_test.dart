// @dart=2.9

// ignore_for_file: prefer_const_constructors, omit_local_variable_types

import 'package:analyzer/dart/analysis/results.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'common.dart';
import 'integration/multiple_constructors.dart';

void main() {
  group('map', () {
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
      test("assert callbacks can't be null", () async {
        await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final value = SwitchTest('a');

  value.map(
    (SwitchTest0 a) {},
    first: (SwitchTest1 b) {},
    second: (SwitchTest2 c) {},
  );
}
'''), completes);

        await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final value = SwitchTest('a');

  value.map(
    (SwitchTest0 a) {},
    first: null,
    second: (SwitchTest2 value) {},
  );
}
'''), throwsCompileError);

        await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final value = SwitchTest('a');

  value.map(
    null,
    first: (SwitchTest1 value) {},
    second: (SwitchTest2 value) {},
  );
}
'''), throwsCompileError);

        await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final value = SwitchTest('a');

  value.map(
    (SwitchTest0 a) {},
    first: (SwitchTest1 value) {},
    second: null,
  );
}
'''), throwsCompileError);
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
      test("assert callbacks can't be null", () async {
        await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final value = SwitchTest.first('a');

  value.map(
    (SwitchTest0 a) {},
    first: (SwitchTest1 b) {},
    second: (SwitchTest2 c) {},
  );
}
'''), completes);

        await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final value = SwitchTest.first('a');

  value.map(
    (SwitchTest0 a) {},
    first: null,
    second: (SwitchTest2 value) {},
  );
}
'''), throwsCompileError);

        await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final value = SwitchTest.first('a');

  value.map(
    null,
    first: (SwitchTest1 value) {},
    second: (SwitchTest2 value) {},
  );
}
'''), throwsCompileError);

        await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final value = SwitchTest.first('a');

  value.map(
    (SwitchTest0 a) {},
    first: (SwitchTest1 value) {},
    second: null,
  );
}
'''), throwsCompileError);
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
      test("assert callbacks can't be null", () async {
        await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final value = SwitchTest.second('a');

  value.map(
    (SwitchTest0 a) {},
    first: (SwitchTest1 b) {},
    second: (SwitchTest2 c) {},
  );
}
'''), completes);

        await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final value = SwitchTest.second('a');

  value.map(
    (SwitchTest0 a) {},
    first: null,
    second: (SwitchTest2 value) {},
  );
}
'''), throwsCompileError);

        await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final value = SwitchTest.second('a');

  value.map(
    null,
    first: (SwitchTest1 value) {},
    second: (SwitchTest2 value) {},
  );
}
'''), throwsCompileError);

        await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final value = SwitchTest.second('a');

  value.map(
    (SwitchTest0 a) {},
    first: (SwitchTest1 value) {},
    second: null,
  );
}
'''), throwsCompileError);
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
    (a) => 42,
  );
}
''',
        },
        (r) => r.findLibraryByName('main'),
      );

      final errorResult = await main.session
          .getErrors('/freezed/test/integration/main.dart') as ErrorsResult;

      expect(errorResult.errors, isNotEmpty);
    });
  });

  group('maybeMap', () {
    test('returns callback result if has callback', () {
      var value = SwitchTest('a');

      expect(
        value.maybeMap(
          (value) => '${value.a} default',
          orElse: () => throw Error(),
        ),
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

    test('assert orElse is passed', () async {
      await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  var value = SwitchTest('a');

  value.maybeMap(
    (SwitchTest0 a) {},
    orElse: () {},
  );
}
'''), completes);

      await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  var value = SwitchTest('a');

  value.maybeMap(
    (SwitchTest0 a) => '$a default',
    orElse: null,
  );
}
'''), throwsCompileError);

      await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  var value = SwitchTest('a');

  value.maybeMap(
    (SwitchTest0 a) => '$a default',
    orElse: null,
  );
}
'''), throwsCompileError);
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

      final errorResult = await main.session
          .getErrors('/freezed/test/integration/main.dart') as ErrorsResult;

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

      final errorResult = await main.session
          .getErrors('/freezed/test/integration/main.dart') as ErrorsResult;

      expect(errorResult.errors, isNotEmpty);
    });
  });

  group('mapOrNull', () {
    test('has all parameters as optional', () {
      expect(NoDefault.first('a').mapOrNull(), null);
      expect(NoDefault.second('a').mapOrNull(), null);
    });

    test('calls callback on matching constructor', () {
      expect(
        NoDefault.first('a').mapOrNull(first: (v) => v),
        NoDefault.first('a'),
      );

      expect(
        NoDefault.second('a').mapOrNull(second: (v) => v),
        NoDefault.second('a'),
      );
    });
  });
}
