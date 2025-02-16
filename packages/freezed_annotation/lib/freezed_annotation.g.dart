// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'freezed_annotation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Freezed _$FreezedFromJson(Map json) => Freezed(
      unionKey: json['union_key'] as String? ?? 'runtimeType',
      unionValueCase: $enumDecodeNullable(
          _$FreezedUnionCaseEnumMap, json['union_value_case']),
      fallbackUnion: json['fallback_union'] as String?,
      copyWith: json['copy_with'] as bool?,
      equal: json['equal'] as bool?,
      toStringOverride: json['to_string_override'] as bool?,
      fromJson: json['from_json'] as bool?,
      toJson: json['to_json'] as bool?,
      makeCollectionsUnmodifiable:
          json['make_collections_unmodifiable'] as bool? ?? true,
      addImplicitFinal: json['add_implicit_final'] as bool? ?? true,
      genericArgumentFactories:
          json['generic_argument_factories'] as bool? ?? false,
    );

const _$FreezedUnionCaseEnumMap = {
  FreezedUnionCase.none: 'none',
  FreezedUnionCase.kebab: 'kebab',
  FreezedUnionCase.pascal: 'pascal',
  FreezedUnionCase.snake: 'snake',
  FreezedUnionCase.screamingSnake: 'screaming_snake',
};
