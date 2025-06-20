import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test/test.dart';

void main() {
  group('Freezed', () {
    group('.fromJson', () {
      test('default', () {
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
        expect(defaultValue.addImplicitFinal, isTrue);
        expect(defaultValue.genericArgumentFactories, isFalse);
        expect(defaultValue.makeGeneratedClassesFinal, isNull);
      });

      test('explicit', () {
        final overrides = Freezed.fromJson(<Object?, Object?>{
          'copy_with': false,
          'equal': false,
          'fallback_union': 'test',
          'from_json': true,
          'to_json': true,
          'to_string_override': true,
          'union_key': 'foo',
          'union_value_case': 'screaming_snake',
          'make_collections_unmodifiable': false,
          'add_implicit_final': false,
          'generic_argument_factories': true,
          'make_generated_classes_final': true,
        });

        expect(overrides.copyWith, isFalse);
        expect(overrides.equal, isFalse);
        expect(overrides.fallbackUnion, 'test');
        expect(overrides.fromJson, isTrue);
        expect(overrides.toJson, isTrue);
        expect(overrides.toStringOverride, isTrue);
        expect(overrides.unionKey, 'foo');
        expect(overrides.unionValueCase, FreezedUnionCase.screamingSnake);
        expect(overrides.makeCollectionsUnmodifiable, isFalse);
        expect(overrides.addImplicitFinal, isFalse);
        expect(overrides.genericArgumentFactories, isTrue);
        expect(overrides.makeGeneratedClassesFinal, isTrue);
      });
    });
  });

  test('freezed', () {
    expect(freezed.makeGeneratedClassesFinal, isNull);
  });

  test('unfreezed', () {
    expect(unfreezed.makeCollectionsUnmodifiable, false);
    expect(unfreezed.equal, false);
    expect(unfreezed.addImplicitFinal, false);
    expect(unfreezed.makeGeneratedClassesFinal, isNull);
  });
}
