// Explicit types verify the generated copyWith return types.
// ignore_for_file: omit_local_variable_types

import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'common.dart';
import 'integration/primary_constructor.dart';

void main() {
  group('Primary Constructor support', () {
    test('standard primary constructor compiles and has copyWith / equality / toString', () {
      final a = Example(42, another: 10);
      expect(a.field, 42);
      expect(a.another, 10);

      final b = a.copyWith(field: 100);
      expect(b.field, 100);
      expect(b.another, 10);

      expect(a, isNot(equals(b)));
      expect(a, equals(Example(42, another: 10)));
      expect(a.toString(), 'Example(field: 42, another: 10)');
    });

    test('private primary constructor with body factory redirects compiles and works', () {
      final a = ExampleWithPrivate(10, another: 20);
      expect(a.field, 10);
      expect(a.another, 20);
      expect(a.getter, 20);

      final b = a.copyWith(another: null);
      expect(b.field, 10);
      expect(b.another, isNull);

      expect(a, isNot(equals(b)));
      expect(a, equals(ExampleWithPrivate(10, another: 20)));
      expect(a.toString(), 'ExampleWithPrivate(field: 10, another: 20)');
    });

    test('primary constructor with var compiles, allows mutation, copyWith, and toString', () {
      final a = ExampleWithVar(42, another: 10);
      expect(a.field, 42);
      expect(a.another, 10);

      a.field = 100;
      expect(a.field, 100);

      final b = a.copyWith(field: 200);
      expect(b.field, 200);
      expect(b.another, 10);

      expect(a.toString(), 'ExampleWithVar(field: 100, another: 10)');
    });

    test('primary constructor with this.field compiles and has copyWith / equality / toString', () {
      final a = ExampleWithThis(42, another: 10);
      expect(a.field, 42);
      expect(a.another, 10);

      final b = a.copyWith(field: 100);
      expect(b.field, 100);
      expect(b.another, 10);

      expect(a, isNot(equals(b)));
      expect(a, equals(ExampleWithThis(42, another: 10)));
      expect(a.toString(), 'ExampleWithThis(field: 42, another: 10)');
    });

    test('primary constructor with non-field freezed class parameter compiles without invalid copyWith', () {
      final child = Child(42);
      expect(child.value, 42);

      final holder = Holder(child);
      expect(holder.toString(), 'Holder()');
    });

    test('primary constructor with getters works '
        'without generating subclass', () {
      final item = PrimaryWithGetter('hello');
      expect(item.name, 'hello');
      expect(item.nameLength, 5);

      final updated = item.copyWith(name: 'world');
      expect(updated.name, 'world');
      expect(updated.nameLength, 5);
    });

    test('primary constructor with super parameter (inheritance) works and has copyWith', () {
      final sub = SubclassWithSuper(10, 'hello');
      expect(sub.parentField, 10);
      expect(sub.subField, 'hello');

      final updated = sub.copyWith(parentField: 20, subField: 'world');
      expect(updated.parentField, 20);
      expect(updated.subField, 'world');
      expect(
        updated.toString(),
        'SubclassWithSuper(parentField: 20, subField: world)',
      );
    });

    test('primary constructor with union works with when and map', () {
      const first = PrimaryUnion.first(10, 'first');
      const second = PrimaryUnion.second(20, 42);

      final whenFirst = first.when(
        first: (common, firstValue) => '$common-$firstValue',
        second: (common, secondValue) => '$common-$secondValue',
      );
      expect(whenFirst, '10-first');

      final mapSecond = second.map(
        first: (value) => 'first',
        second: (value) => 'second-${value.secondValue}',
      );
      expect(mapSecond, 'second-42');
    });

    test('optional unstored super arguments are not readable properties', () {
      final value = OptionalUnstoredSuper(42, ignored: 7);
      expect(value, OptionalUnstoredSuper(42, ignored: 8));
      expect(value.hashCode, OptionalUnstoredSuper(42).hashCode);
      expect(value.toString(), 'OptionalUnstoredSuper(value: 42)');
      expect(value.copyWith().value, 42);
      expect(value.copyWith(value: 99).value, 99);
    });

    test('nullable this field can be preserved, replaced, and cleared', () {
      expect(NullableThis(null).copyWith().value, isNull);
      expect(NullableThis(42).copyWith().value, 42);
      expect(NullableThis(null).copyWith(value: 42).value, 42);
      expect(NullableThis(42).copyWith(value: null).value, isNull);
    });

    test('nullable super field can be preserved, replaced, and cleared', () {
      expect(NullableSuper(null).copyWith().value, isNull);
      expect(NullableSuper(42).copyWith().value, 42);
      expect(NullableSuper(null).copyWith(value: 42).value, 42);
      expect(NullableSuper(42).copyWith(value: null).value, isNull);
    });

    test('copyWith preserves optional positional argument positions', () {
      final value = OptionalPositionalGap(0, 42);
      expect(value.copyWith().value, 42);
      expect(value.copyWith(value: 99).value, 99);
      expect(OptionalPositionalGap().copyWith(value: 99).value, 99);
      expect(NullablePositionalGap(1, 'hello').copyWith().value, 'hello');
      expect(NullablePositionalGap().copyWith(value: 'world').value, 'world');
    });

    test('copyWith uses inherited defaults for unstored super arguments', () {
      final value = InheritedPositionalDefault(42, 10);
      expect(value.received, 42);

      final unchanged = value.copyWith();
      expect(unchanged.value, 10);
      expect(unchanged.received, 7);

      final updated = value.copyWith(value: 20);
      expect(updated.value, 20);
      expect(updated.received, 7);
      expect(InheritedPositionalDefault().copyWith().received, 7);

      final overridden = OverriddenPositionalDefault(
        42,
        10,
      ).copyWith(value: 20);
      expect(overridden.value, 20);
      expect(overridden.received, 9);
    });

    test('generic primary fields support copying and collection equality', () {
      final value = Generic<int>([1, 2], another: {3, 4});
      final equal = Generic<int>([1, 2], another: {4, 3});
      expect(value, equal);
      expect(value.hashCode, equal.hashCode);
      expect(value, isNot(Generic<int>([2, 1], another: {3, 4})));

      final Generic<int> unchanged = value.copyWith();
      expect(unchanged, value);
      final Generic<int> updated = value.copyWith(field: [5], another: {6});
      expect(updated.field, [5]);
      expect(updated.another, {6});
      expect(value.field, [1, 2]);
      expect(value.another, {3, 4});
      expect(Generic<String>(['hello']).copyWith(field: ['world']).field, [
        'world',
      ]);
    });

    test('primary fields support nested deep copy', () {
      final value = PrimaryNested(Child(1), optionalChild: Child(2));
      final copyWith = value.copyWith;
      final PrimaryNested updated = copyWith.child(value: 10);
      expect(updated.child.value, 10);
      expect(updated.optionalChild, value.optionalChild);
      expect(value.child.value, 1);

      final PrimaryNested optionalUpdated = copyWith.optionalChild!(value: 20);
      expect(optionalUpdated.optionalChild!.value, 20);
      expect(optionalUpdated.child, value.child);
      expect(value.optionalChild!.value, 2);
      expect(value.copyWith(optionalChild: null).optionalChild, isNull);
      final emptyCopyWith = PrimaryNested(Child(1)).copyWith;
      expect(emptyCopyWith.optionalChild, isNull);
    });

    test('nested deep copy has a statically typed API', () async {
      await compile('''
import 'primary_constructor.dart';

void main() {
  final value = PrimaryNested(Child(1), optionalChild: Child(2));
  final PrimaryNested updated = value.copyWith.child(value: 10);
  final PrimaryNested optionalUpdated = value.copyWith.optionalChild!(value: 20);
}
''');
    });

    test('private primary fields are forwarded by all union constructors', () {
      const PrimaryFieldsUnion first = PrimaryFieldsUnion.first(10, 'hello');
      const PrimaryFieldsUnion second = PrimaryFieldsUnion.second(20, 42);
      expect(first.common, 10);
      expect(first.doubled, 20);
      expect(second.common, 20);
      expect(second.doubled, 40);
      expect(first, const PrimaryFieldsUnion.first(10, 'hello'));
      expect(
        first.hashCode,
        const PrimaryFieldsUnion.first(10, 'hello').hashCode,
      );
      expect(first, isNot(const PrimaryFieldsUnion.first(11, 'hello')));

      final updatedFirst = first.copyWith(common: 30);
      final updatedSecond = second.copyWith(common: 40);
      expect(updatedFirst, const PrimaryFieldsUnion.first(30, 'hello'));
      expect(updatedSecond, const PrimaryFieldsUnion.second(40, 42));
      expect(updatedFirst.doubled, 60);
      expect(updatedSecond.doubled, 80);
      expect(
        first.when(
          first: (common, value) => '$common:$value',
          second: (common, value) => '$common:$value',
        ),
        '10:hello',
      );
      expect(
        second.map(
          first: (value) => value.doubled,
          second: (value) => value.doubled,
        ),
        40,
      );
    });

    test(
      'analyzer asserts no _MyClass generated for primary constructor class',
      () async {
        final library = await resolveSources(
          {'freezed|test/integration/primary_constructor.dart': useAssetReader},
          (r) => r.libraries.firstWhere(
            (e) =>
                e.firstFragment.source.fullName ==
                '/freezed/test/integration/primary_constructor.dart',
          ),
          readAllSourcesFromFilesystem: true,
        );

        final classNames = library.classes.map((e) => e.name).toSet();

        expect(classNames, isNot(contains('_Example')));
        expect(classNames, isNot(contains('_PrimaryWithGetter')));
        expect(classNames, isNot(contains('_ExampleWithThis')));
        expect(classNames, isNot(contains('_Generic')));
        expect(classNames, contains('_ExampleWithPrivate'));
      },
    );
  });
}
