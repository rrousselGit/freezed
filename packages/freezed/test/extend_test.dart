import 'package:test/test.dart';

import 'integration/extend.dart';

void main() {
  test('Calls super', () {
    expect(Subclass2(1, 2), Subclass2(1, 2));
    expect(Subclass2(1, 1), isNot(Subclass2(1, 2)));
    expect(Subclass2(2, 2), isNot(Subclass2(1, 2)));

    expect(Subclass2(1, 2).hashCode, Subclass2(1, 2).hashCode);
    expect(Subclass2(1, 1).hashCode, isNot(Subclass2(1, 2).hashCode));
    expect(Subclass2(2, 2).hashCode, isNot(Subclass2(1, 2).hashCode));
  });

  test('== calls super and compares child field; hashCode combines both', () {
    final sameFieldsFirst = Subclass2(1, 2);
    final sameFieldsSecond = Subclass2(1, 2);

    final differentSuperField = Subclass2(1, 3);
    final differentChildField = Subclass2(9, 2);

    expect(sameFieldsFirst, sameFieldsSecond);
    expect(sameFieldsFirst, isNot(differentSuperField));
    expect(sameFieldsFirst, isNot(differentChildField));

    expect(sameFieldsFirst.hashCode, sameFieldsSecond.hashCode);
    expect(sameFieldsFirst.hashCode == differentSuperField.hashCode, isFalse);
    expect(sameFieldsFirst.hashCode == differentChildField.hashCode, isFalse);
  });

  test('== uses super== AND child field; hashCode uses child fields', () {
    final equalFirst = Subclass3(1);
    final equalSecond = Subclass3(1);
    final differentChild = Subclass3(2);

    expect(equalFirst, equalSecond);
    expect(equalFirst, isNot(differentChild));

    expect(equalFirst.hashCode, equalSecond.hashCode);
    expect(equalFirst.hashCode == differentChild.hashCode, isFalse);
  });

  test('copyWith/toString affect child field', () {
    final original = Subclass3(3);
    final updated = original.copyWith(value: 4);
    expect(updated, Subclass3(4));
    expect(updated.toString(), contains('value: 4'));
  });

  test('== depends on child; hashCode includes super.hashCode and child', () {
    final equalFirst = Subclass4(1);
    final equalSecond = Subclass4(1);
    final differentChild = Subclass4(2);

    expect(equalFirst, equalSecond);
    expect(equalFirst, isNot(differentChild));

    expect(equalFirst.hashCode, equalSecond.hashCode);
    expect(equalFirst.hashCode == differentChild.hashCode, isFalse);
  });

  test('copyWith/toString affect child field', () {
    final original = Subclass4(9);
    final updated = original.copyWith(value: 11);
    expect(updated, Subclass4(11));
    expect(updated.toString(), contains('value: 11'));
  });

  test(
    'copyWith includes root, mid, leaf, finalValue and updates independently',
    () {
      final initial = const SubclassFinal(
        root: 1,
        mid: 2,
        leaf: 3,
        finalValue: 4,
      );
      final updatedRoot = initial.copyWith(root: 10);
      final updatedMid = updatedRoot.copyWith(mid: 20);
      final updatedLeaf = updatedMid.copyWith(leaf: 30);
      final updatedFinalValue = updatedLeaf.copyWith(finalValue: 40);

      expect(
        updatedRoot,
        const SubclassFinal(root: 10, mid: 2, leaf: 3, finalValue: 4),
      );
      expect(
        updatedMid,
        const SubclassFinal(root: 10, mid: 20, leaf: 3, finalValue: 4),
      );
      expect(
        updatedLeaf,
        const SubclassFinal(root: 10, mid: 20, leaf: 30, finalValue: 4),
      );
      expect(
        updatedFinalValue,
        const SubclassFinal(root: 10, mid: 20, leaf: 30, finalValue: 40),
      );
    },
  );

  test('toString shows root, mid, leaf, finalValue', () {
    final stringified = const SubclassFinal(
      root: 1,
      mid: 2,
      leaf: 3,
      finalValue: 4,
    ).toString();
    expect(stringified, contains('root: 1'));
    expect(stringified, contains('mid: 2'));
    expect(stringified, contains('leaf: 3'));
    expect(stringified, contains('finalValue: 4'));
  });

  test('==/hashCode differentiate changes at any level', () {
    final baseline = const SubclassFinal(
      root: 1,
      mid: 2,
      leaf: 3,
      finalValue: 4,
    );
    expect(
      baseline,
      const SubclassFinal(root: 1, mid: 2, leaf: 3, finalValue: 4),
    );
    expect(
      baseline,
      isNot(const SubclassFinal(root: 9, mid: 2, leaf: 3, finalValue: 4)),
    );
    expect(
      baseline,
      isNot(const SubclassFinal(root: 1, mid: 9, leaf: 3, finalValue: 4)),
    );
    expect(
      baseline,
      isNot(const SubclassFinal(root: 1, mid: 2, leaf: 9, finalValue: 4)),
    );
    expect(
      baseline,
      isNot(const SubclassFinal(root: 1, mid: 2, leaf: 3, finalValue: 9)),
    );

    expect(
      baseline.hashCode ==
          const SubclassFinal(root: 1, mid: 2, leaf: 3, finalValue: 4).hashCode,
      isTrue,
    );
    expect(
      baseline.hashCode ==
          const SubclassFinal(root: 9, mid: 2, leaf: 3, finalValue: 4).hashCode,
      isFalse,
    );
    expect(
      baseline.hashCode ==
          const SubclassFinal(root: 1, mid: 9, leaf: 3, finalValue: 4).hashCode,
      isFalse,
    );
    expect(
      baseline.hashCode ==
          const SubclassFinal(root: 1, mid: 2, leaf: 9, finalValue: 4).hashCode,
      isFalse,
    );
    expect(
      baseline.hashCode ==
          const SubclassFinal(root: 1, mid: 2, leaf: 3, finalValue: 9).hashCode,
      isFalse,
    );
  });
}
