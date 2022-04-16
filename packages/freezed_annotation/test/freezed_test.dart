import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test/test.dart';

void main() {
  group('FreezedMap', () {
    test('.fromJson', () {
      expect(FreezedMap.fromJson({'map': false}).map, isFalse);
      expect(FreezedMap.fromJson({'map': false}).mapOrNull, isTrue);
      expect(FreezedMap.fromJson({'map': false}).maybeMap, isTrue);

      expect(FreezedMap.fromJson({'map_or_null': false}).map, isTrue);
      expect(FreezedMap.fromJson({'map_or_null': false}).mapOrNull, isFalse);
      expect(FreezedMap.fromJson({'map_or_null': false}).maybeMap, isTrue);

      expect(FreezedMap.fromJson({'maybe_map': false}).map, isTrue);
      expect(FreezedMap.fromJson({'maybe_map': false}).mapOrNull, isTrue);
      expect(FreezedMap.fromJson({'maybe_map': false}).maybeMap, isFalse);
    });

    test('.all', () {
      expect(FreezedMap.all.map, isTrue);
      expect(FreezedMap.all.maybeMap, isTrue);
      expect(FreezedMap.all.mapOrNull, isTrue);
    });

    test('.none', () {
      expect(FreezedMap.none.map, isFalse);
      expect(FreezedMap.none.maybeMap, isFalse);
      expect(FreezedMap.none.mapOrNull, isFalse);
    });

    test('()', () {
      expect(FreezedMap().map, isNull);
      expect(FreezedMap().maybeMap, isNull);
      expect(FreezedMap().mapOrNull, isNull);
    });
  });

  group('FreezedWhen', () {
    test('.fromJson', () {
      expect(FreezedWhen.fromJson({'when': false}).when, isFalse);
      expect(FreezedWhen.fromJson({'when': false}).whenOrNull, isTrue);
      expect(FreezedWhen.fromJson({'when': false}).maybeWhen, isTrue);

      expect(FreezedWhen.fromJson({'when_or_null': false}).when, isTrue);
      expect(FreezedWhen.fromJson({'when_or_null': false}).whenOrNull, isFalse);
      expect(FreezedWhen.fromJson({'when_or_null': false}).maybeWhen, isTrue);

      expect(FreezedWhen.fromJson({'maybe_when': false}).when, isTrue);
      expect(FreezedWhen.fromJson({'maybe_when': false}).whenOrNull, isTrue);
      expect(FreezedWhen.fromJson({'maybe_when': false}).maybeWhen, isFalse);
    });

    test('.all', () {
      expect(FreezedWhen.all.when, isTrue);
      expect(FreezedWhen.all.maybeWhen, isTrue);
      expect(FreezedWhen.all.whenOrNull, isTrue);
    });

    test('.none', () {
      expect(FreezedWhen.none.when, isFalse);
      expect(FreezedWhen.none.maybeWhen, isFalse);
      expect(FreezedWhen.none.whenOrNull, isFalse);
    });

    test('()', () {
      expect(FreezedWhen().when, isNull);
      expect(FreezedWhen().maybeWhen, isNull);
      expect(FreezedWhen().whenOrNull, isNull);
    });
  });

  group('Freezed', () {
    test('.fromJson', () {
      final defaultValue = Freezed.fromJson({});

      expect(defaultValue.copyWith, isTrue);
      expect(defaultValue.equal, isTrue);
      expect(defaultValue.fallbackUnion, null);
      expect(defaultValue.fromJson, isNull);
      expect(defaultValue.map, isNull);
      expect(defaultValue.toJson, isNull);
      expect(defaultValue.toStringOverride, isTrue);
      expect(defaultValue.unionKey, 'runtimeType');
      expect(defaultValue.unionValueCase, FreezedUnionCase.none);
      expect(defaultValue.when, isNull);
      // ignore: deprecated_member_use_from_same_package
      expect(defaultValue.maybeMap, true);
      // ignore: deprecated_member_use_from_same_package
      expect(defaultValue.maybeMap, true);
    });
  });
}
