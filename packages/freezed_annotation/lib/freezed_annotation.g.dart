// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'freezed_annotation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreezedMapOptions _$FreezedMapFromJson(Map<String, dynamic> json) =>
    FreezedMapOptions(
      map: json['map'] as bool? ?? true,
      mapOrNull: json['map_or_null'] as bool? ?? true,
      maybeMap: json['maybe_map'] as bool? ?? true,
    );

FreezedWhenOptions _$FreezedWhenFromJson(Map<String, dynamic> json) => FreezedWhenOptions(
      when: json['when'] as bool? ?? true,
      whenOrNull: json['when_or_null'] as bool? ?? true,
      maybeWhen: json['maybe_when'] as bool? ?? true,
    );

Freezed _$FreezedFromJson(Map<String, dynamic> json) => Freezed(
      unionKey: json['union_key'] as String? ?? 'runtimeType',
      unionValueCase: $enumDecodeNullable(
          _$FreezedUnionCaseEnumMap, json['union_value_case']),
      fallbackUnion: json['fallback_union'] as String?,
      copyWith: json['copy_with'] as bool? ?? true,
      equal: json['equal'] as bool?,
      toStringOverride: json['to_string_override'] as bool?,
      fromJson: json['from_json'] as bool?,
      toJson: json['to_json'] as bool?,
      map: json['map'] == null
          ? null
          : FreezedMapOptions.fromJson(json['map'] as Map<String, dynamic>),
      when: json['when'] == null
          ? null
          : FreezedWhenOptions.fromJson(json['when'] as Map<String, dynamic>),
    );

const _$FreezedUnionCaseEnumMap = {
  FreezedUnionCase.none: 'none',
  FreezedUnionCase.kebab: 'kebab',
  FreezedUnionCase.pascal: 'pascal',
  FreezedUnionCase.snake: 'snake',
  FreezedUnionCase.screamingSnake: 'screaming_snake',
};
