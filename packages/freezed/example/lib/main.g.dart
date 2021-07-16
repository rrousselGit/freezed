// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Data _$$DataFromJson(Map<String, dynamic> json) => _$Data(
      json['value'] as int,
    );

Map<String, dynamic> _$$DataToJson(_$Data instance) => <String, dynamic>{
      'value': instance.value,
    };

_$Loading _$$LoadingFromJson(Map<String, dynamic> json) => _$Loading();

Map<String, dynamic> _$$LoadingToJson(_$Loading instance) =>
    <String, dynamic>{};

_$ErrorDetails _$$ErrorDetailsFromJson(Map<String, dynamic> json) =>
    _$ErrorDetails(
      json['message'] as String?,
    );

Map<String, dynamic> _$$ErrorDetailsToJson(_$ErrorDetails instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

_$Complex _$$ComplexFromJson(Map<String, dynamic> json) => _$Complex(
      json['a'] as int,
      json['b'] as String,
    );

Map<String, dynamic> _$$ComplexToJson(_$Complex instance) => <String, dynamic>{
      'a': instance.a,
      'b': instance.b,
    };
