// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'main.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      (json['value'] as num).toInt(),
      $type: json['custom-key'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'value': instance.value,
      'custom-key': instance.$type,
    };

Loading _$LoadingFromJson(Map<String, dynamic> json) => Loading(
      $type: json['custom-key'] as String?,
    );

Map<String, dynamic> _$LoadingToJson(Loading instance) => <String, dynamic>{
      'custom-key': instance.$type,
    };

ErrorDetails _$ErrorDetailsFromJson(Map<String, dynamic> json) => ErrorDetails(
      json['message'] as String?,
      json['custom-key'] as String?,
    );

Map<String, dynamic> _$ErrorDetailsToJson(ErrorDetails instance) =>
    <String, dynamic>{
      'message': instance.message,
      'custom-key': instance.$type,
    };

Complex _$ComplexFromJson(Map<String, dynamic> json) => Complex(
      (json['a'] as num).toInt(),
      json['b'] as String,
      $type: json['custom-key'] as String?,
    );

Map<String, dynamic> _$ComplexToJson(Complex instance) => <String, dynamic>{
      'a': instance.a,
      'b': instance.b,
      'custom-key': instance.$type,
    };
