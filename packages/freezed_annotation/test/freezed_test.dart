import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test/test.dart';

void main() {
  group('FreezedMapOptions', () {
    test('.fromJson', () {
      expect(
        FreezedMapOptions.fromJson(<Object?, Object?>{'map': false}).map,
        isFalse,
      );
      expect(
        FreezedMapOptions.fromJson(<Object?, Object?>{'map': false}).mapOrNull,
        isNull,
      );
      expect(
        FreezedMapOptions.fromJson(<Object?, Object?>{'map': false}).maybeMap,
        isNull,
      );

      expect(
        FreezedMapOptions.fromJson(<Object?, Object?>{'map_or_null': false})
            .map,
        isNull,
      );
      expect(
        FreezedMapOptions.fromJson(<Object?, Object?>{'map_or_null': false})
            .mapOrNull,
        isFalse,
      );
      expect(
        FreezedMapOptions.fromJson(<Object?, Object?>{'map_or_null': false})
            .maybeMap,
        isNull,
      );

      expect(
        FreezedMapOptions.fromJson(<Object?, Object?>{'maybe_map': false}).map,
        isNull,
      );
      expect(
        FreezedMapOptions.fromJson(<Object?, Object?>{'maybe_map': false})
            .mapOrNull,
        isNull,
      );
      expect(
        FreezedMapOptions.fromJson(<Object?, Object?>{'maybe_map': false})
            .maybeMap,
        isFalse,
      );
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
      expect(
        FreezedWhenOptions.fromJson(<Object?, Object?>{'when': false}).when,
        isFalse,
      );
      expect(
        FreezedWhenOptions.fromJson(<Object?, Object?>{'when': false})
            .whenOrNull,
        isNull,
      );
      expect(
        FreezedWhenOptions.fromJson(<Object?, Object?>{'when': false})
            .maybeWhen,
        isNull,
      );

      expect(
        FreezedWhenOptions.fromJson(<Object?, Object?>{'when_or_null': false})
            .when,
        isNull,
      );
      expect(
        FreezedWhenOptions.fromJson(<Object?, Object?>{'when_or_null': false})
            .whenOrNull,
        isFalse,
      );
      expect(
        FreezedWhenOptions.fromJson(<Object?, Object?>{'when_or_null': false})
            .maybeWhen,
        isNull,
      );

      expect(
          FreezedWhenOptions.fromJson(<Object?, Object?>{'maybe_when': false})
              .when,
          isNull);
      expect(
        FreezedWhenOptions.fromJson(<Object?, Object?>{'maybe_when': false})
            .whenOrNull,
        isNull,
      );
      expect(
        FreezedWhenOptions.fromJson(<Object?, Object?>{'maybe_when': false})
            .maybeWhen,
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
      final defaultValue = Freezed.fromJson(<Object?, Object?>{});

      expect(defaultValue.copyWith, isNull);
      expect(defaultValue.equal, isNull);
      expect(defaultValue.fallbackUnion, null);
      expect(defaultValue.fromJson, isNull);
      expect(defaultValue.map, isNull);
      expect(defaultValue.toJson, isNull);
      expect(defaultValue.toStringOverride, isNull);
      expect(defaultValue.unionKey, 'runtimeType');
      expect(defaultValue.unionValueCase, isNull);
      expect(defaultValue.when, isNull);
      expect(defaultValue.makeCollectionsUnmodifiable, isTrue);
    });

    test('.fromJson({map: x})', () {
      expect(Freezed.fromJson({'map': false}).map, FreezedMapOptions.none);
      expect(Freezed.fromJson({'map': true}).map, FreezedMapOptions.all);

      expect(
        Freezed.fromJson({
          'map': {
            'map': true,
            'maybe_map': false,
            'map_or_null': true,
          }
        }).map,
        isA<FreezedMapOptions>()
            .having(
              (e) => e.map,
              'map',
              isTrue,
            )
            .having(
              (e) => e.maybeMap,
              'maybeMap',
              isFalse,
            )
            .having(
              (e) => e.mapOrNull,
              'mapOrNull',
              isTrue,
            ),
      );

      expect(
        () => Freezed.fromJson({'map': 42}),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('.fromJson({when: x})', () {
      expect(Freezed.fromJson({'when': false}).when, FreezedWhenOptions.none);
      expect(Freezed.fromJson({'when': true}).when, FreezedWhenOptions.all);

      expect(
        Freezed.fromJson({
          'when': {
            'when': true,
            'maybe_when': false,
            'when_or_null': true,
          }
        }).when,
        isA<FreezedWhenOptions>()
            .having(
              (e) => e.when,
              'when',
              isTrue,
            )
            .having(
              (e) => e.maybeWhen,
              'maybeWhen',
              isFalse,
            )
            .having(
              (e) => e.whenOrNull,
              'whenOrNull',
              isTrue,
            ),
      );

      expect(
        () => Freezed.fromJson({'when': 42}),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  test('unfreezed', () {
    expect(unfreezed.makeCollectionsUnmodifiable, false);
    expect(unfreezed.equal, false);
    expect(unfreezed.addImplicitFinal, false);
  });
}
