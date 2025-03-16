// ignore_for_file: prefer_const_constructors, omit_local_variable_types, deprecated_member_use_from_same_package
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'common.dart';
import 'integration/alias.dart';
import 'integration/single_class_constructor.dart';
import 'nullable_test.dart';

class MyObject {
  final void Function() didEqual;

  MyObject(this.didEqual);

  @override
  bool operator ==(Object other) {
    didEqual();
    return other.runtimeType == runtimeType;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

Future<void> main() async {
  Future<LibraryElement> analyze() {
    return resolveSources(
      {
        'freezed|test/integration/single_class_constructor.dart':
            useAssetReader,
      },
      (r) => r.libraries.firstWhere((e) {
        return e.source.fullName ==
            '/freezed/test/integration/single_class_constructor.dart';
      }),
    );
  }

  test('CustomSetEqual', () {
    expect(
      CustomSetEqual(CustomSet({42}))..dartSet.add(21),
      CustomSetEqual(CustomSet({42, 21})),
      reason: 'Custom lists are not wrapped in an UnmodifiableSetView',
    );

    expect(CustomSetEqual(CustomSet({42})), CustomSetEqual(CustomSet({42})));

    expect(
      CustomSetEqual(CustomSet({42})).hashCode,
      CustomSetEqual(CustomSet({42})).hashCode,
    );
  });

  test('SetEqual', () {
    expect(SetEqual({42})..dartSet.add(21), SetEqual({42, 21}));

    expect(SetEqual({42}), SetEqual({42}));
    expect(SetEqual({42}).hashCode, SetEqual({42}).hashCode);
  });

  test('UnmodifiableSetEqual', () {
    expect(
      () => UnmodifiableSetEqual({42})..dartSet.add(21),
      throwsUnsupportedError,
    );

    expect(UnmodifiableSetEqual({42}), UnmodifiableSetEqual({42}));
    expect(
      UnmodifiableSetEqual({42}).hashCode,
      UnmodifiableSetEqual({42}).hashCode,
    );

    final immutableCollection = UnmodifiableSetEqual({42}).dartSet;
    expect(
      UnmodifiableSetEqual(immutableCollection).dartSet,
      same(immutableCollection),
    );
  });

  test('CustomListEqual', () {
    expect(
      CustomListEqual(CustomList([42]))..list.add(21),
      CustomListEqual(CustomList([42, 21])),
      reason: 'Custom lists are not wrapped in an UnmodifiableListView',
    );

    expect(
      CustomListEqual(CustomList([42])),
      CustomListEqual(CustomList([42])),
    );

    expect(
      CustomListEqual(CustomList([42])).hashCode,
      CustomListEqual(CustomList([42])).hashCode,
    );
  });

  test('ListEqual', () {
    expect(ListEqual([42])..list.add(21), ListEqual([42, 21]));

    expect(ListEqual([42]), ListEqual([42]));
    expect(ListEqual([42]).hashCode, ListEqual([42]).hashCode);
  });

  test('UnmodifiableListEqual', () {
    expect(
      () => UnmodifiableListEqual([42])..list.add(21),
      throwsUnsupportedError,
    );

    expect(UnmodifiableListEqual([42]), UnmodifiableListEqual([42]));
    expect(
      UnmodifiableListEqual([42]).hashCode,
      UnmodifiableListEqual([42]).hashCode,
    );

    final immutableCollection = UnmodifiableListEqual([42]).list;
    expect(
      UnmodifiableListEqual(immutableCollection).list,
      same(immutableCollection),
    );
  });

  test('CustomMapEqual', () {
    expect(
      CustomMapEqual(CustomMap({'a': 42}))..map['b'] = 21,
      CustomMapEqual(CustomMap({'a': 42, 'b': 21})),
      reason: 'Custom lists are not wrapped in an UnmodifiableMapView',
    );

    expect(
      CustomMapEqual(CustomMap({'a': 42})),
      CustomMapEqual(CustomMap({'a': 42})),
    );

    expect(
      CustomMapEqual(CustomMap({'a': 42})).hashCode,
      CustomMapEqual(CustomMap({'a': 42})).hashCode,
    );
  });

  test('MapEqual', () {
    expect(MapEqual({'a': 42})..map['b'] = 21, MapEqual({'a': 42, 'b': 21}));

    expect(MapEqual({'a': 42}), MapEqual({'a': 42}));
    expect(MapEqual({'a': 42}).hashCode, MapEqual({'a': 42}).hashCode);
  });

  test('UnmodifiableMapEqual', () {
    expect(
      () => UnmodifiableMapEqual({'a': 42})..map['b'] = 21,
      throwsUnsupportedError,
    );

    expect(UnmodifiableMapEqual({'a': 42}), UnmodifiableMapEqual({'a': 42}));
    expect(
      UnmodifiableMapEqual({'a': 42}).hashCode,
      UnmodifiableMapEqual({'a': 42}).hashCode,
    );

    final immutableCollection = UnmodifiableMapEqual({'a': 42}).map;
    expect(
      UnmodifiableMapEqual(immutableCollection).map,
      same(immutableCollection),
    );
  });

  test('Subclass', () {
    expect(Subclass(42), Subclass(42));

    expect(Subclass(42).hashCode, Subclass(42).hashCode);

    expect(Subclass(42).copyWith(value: 21), Subclass(21));

    expect(Subclass(42).toString(), 'Subclass(value: 42)');
  });

  test('WithAlias', () {
    // ignore: unused_local_variable
    Some<Complex<Type>> value = WithAliasFirst();
  });

  test('ImplementsAlias', () {
    // ignore: unused_local_variable
    Some<Complex<Type>> value = ImplementsAliasFirst();
  });

  test('Alias', () {
    expect(Alias(), Alias());
  });

  test('Regression 131', () {
    expect(Regression131('foo').toString(), 'Regression131(versionName: foo)');
  });

  test('documentation', () async {
    final singleClassLibrary = await analyze();

    final doc = singleClassLibrary.topLevelElements
        .firstWhere((e) => e.name == 'Doc') as ClassElement;

    expect(
      doc.mixins.first.accessors.where(
        (e) => e.name != 'copyWith' && e.name != 'hashCode',
      ),
      [
        isA<PropertyAccessorElement>()
            .having((e) => e.name, 'name', 'positional')
            .having((e) => e.documentationComment, 'doc', '''
/// Multi
/// line
/// positional'''),
        isA<PropertyAccessorElement>() //
            .having((e) => e.name, 'name', 'named')
            .having(
              (e) => e.documentationComment,
              'doc',
              '/// Single line named',
            ),
        isA<PropertyAccessorElement>() //
            .having((e) => e.name, 'name', 'simple')
            .having((e) => e.documentationComment, 'doc', null),
      ],
    );
  });

  test('Assertion', () {
    Assertion(1, 2);

    expect(() => Assertion(-1, 1), throwsAssertionError);
    expect(() => Assertion(1, -1), throwsAssertionError);
  });

  test('deep copy of recursive classes', () {
    final value = Product(name: 'foo', parent: Product(name: 'bar'));

    expect(
      value.copyWith.parent!(name: 'baz'),
      Product(name: 'foo', parent: Product(name: 'baz')),
    );

    final value2 = Product(
      name: 'foo',
      parent: Product(name: 'bar', parent: Product(name: 'baz')),
    );

    expect(
      value2.copyWith.parent!.parent!(name: 'quaz'),
      Product(
        name: 'foo',
        parent: Product(name: 'bar', parent: Product(name: 'quaz')),
      ),
    );
  });

  group('@Default applied', () {
    test('int', () {
      expect(IntDefault(), IntDefault(42));
    });

    test('double', () {
      expect(DoubleDefault(), DoubleDefault(42));
    });

    test('String', () {
      expect(StringDefault(), StringDefault('42'));

      expect(SpecialStringDefault(), SpecialStringDefault('(1)[2]{3}'));
    });

    test('List', () {
      expect(ListDefault(), ListDefault([42]));
    });

    test('Type', () {
      expect(TypeDefault(), TypeDefault(TypeDefault));
    });
  });

  test('complex late', () {
    final complex = ComplexLate([0, 1, 2, 3, 4]);

    expect(complex.odd, [1, 3]);

    expect(identical(complex.odd, complex.odd), isTrue);
  });

  test('toString shows final properties, late properties and getters', () {
    final value = AllProperties(42);

    expect(value.toString(), 'AllProperties(value: 42)');
  });

  test('late can return null and still be called only once', () {
    int callCount = 0;
    final value = Late2(() {
      callCount++;
      return null;
    });

    expect(callCount, 0);
    expect(value.first, isNull);
    expect(callCount, 1);
    expect(value.first, isNull);
    expect(callCount, 1);
  });

  test('== uses identical first', () {
    var didEqual = false;
    final obj = MyObject(() => didEqual = true);
    final list = [obj];

    expect(Generic(list), Generic(list));
    expect(didEqual, isFalse);
  });

  test('does not have when', () async {
    await expectLater(
      compile(r'''
import 'single_class_constructor.dart';

void main() {
  MyClass().when;
}
'''),
      throwsCompileError,
    );
  });

  test('does not have maybeWhen', () async {
    await expectLater(
      compile(r'''
import 'single_class_constructor.dart';

void main() {
  MyClass().maybeWhen;
}
'''),
      throwsCompileError,
    );
  });

  test('regression 399', () async {
    await expectLater(
      compile(r'''
import 'regression399/a.dart';
import 'regression399/b.dart';

void main() {
  Regression399A(
    b: Regression399BImpl(),
  );
}
'''),
      completes,
    );

    await expectLater(
      compile(r'''
import 'regression399/a.dart';
import 'regression399/b.dart';

void main() {
  Regression399A(
    b: 42,
  );
}
'''),
      throwsCompileError,
    );
  });

  test('does not have map', () async {
    await expectLater(
      compile(r'''
import 'single_class_constructor.dart';

void main() {
  MyClass().map;
}
'''),
      throwsCompileError,
    );
  });

  test('does not have maybeMap', () async {
    await expectLater(
      compile(r'''
import 'single_class_constructor.dart';

void main() {
  MyClass().maybeMap;
}
'''),
      throwsCompileError,
    );
  });

  test('has no issue', () async {
    final singleClassLibrary = await analyze();

    final errorResult = await singleClassLibrary.session.getErrors(
      '/freezed/test/integration/single_class_constructor.freezed.dart',
    ) as ErrorsResult;

    expect(errorResult.errors, isEmpty);
  });

  test('toString includes the constructor name', () {
    expect('${SingleNamedCtor.named(42)}', 'SingleNamedCtor.named(a: 42)');
  });

  test('can be created as const', () {
    expect(identical(const MyClass(a: '42'), const MyClass(a: '42')), isTrue);
  });

  test(
    'cannot be created as const if user defined ctor is not const',
    () async {
      await expectLater(
        compile(r'''
import 'single_class_constructor.dart';

void main() {
  NoConstImpl();
}
'''),
        completes,
      );

      await expectLater(
        compile(r'''
import 'single_class_constructor.dart';

void main() {
  const NoConstImpl();
}
'''),
        throwsCompileError,
      );
    },
  );

  test('generates a property for all constructor parameters', () {
    var value = const MyClass(a: '42', b: 42);

    expect(value.a, '42');
    expect(value.b, 42);

    value = const MyClass(a: '24', b: 24);

    expect(value.a, '24');
    expect(value.b, 24);
  });

  test('hashCode', () {
    expect(MyClass(a: '42', b: 42).hashCode, MyClass(a: '42', b: 42).hashCode);
    expect(
      MyClass(a: '0', b: 42).hashCode,
      isNot(MyClass(a: '42', b: 42).hashCode),
    );
  });

  test('overrides ==', () {
    expect(MyClass(a: '42', b: 42), MyClass(a: '42', b: 42));
    expect(MyClass(a: '0', b: 42), isNot(Object()));
    expect(MyClass(a: '0', b: 42), isNot(MyClass(a: '42', b: 42)));
    expect(MyClass(a: '0', b: 42), isNot(MyClass(a: '0', b: 0)));
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
      expect(MyClass(a: '42', b: 42).copyWith(b: 24), MyClass(a: '42', b: 24));
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
      await expectLater(
        compile(r'''
import 'single_class_constructor.dart';

void main() {
  MyClass().copyWith(a: '42', b: 42);
}
'''),
        completes,
      );

      await expectLater(
        compile(r'''
import 'single_class_constructor.dart';

void main() {
  MyClass().copyWith(a: Future.value('42'));
}
'''),
        throwsCompileError,
      );

      await expectLater(
        compile(r'''
import 'single_class_constructor.dart';

void main() {
  MyClass().copyWith(b: Future.value(42));
}
'''),
        throwsCompileError,
      );
    });

    test('redirected class overrides copyWith return type', () {
      WhateverIWant value = WhateverIWant().copyWith(a: '42', b: 42);

      expect(value.a, '42');
      expect(value.b, 42);
    });

    test("redirected class's copyWith cannot receive Future", () async {
      await expectLater(
        compile(r'''
import 'single_class_constructor.dart';

void main() {
  WhateverIWant().copyWith(a: '42', b: 42);
}
'''),
        completes,
      );

      await expectLater(
        compile(r'''
import 'single_class_constructor.dart';

void main() {
  WhateverIWant().copyWith(a: Future.value('a'));
}
'''),
        throwsCompileError,
      );

      await expectLater(
        compile(r'''
import 'single_class_constructor.dart';

void main() {
  WhateverIWant().copyWith(b: Future.value(42));
}
'''),
        throwsCompileError,
      );
    });
  });

  test('can access redirect class', () {
    expect(MyClass(), isA<WhateverIWant>());

    expect(WhateverIWant(a: 'a', b: 42), MyClass(a: 'a', b: 42));
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

  test(
    'required parameters are transmitted to redirected constructor',
    () async {
      final main = await resolveSources({
        'freezed|test/integration/main.dart': '''
library main;

import 'single_class_constructor.dart';

void main() {
  WhateverRequired();
}
    ''',
      }, (r) => r.findLibraryByName('main'));

      final errorResult = await main!.session
          .getErrors('/freezed/test/integration/main.dart') as ErrorsResult;

      expect(
        errorResult.errors.map((e) => e.toString()),
        anyElement(contains("The named parameter 'a' is required")),
      );
    },
  );

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
