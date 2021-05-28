// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Data _$_$DataFromJson(Map<String, dynamic> json) {
  $checkKeys(json, allowedKeys: const ['value']);
  return _$Data(
    json['value'] as int,
  );
}

Map<String, dynamic> _$_$DataToJson(_$Data instance) => <String, dynamic>{
      'value': instance.value,
    };

_$Loading _$_$LoadingFromJson(Map<String, dynamic> json) {
  $checkKeys(json, allowedKeys: const []);
  return _$Loading();
}

Map<String, dynamic> _$_$LoadingToJson(_$Loading instance) =>
    <String, dynamic>{};

_$ErrorDetails _$_$ErrorDetailsFromJson(Map<String, dynamic> json) {
  $checkKeys(json, allowedKeys: const ['message']);
  return _$ErrorDetails(
    json['message'] as String?,
  );
}

Map<String, dynamic> _$_$ErrorDetailsToJson(_$ErrorDetails instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

_$Complex _$_$ComplexFromJson(Map<String, dynamic> json) {
  $checkKeys(json, allowedKeys: const ['a', 'b']);
  return _$Complex(
    json['a'] as int,
    json['b'] as String,
  );
}

Map<String, dynamic> _$_$ComplexToJson(_$Complex instance) => <String, dynamic>{
      'a': instance.a,
      'b': instance.b,
    };
