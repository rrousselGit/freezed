// ignore_for_file: prefer_const_constructors, omit_local_variable_types
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';
import 'package:matcher/matcher.dart';

import 'common.dart';
import 'integration/single_class_constructor.dart';

Future<void> main() async {
  test('toString includes the constructor name', () {
    expect('${SingleNamedCtor.named(42)}', 'SingleNamedCtor.named(a: 42)');
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
import 'single_class_constructor.dart';

void main() {
  MyClass().copyWith(a: '42', b: 42);
}
'''), completes);
      await expectLater(compile(r'''
import 'single_class_constructor.dart';

void main() {
  MyClass().copyWith(a: Future.value('42'));
}
'''), throwsCompileError);
      await expectLater(compile(r'''
import 'single_class_constructor.dart';

void main() {
  MyClass().copyWith(b: Future.value(42));
}
'''), throwsCompileError);
    });

    test('redirected class overrides copyWith return type', () {
      WhateverIWant value = WhateverIWant().copyWith(a: '42', b: 42);

      expect(value.a, '42');
      expect(value.b, 42);
    });

    test("redirected class's copyWith cannot receive Future", () async {
      await expectLater(compile(r'''
import 'single_class_constructor.dart';

void main() {
  WhateverIWant().copyWith(a: '42', b: 42);
}
'''), completes);
      await expectLater(compile(r'''
import 'single_class_constructor.dart';

void main() {
  WhateverIWant().copyWith(a: Future.value('a'));
}
'''), throwsCompileError);
      await expectLater(compile(r'''
import 'single_class_constructor.dart';

void main() {
  WhateverIWant().copyWith(b: Future.value(42));
}
'''), throwsCompileError);
    });
  });
  test('can access redirect class', () {
    expect(MyClass(), isA<WhateverIWant>());

    expect(
      WhateverIWant(a: 'a', b: 42),
      MyClass(a: 'a', b: 42),
    );
  });
  test('mixed param', () {
    var value = MixedParam('a', b: 42);

    expect(value.a, 'a');
    expect(value.b, 42);

    value = WhateverMixedParam('b', b: 21);

    expect(value.a, 'b');
    expect(value.b, 21);
  });
  test('positional mixed param', () {
    var value = PositionalMixedParam('a');
    expect(value.a, 'a');
    expect(value.b, null);

    value = PositionalMixedParam('a', 42);
    expect(value.a, 'a');
    expect(value.b, 42);

    value = WhateverPositionalMixedParam('a');
    expect(value.a, 'a');
    expect(value.b, null);

    value = WhateverPositionalMixedParam('a', 42);
    expect(value.a, 'a');
    expect(value.b, 42);
  });
  test('required parameters are transmited to redirected constructor', () async {
    final main = await resolveSources({
      'immutable|test/integration/main.dart': '''
library main;

import 'single_class_constructor.dart';

void main() {
  WhateverRequired();
}
    ''',
    }, (r) => r.findLibraryByName('main'));

    final errorResult = await main.session.getErrors('/immutable/test/integration/main.dart');

    expect(
      errorResult.errors.map((e) => e.toString()),
      anyElement(contains("The parameter 'a' is required")),
    );
  });

  test('empty class still equals', () {
    expect(Empty(), Empty());
    expect(Empty(), isNot(Empty2()));
    expect(Empty2(), Empty2());
  });

  test('empty hashCode', () {
    expect(Empty().hashCode, Empty().hashCode);

    expect(Empty().hashCode, isNot(Empty2().hashCode));
  });
  test('empty toString', () {
    expect('${Empty()}', 'Empty()');
    expect('${Empty2()}', 'Empty2()');
  });
}
