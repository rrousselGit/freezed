import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test/test.dart';

void main() {
  group('FreezedMapOptions', () {
    test('.fromJson', () {
      expect(FreezedMapOptions.fromJson({'map': false}).map, isFalse);
      expect(FreezedMapOptions.fromJson({'map': false}).mapOrNull, isTrue);
      expect(FreezedMapOptions.fromJson({'map': false}).maybeMap, isTrue);

      expect(FreezedMapOptions.fromJson({'map_or_null': false}).map, isTrue);
      expect(FreezedMapOptions.fromJson({'map_or_null': false}).mapOrNull,
          isFalse);
      expect(
          FreezedMapOptions.fromJson({'map_or_null': false}).maybeMap, isTrue);

      expect(FreezedMapOptions.fromJson({'maybe_map': false}).map, isTrue);
      expect(
          FreezedMapOptions.fromJson({'maybe_map': false}).mapOrNull, isTrue);
      expect(
          FreezedMapOptions.fromJson({'maybe_map': false}).maybeMap, isFalse);
    });

    test('.all', () {
      expect(FreezedMapOptions.all.map, isTrue);
      expect(FreezedMapOptions.all.maybeMap, isTrue);
      expect(FreezedMapOptions.all.mapOrNull, isTrue);
    });

    test('.none', () {
      expect(FreezedMapOptions.none.map, isFalse);
      expect(FreezedMapOptions.none.maybeMap, isFalse);
      expect(FreezedMapOptions.none.mapOrNull, isFalse);
    });

    test('()', () {
      expect(FreezedMapOptions().map, isNull);
      expect(FreezedMapOptions().maybeMap, isNull);
      expect(FreezedMapOptions().mapOrNull, isNull);
    });
  });

  group('FreezedWhenOptions', () {
    test('.fromJson', () {
      expect(FreezedWhenOptions.fromJson({'when': false}).when, isFalse);
      expect(FreezedWhenOptions.fromJson({'when': false}).whenOrNull, isTrue);
      expect(FreezedWhenOptions.fromJson({'when': false}).maybeWhen, isTrue);

      expect(FreezedWhenOptions.fromJson({'when_or_null': false}).when, isTrue);
      expect(
        FreezedWhenOptions.fromJson({'when_or_null': false}).whenOrNull,
        isFalse,
      );
      expect(
        FreezedWhenOptions.fromJson({'when_or_null': false}).maybeWhen,
        isTrue,
      );

      expect(FreezedWhenOptions.fromJson({'maybe_when': false}).when, isTrue);
      expect(
        FreezedWhenOptions.fromJson({'maybe_when': false}).whenOrNull,
        isTrue,
      );
      expect(
        FreezedWhenOptions.fromJson({'maybe_when': false}).maybeWhen,
        isFalse,
      );
    });

    test('.all', () {
      expect(FreezedWhenOptions.all.when, isTrue);
      expect(FreezedWhenOptions.all.maybeWhen, isTrue);
      expect(FreezedWhenOptions.all.whenOrNull, isTrue);
    });

    test('.none', () {
      expect(FreezedWhenOptions.none.when, isFalse);
      expect(FreezedWhenOptions.none.maybeWhen, isFalse);
      expect(FreezedWhenOptions.none.whenOrNull, isFalse);
    });

    test('()', () {
      expect(FreezedWhenOptions().when, isNull);
      expect(FreezedWhenOptions().maybeWhen, isNull);
      expect(FreezedWhenOptions().whenOrNull, isNull);
    });
  });

  group('Freezed', () {
    test('.fromJson', () {
      final defaultValue = Freezed.fromJson({});

      expect(defaultValue.copyWith, isTrue);
      expect(defaultValue.equal, isNull);
      expect(defaultValue.fallbackUnion, null);
      expect(defaultValue.fromJson, isNull);
      expect(defaultValue.map, isNull);
      expect(defaultValue.toJson, isNull);
      expect(defaultValue.toStringOverride, isNull);
      expect(defaultValue.unionKey, 'runtimeType');
      expect(defaultValue.unionValueCase, isNull);
      expect(defaultValue.when, isNull);
    });
  });

  group('FastDeepCollectionEquality', () {
    test('equals', () {
      expect(FastDeepCollectionEquality().equals(<int>[1, 2, 3], [1, 2, 3]), isTrue);
      expect(FastDeepCollectionEquality().equals(<int>[1, 2, 3], Uint8List.fromList([1, 2, 3])), isTrue);
      expect(FastDeepCollectionEquality().equals(<int>[2, 3, 4], [1, 2, 3]), isFalse);
      expect(FastDeepCollectionEquality().equals(<int>[2, 3, 4], Uint8List.fromList([1, 2, 3])), isFalse);

      expect(FastDeepCollectionEquality().equals(<double>[1.5, 2.5], [1.5, 2.5]), isTrue);
      expect(FastDeepCollectionEquality().equals(<double>[1.5, 2.5], Float32List.fromList([1.5, 2.5])), isTrue);
      expect(FastDeepCollectionEquality().equals(<double>[1.5, 2.5], [0.5]), isFalse);
      expect(FastDeepCollectionEquality().equals(<double>[1.5, 2.5], Float32List.fromList([0.5])), isFalse);

      expect(FastDeepCollectionEquality().equals(<String>["a", "b"], <String>["a", "b"]), isTrue);
      expect(FastDeepCollectionEquality().equals(<String>["a", "b"], <String>["b", "c"]), isFalse);
    });
  });
}
