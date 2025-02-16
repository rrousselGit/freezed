import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test/test.dart';

void main() {
  group('Freezed', () {
    test('.fromJson', () {
      final defaultValue = Freezed.fromJson(<Object?, Object?>{});

      expect(defaultValue.copyWith, isNull);
      expect(defaultValue.equal, isNull);
      expect(defaultValue.fallbackUnion, null);
      expect(defaultValue.fromJson, isNull);
      expect(defaultValue.toJson, isNull);
      expect(defaultValue.toStringOverride, isNull);
      expect(defaultValue.unionKey, 'runtimeType');
      expect(defaultValue.unionValueCase, isNull);
      expect(defaultValue.makeCollectionsUnmodifiable, isTrue);
    });
  });

  test('unfreezed', () {
    expect(unfreezed.makeCollectionsUnmodifiable, false);
    expect(unfreezed.equal, false);
    expect(unfreezed.addImplicitFinal, false);
  });
}
