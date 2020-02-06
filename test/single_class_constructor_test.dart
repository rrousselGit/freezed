// ignore_for_file: prefer_const_constructors, omit_local_variable_types
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:test/test.dart';
import 'package:build_test/build_test.dart';
import 'package:matcher/matcher.dart';

import 'integration/example.dart';

Future<void> compile(String src) async {
  final main = await resolveSources({
    'immutable|test/integration/main.dart': src,
  }, (r) => r.findLibraryByName('main'));

  final errorResult = await main.session.getErrors('/immutable/test/integration/main.dart');
  final hasCompileError = errorResult.errors.any((element) => element.severity == Severity.error);

  if (hasCompileError) {
    throw Error();
  }
}

Future<void> main() async {
  group('compile utility', () {
    test('compiles', () async {
      await expectLater(compile(r'''
library main;
import 'example.dart';

void main() {
  final test = MyClass(a: 'a', b: 42);
}
'''), completes);
    });
    test('does not compile', () async {
      await expectLater(compile(r'''
library main;
import 'example.dart';

void main() {
  final test = 
}
'''), doesNotComplete);
    });
  });

  test('can be created as const', () {
    expect(identical(const MyClass(a: '42'), const MyClass(a: '42')), isTrue);
  });
  test('generates a property for all constructor parameters', () {
    var value = const MyClass(
      a: '42',
      b: 42,
    );

    expect(value.a, '42');
    expect(value.b, 42);

    value = const MyClass(
      a: '24',
      b: 24,
    );

    expect(value.a, '24');
    expect(value.b, 24);
  });
  test('hashCode', () {
    expect(
      MyClass(a: '42', b: 42).hashCode,
      MyClass(a: '42', b: 42).hashCode,
    );
    expect(
      MyClass(a: '0', b: 42).hashCode,
      isNot(MyClass(a: '42', b: 42).hashCode),
    );
  });
  test('overrides ==', () {
    expect(
      MyClass(a: '42', b: 42),
      MyClass(a: '42', b: 42),
    );
    expect(
      MyClass(a: '0', b: 42),
      isNot(Object()),
    );
    expect(
      MyClass(a: '0', b: 42),
      isNot(MyClass(a: '42', b: 42)),
    );
    expect(
      MyClass(a: '0', b: 42),
      isNot(MyClass(a: '0', b: 0)),
    );
  });
  test('toString', () {
    expect('${MyClass()}', 'MyClass(a: null, b: null)');
    expect('${MyClass(a: '42', b: 42)}', 'MyClass(a: 42, b: 42)');
  });

  group('clone', () {
    test('can clone', () {
      final value = MyClass(a: '42', b: 42);
      MyClass clone = value.copyWith();

      expect(identical(clone, value), isFalse);
      expect(clone, value);
    });
    test('clone can update values', () {
      expect(
        MyClass(a: '42', b: 42).copyWith(a: '24'),
        MyClass(a: '24', b: 42),
      );
      expect(
        MyClass(a: '42', b: 42).copyWith(b: 24),
        MyClass(a: '42', b: 24),
      );
    });
    test('clone can assign values to null', () {
      expect(
        MyClass(a: '42', b: 42).copyWith(a: null),
        MyClass(a: null, b: 42),
      );
      expect(
        MyClass(a: '42', b: 42).copyWith(b: null),
        MyClass(a: '42', b: null),
      );
    });
    test('cannot assign futures to copyWith parameters', () async {
      await expectLater(compile(r'''
library main;
import 'example.dart';

void main() {
  MyClass().copyWith(a: Future.value('42'));
}
'''), doesNotComplete);
      await expectLater(compile(r'''
library main;
import 'example.dart';

void main() {
  MyClass().copyWith(b: Future.value(42));
}
'''), doesNotComplete);
    });
  });
}
