import 'package:test/test.dart';

import 'integration/equal.dart';
import 'integration/single_class_constructor.dart' show Large;

void main() {
  test('supports classes with large number of properties', () {
    Large().hashCode;
  });

  test('Simple', () {
    expect(
      Simple(42).hashCode,
      Simple(42).hashCode,
    );
  });

  test('ListEqual', () {
    expect(
      ListEqual([1]).hashCode,
      ListEqual([1]).hashCode,
    );
  });

  test('MapEqual', () {
    expect(
      MapEqual({1: 1}).hashCode,
      MapEqual({1: 1}).hashCode,
    );
  });

  test('SetEqual', () {
    expect(
      SetEqual({1}).hashCode,
      SetEqual({1}).hashCode,
    );
  });

  test('IterableEqual', () {
    expect(
      IterableEqual([1]).hashCode,
      IterableEqual([1]).hashCode,
    );
  });

  test('ListObjectEqual', () {
    expect(
      ListObjectEqual([1]).hashCode,
      ListObjectEqual([1.0]).hashCode,
    );
    expect(
      ListObjectEqual([
        [1]
      ]).hashCode,
      ListObjectEqual([
        [1]
      ]).hashCode,
    );
  });

  test('ListDynamicEqual', () {
    expect(
      ListDynamicEqual(<dynamic>[1]).hashCode,
      ListDynamicEqual(<dynamic>[1.0]).hashCode,
    );
    expect(
      ListDynamicEqual(<dynamic>[
        [1]
      ]).hashCode,
      ListDynamicEqual(<dynamic>[
        [1]
      ]).hashCode,
    );
  });

  test('ObjectEqual', () {
    expect(
      ObjectEqual(1).hashCode,
      ObjectEqual(1).hashCode,
    );
    expect(
      ObjectEqual([1]).hashCode,
      ObjectEqual([1]).hashCode,
    );
    expect(
      ObjectEqual([
        [1]
      ]).hashCode,
      ObjectEqual([
        [1]
      ]).hashCode,
    );
  });

  test('DynamicEqual', () {
    expect(
      DynamicEqual(1).hashCode,
      DynamicEqual(1).hashCode,
    );
    expect(
      DynamicEqual([1]).hashCode,
      DynamicEqual([1]).hashCode,
    );
    expect(
      DynamicEqual([
        [1]
      ]).hashCode,
      DynamicEqual([
        [1]
      ]).hashCode,
    );
  });

  test('Generic', () {
    expect(
      Generic(42).hashCode,
      Generic(42).hashCode,
    );
    expect(
      Generic([1]).hashCode,
      Generic([1]).hashCode,
    );
    expect(
      Generic([
        [1]
      ]).hashCode,
      Generic([
        [1]
      ]).hashCode,
    );
  });

  test('GenericObject', () {
    expect(
      GenericObject(42).hashCode,
      GenericObject(42).hashCode,
    );
    expect(
      GenericObject([1]).hashCode,
      GenericObject([1]).hashCode,
    );
    expect(
      GenericObject([
        [1]
      ]).hashCode,
      GenericObject([
        [1]
      ]).hashCode,
    );
  });

  test('GenericIterable', () {
    expect(
      GenericIterable([1]).hashCode,
      GenericIterable([1]).hashCode,
    );
  });
}
