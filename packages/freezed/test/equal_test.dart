import 'dart:collection';

import 'package:test/test.dart';

import 'integration/equal.dart';

void main() {
  group('instances sharing a collection compare without walking it', () {
    test('List', () {
      final value = _NoWalkList();
      expect(ListEqual(value), ListEqual(value));
    });

    test('Map', () {
      final value = _NoWalkMap();
      expect(MapEqual(value), MapEqual(value));
    });

    test('Set', () {
      final value = _NoWalkSet();
      expect(SetEqual(value), SetEqual(value));
    });
  });

  test('Simple', () {
    expect(Simple(42), Simple(42));
  });

  test('ListEqual', () {
    expect(ListEqual([1]), ListEqual([1]));
  });

  test('MapEqual', () {
    expect(MapEqual({1: 1}), MapEqual({1: 1}));
  });

  test('SetEqual', () {
    expect(SetEqual({1}), SetEqual({1}));
  });

  test('IterableEqual', () {
    expect(IterableEqual([1]), IterableEqual([1]));
  });

  test('ListObjectEqual', () {
    expect(ListObjectEqual([1]), ListObjectEqual([1.0]));
    expect(
      ListObjectEqual([
        [1],
      ]),
      ListObjectEqual([
        [1],
      ]),
    );
  });

  test('ListDynamicEqual', () {
    expect(ListDynamicEqual(<dynamic>[1]), ListDynamicEqual(<dynamic>[1.0]));
    expect(
      ListDynamicEqual(<dynamic>[
        [1],
      ]),
      ListDynamicEqual(<dynamic>[
        [1],
      ]),
    );
  });

  test('ObjectEqual', () {
    expect(ObjectEqual(1), ObjectEqual(1));
    expect(ObjectEqual([1]), ObjectEqual([1]));
    expect(
      ObjectEqual([
        [1],
      ]),
      ObjectEqual([
        [1],
      ]),
    );
  });

  test('DynamicEqual', () {
    expect(DynamicEqual(1), DynamicEqual(1));
    expect(DynamicEqual([1]), DynamicEqual([1]));
    expect(
      DynamicEqual([
        [1],
      ]),
      DynamicEqual([
        [1],
      ]),
    );
  });

  test('Generic', () {
    expect(Generic(42), Generic(42));
    expect(Generic([1]), Generic([1]));
    expect(
      Generic([
        [1],
      ]),
      Generic([
        [1],
      ]),
    );
  });

  test('GenericObject', () {
    expect(GenericObject(42), GenericObject(42));
    expect(GenericObject([1]), GenericObject([1]));
    expect(
      GenericObject([
        [1],
      ]),
      GenericObject([
        [1],
      ]),
    );

    expect(GenericObject<Object>(42), isNot(GenericObject<num>(42)));
    expect(GenericObject<num>(42), isNot(GenericObject<Object>(42)));
  });

  test('GenericIterable', () {
    expect(GenericIterable([1]), GenericIterable([1]));
  });

  test('ObjectWithOtherProperty', () {
    expect(
      ObjectWithOtherProperty(const [2, 3]),
      ObjectWithOtherProperty(const [2, 3]),
    );
    expect(
      ObjectWithOtherProperty(const [2, 3]),
      isNot(ObjectWithOtherProperty(const [2, 4])),
    );
    expect(ObjectWithOtherProperty([1, 2]), ObjectWithOtherProperty([1, 2]));
    expect(
      ObjectWithOtherProperty([1, 2]),
      isNot(ObjectWithOtherProperty([1])),
    );
  });
}

Never _walked() => throw StateError('== walked a collection both sides share');

class _NoWalkList extends ListBase<int> {
  @override
  int get length => _walked();

  @override
  set length(int newLength) => _walked();

  @override
  int operator [](int index) => _walked();

  @override
  void operator []=(int index, int value) => _walked();
}

class _NoWalkMap extends MapBase<int, int> {
  @override
  int? operator [](Object? key) => _walked();

  @override
  void operator []=(int key, int value) => _walked();

  @override
  void clear() => _walked();

  @override
  Iterable<int> get keys => _walked();

  @override
  int get length => _walked();

  @override
  int? remove(Object? key) => _walked();
}

class _NoWalkSet extends SetBase<int> {
  @override
  bool add(int value) => _walked();

  @override
  bool contains(Object? element) => _walked();

  @override
  Iterator<int> get iterator => _walked();

  @override
  int get length => _walked();

  @override
  int? lookup(Object? element) => _walked();

  @override
  bool remove(Object? value) => _walked();

  @override
  Set<int> toSet() => _walked();
}
