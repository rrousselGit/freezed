import 'package:test/test.dart';

import 'integration/equal.dart';

void main() {
  test('Simple', () {
    expect(
      Simple(42),
      Simple(42),
    );
  });

  test('ListEqual', () {
    expect(
      ListEqual([1]),
      ListEqual([1]),
    );
  });

  test('MapEqual', () {
    expect(
      MapEqual({1: 1}),
      MapEqual({1: 1}),
    );
  });

  test('SetEqual', () {
    expect(
      SetEqual({1}),
      SetEqual({1}),
    );
  });

  test('IterableEqual', () {
    expect(
      IterableEqual([1]),
      IterableEqual([1]),
    );
  });

  test('ListObjectEqual', () {
    expect(
      ListObjectEqual([1]),
      ListObjectEqual([1.0]),
    );
    expect(
      ListObjectEqual([
        [1]
      ]),
      ListObjectEqual([
        [1]
      ]),
    );
  });

  test('ListDynamicEqual', () {
    expect(
      ListDynamicEqual(<dynamic>[1]),
      ListDynamicEqual(<dynamic>[1.0]),
    );
    expect(
      ListDynamicEqual(<dynamic>[
        [1]
      ]),
      ListDynamicEqual(<dynamic>[
        [1]
      ]),
    );
  });

  test('ObjectEqual', () {
    expect(
      ObjectEqual(1),
      ObjectEqual(1),
    );
    expect(
      ObjectEqual([1]),
      ObjectEqual([1]),
    );
    expect(
      ObjectEqual([
        [1]
      ]),
      ObjectEqual([
        [1]
      ]),
    );
  });

  test('DynamicEqual', () {
    expect(
      DynamicEqual(1),
      DynamicEqual(1),
    );
    expect(
      DynamicEqual([1]),
      DynamicEqual([1]),
    );
    expect(
      DynamicEqual([
        [1]
      ]),
      DynamicEqual([
        [1]
      ]),
    );
  });

  test('Generic', () {
    expect(
      Generic(42),
      Generic(42),
    );
    expect(
      Generic([1]),
      Generic([1]),
    );
    expect(
      Generic([
        [1]
      ]),
      Generic([
        [1]
      ]),
    );
  });

  test('GenericObject', () {
    expect(
      GenericObject(42),
      GenericObject(42),
    );
    expect(
      GenericObject([1]),
      GenericObject([1]),
    );
    expect(
      GenericObject([
        [1]
      ]),
      GenericObject([
        [1]
      ]),
    );
  });

  test('GenericIterable', () {
    expect(
      GenericIterable([1]),
      GenericIterable([1]),
    );
  });

  test('ObjectWithOtherProperty', () {
    expect(ObjectWithOtherProperty(const [2, 3]),
        ObjectWithOtherProperty(const [2, 3]));
    expect(ObjectWithOtherProperty(const [2, 3]),
        isNot(ObjectWithOtherProperty(const [2, 4])));
    expect(ObjectWithOtherProperty([1, 2]), ObjectWithOtherProperty([1, 2]));
    expect(
        ObjectWithOtherProperty([1, 2]), isNot(ObjectWithOtherProperty([1])));
  });
}
