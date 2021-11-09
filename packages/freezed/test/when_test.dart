// ignore_for_file: prefer_const_constructors, omit_local_variable_types
import 'package:analyzer/dart/analysis/results.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'common.dart';
import 'integration/multiple_constructors.dart';

void main() {
  group('when', () {
    test('works with no default ctr', () {
      var value = NoDefault.first('a');

      expect(
        value.when(
          first: (String a) => '$a first',
          second: (String a) => throw Error(),
        ),
        'a first',
      );

      value = NoDefault.second('a');

      expect(
        value.when(
          first: (String a) => throw Error(),
          second: (String a) => '$a second',
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

  value.when(
    (String a) {},
    first: (String a, bool? b, double? d) {},
    second: (String a, int? c, double? d) {},
  );
}
'''), completes);

        await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final value = SwitchTest('a');

  value.when(
    (String a) {},
    first: null,
    second: (String value) {},
  );
}
'''), throwsCompileError);

        await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final value = SwitchTest('a');

  value.when(
    null,
    first: (String value) {},
    second: (String value) {},
  );
}
'''), throwsCompileError);

        await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final value = SwitchTest('a');

  value.when(
    (String a) {},
    first: (String value) {},
    second: null,
  );
}
'''), throwsCompileError);
      });

      test('calls default callback', () {
        final value = SwitchTest('a');

        expect(
          value.when(
            (String a) => '$a 42',
            first: (String a, bool? b, double? d) => throw Error(),
            second: (String a, int? c, double? d) => throw Error(),
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
  value.when(
    (String a) {},
    first: (String a, bool? b, double? d) {},
    second: (String a, int? c, double? d) {},
  );
}
'''), completes);

        await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final value = SwitchTest.first('a');

  value.when(
    (String a) {},
    first: null,
    second: (String value) {},
  );
}
'''), throwsCompileError);

        await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final value = SwitchTest.first('a');

  value.when(
    null,
    first: (String value) {},
    second: (String value) {},
  );
}
'''), throwsCompileError);

        await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final value = SwitchTest.first('a');

  value.when(
    (String a) {},
    first: (String value) {},
    second: null,
  );
}
'''), throwsCompileError);
      });

      test('calls first callback', () {
        final value = SwitchTest.first('a', b: false, d: .42);

        expect(
          value.when(
            (String a) => throw Error(),
            first: (String a, bool? b, double? d) => '$a $b $d',
            second: (String a, int? c, double? d) => throw Error(),
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
  value.when(
    (String a) {},
    first: (String a, bool? b, double? d) {},
    second: (String a, int? c, double? d) {},
  );
}
'''), completes);

        await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final value = SwitchTest.second('a');

  value.when(
    (String a) {},
    first: null,
    second: (String value) {},
  );
}
'''), throwsCompileError);

        await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final value = SwitchTest.second('a');

  value.when(
    null,
    first: (String value) {},
    second: (String value) {},
  );
}
'''), throwsCompileError);

        await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  final value = SwitchTest.second('a');

  value.when(
    (String a) {},
    first: (String value) {},
    second: null,
  );
}
'''), throwsCompileError);
      });

      test('calls second callback', () {
        final value = SwitchTest.second('a', 21, .42);

        expect(
          value.when(
            (String a) => throw Error(),
            first: (String a, bool? b, double? d) => throw Error(),
            second: (String a, int? c, double? d) => '$a $c $d',
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

  value.when(
    (String a) => 42,
  );
}
''',
        },
        (r) => r.findLibraryByName('main'),
      );

      final errorResult = await main!.session
          .getErrors('/freezed/test/integration/main.dart') as ErrorsResult;

      expect(errorResult.errors, isNotEmpty);
    });
  });

  group('maybeWhen', () {
    test('returns callback result if has callback', () {
      var value = SwitchTest('a');

      expect(
        value.maybeWhen(
          (String a) => '$a default',
          orElse: () => throw Error(),
        ),
        'a default',
      );

      value = SwitchTest.first('a', b: false, d: .42);

      expect(
        value.maybeWhen(
          null,
          first: (a, b, d) => '$a $b $d',
          orElse: () => throw Error(),
        ),
        'a false 0.42',
      );

      value = SwitchTest.second('a', 21, 0.42);

      expect(
        value.maybeWhen(
          null,
          second: (a, c, d) => '$a $c $d',
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

  value.maybeWhen(
    (String a) {},
    orElse: () {},
  );
}
'''), completes);

      await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  var value = SwitchTest('a');

  value.maybeWhen(
    (String a) => '$a default',
    orElse: null,
  );
}
'''), throwsCompileError);

      await expectLater(compile(r'''
import 'multiple_constructors.dart';

void main() {
  var value = SwitchTest('a');

  value.maybeWhen(
    (String a) => '$a default',
    orElse: null,
  );
}
'''), throwsCompileError);
    });

    test('orElse is called', () {
      var value = SwitchTest('a');

      expect(value.maybeWhen(null, orElse: () => 42), 42);

      value = SwitchTest.first('a', b: false, d: .42);

      expect(value.maybeWhen(null, orElse: () => 42), 42);

      value = SwitchTest.second('a', 21, 0.42);

      expect(value.maybeWhen(null, orElse: () => 42), 42);
    });

    test('named parameters are not required', () async {
      final main = await resolveSources(
        {
          'freezed|test/integration/main.dart': r'''
library main;
import 'multiple_constructors.dart';

void main() {
  final value = SwitchTest('a');

  value.maybeWhen(null, orElse: () => 42);
}
''',
        },
        (r) => r.findLibraryByName('main'),
      );

      final errorResult = await main!.session
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

  value.maybeWhen(null);
}
''',
        },
        (r) => r.findLibraryByName('main'),
      );

      final errorResult = await main!.session
          .getErrors('/freezed/test/integration/main.dart') as ErrorsResult;

      expect(errorResult.errors, isNotEmpty);
    });
  });

  group('whenOrNull', () {
    test('has all parameters as optional', () {
      expect(NoDefault.first('a').whenOrNull(), null);
      expect(NoDefault.second('a').whenOrNull(), null);
    });

    test('calls callback on matching constructor', () {
      expect(
        NoDefault.first('a').whenOrNull(first: (v) => v),
        'a',
      );

      expect(
        NoDefault.second('a').whenOrNull(second: (v) => v),
        'a',
      );
    });
  });
}
