// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MyClass implements DiagnosticableTreeMixin {

 String? get a; int? get b;
/// Create a copy of MyClass
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyClassCopyWith<MyClass> get copyWith => _$MyClassCopyWithImpl<MyClass>(this as MyClass, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MyClass'))
    ..add(DiagnosticsProperty('a', a))..add(DiagnosticsProperty('b', b));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyClass&&(identical(other.a, a) || other.a == a)&&(identical(other.b, b) || other.b == b));
}


@override
int get hashCode => Object.hash(runtimeType,a,b);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MyClass(a: $a, b: $b)';
}


}

/// @nodoc
abstract mixin class $MyClassCopyWith<$Res>  {
  factory $MyClassCopyWith(MyClass value, $Res Function(MyClass) _then) = _$MyClassCopyWithImpl;
@useResult
$Res call({
 String? a, int? b
});




}
/// @nodoc
class _$MyClassCopyWithImpl<$Res>
    implements $MyClassCopyWith<$Res> {
  _$MyClassCopyWithImpl(this._self, this._then);

  final MyClass _self;
  final $Res Function(MyClass) _then;

/// Create a copy of MyClass
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? a = freezed,Object? b = freezed,}) {
  return _then(_self.copyWith(
a: freezed == a ? _self.a : a // ignore: cast_nullable_to_non_nullable
as String?,b: freezed == b ? _self.b : b // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// @nodoc


class _MyClass with DiagnosticableTreeMixin implements MyClass {
   _MyClass({this.a, this.b});
  

@override final  String? a;
@override final  int? b;

/// Create a copy of MyClass
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyClassCopyWith<_MyClass> get copyWith => __$MyClassCopyWithImpl<_MyClass>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MyClass'))
    ..add(DiagnosticsProperty('a', a))..add(DiagnosticsProperty('b', b));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyClass&&(identical(other.a, a) || other.a == a)&&(identical(other.b, b) || other.b == b));
}


@override
int get hashCode => Object.hash(runtimeType,a,b);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MyClass(a: $a, b: $b)';
}


}

/// @nodoc
abstract mixin class _$MyClassCopyWith<$Res> implements $MyClassCopyWith<$Res> {
  factory _$MyClassCopyWith(_MyClass value, $Res Function(_MyClass) _then) = __$MyClassCopyWithImpl;
@override @useResult
$Res call({
 String? a, int? b
});




}
/// @nodoc
class __$MyClassCopyWithImpl<$Res>
    implements _$MyClassCopyWith<$Res> {
  __$MyClassCopyWithImpl(this._self, this._then);

  final _MyClass _self;
  final $Res Function(_MyClass) _then;

/// Create a copy of MyClass
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? a = freezed,Object? b = freezed,}) {
  return _then(_MyClass(
a: freezed == a ? _self.a : a // ignore: cast_nullable_to_non_nullable
as String?,b: freezed == b ? _self.b : b // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

Union _$UnionFromJson(
  Map<String, dynamic> json
) {
        switch (json['custom-key']) {
                  case 'Default':
          return Data.fromJson(
            json
          );
                case 'Loading':
          return Loading.fromJson(
            json
          );
                case 'Error':
          return ErrorDetails.fromJson(
            json
          );
                case 'Complex':
          return Complex.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'custom-key',
  'Union',
  'Invalid union type "${json['custom-key']}"!'
);
        }
      
}

/// @nodoc
mixin _$Union implements DiagnosticableTreeMixin {



  /// Serializes this Union to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Union'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Union);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Union()';
}


}

/// @nodoc
class $UnionCopyWith<$Res>  {
$UnionCopyWith(Union _, $Res Function(Union) __);
}


/// @nodoc
@JsonSerializable()

class Data with DiagnosticableTreeMixin implements Union {
  const Data(this.value, {final  String? $type}): $type = $type ?? 'Default';
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

 final  int value;

@JsonKey(name: 'custom-key')
final String $type;


/// Create a copy of Union
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DataCopyWith<Data> get copyWith => _$DataCopyWithImpl<Data>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DataToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Union'))
    ..add(DiagnosticsProperty('value', value));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Data&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Union(value: $value)';
}


}

/// @nodoc
abstract mixin class $DataCopyWith<$Res> implements $UnionCopyWith<$Res> {
  factory $DataCopyWith(Data value, $Res Function(Data) _then) = _$DataCopyWithImpl;
@useResult
$Res call({
 int value
});




}
/// @nodoc
class _$DataCopyWithImpl<$Res>
    implements $DataCopyWith<$Res> {
  _$DataCopyWithImpl(this._self, this._then);

  final Data _self;
  final $Res Function(Data) _then;

/// Create a copy of Union
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(Data(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class Loading with DiagnosticableTreeMixin implements Union {
  const Loading({final  String? $type}): $type = $type ?? 'Loading';
  factory Loading.fromJson(Map<String, dynamic> json) => _$LoadingFromJson(json);



@JsonKey(name: 'custom-key')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$LoadingToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Union.loading'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Union.loading()';
}


}




/// @nodoc
@JsonSerializable()

class ErrorDetails with DiagnosticableTreeMixin implements Union {
  const ErrorDetails([this.message, final  String? $type]): $type = $type ?? 'Error';
  factory ErrorDetails.fromJson(Map<String, dynamic> json) => _$ErrorDetailsFromJson(json);

 final  String? message;

@JsonKey(name: 'custom-key')
final String $type;


/// Create a copy of Union
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorDetailsCopyWith<ErrorDetails> get copyWith => _$ErrorDetailsCopyWithImpl<ErrorDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ErrorDetailsToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Union.error'))
    ..add(DiagnosticsProperty('message', message));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorDetails&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Union.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorDetailsCopyWith<$Res> implements $UnionCopyWith<$Res> {
  factory $ErrorDetailsCopyWith(ErrorDetails value, $Res Function(ErrorDetails) _then) = _$ErrorDetailsCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$ErrorDetailsCopyWithImpl<$Res>
    implements $ErrorDetailsCopyWith<$Res> {
  _$ErrorDetailsCopyWithImpl(this._self, this._then);

  final ErrorDetails _self;
  final $Res Function(ErrorDetails) _then;

/// Create a copy of Union
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(ErrorDetails(
freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class Complex with DiagnosticableTreeMixin implements Union {
  const Complex(this.a, this.b, {final  String? $type}): $type = $type ?? 'Complex';
  factory Complex.fromJson(Map<String, dynamic> json) => _$ComplexFromJson(json);

 final  int a;
 final  String b;

@JsonKey(name: 'custom-key')
final String $type;


/// Create a copy of Union
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComplexCopyWith<Complex> get copyWith => _$ComplexCopyWithImpl<Complex>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComplexToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Union.complex'))
    ..add(DiagnosticsProperty('a', a))..add(DiagnosticsProperty('b', b));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Complex&&(identical(other.a, a) || other.a == a)&&(identical(other.b, b) || other.b == b));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,a,b);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Union.complex(a: $a, b: $b)';
}


}

/// @nodoc
abstract mixin class $ComplexCopyWith<$Res> implements $UnionCopyWith<$Res> {
  factory $ComplexCopyWith(Complex value, $Res Function(Complex) _then) = _$ComplexCopyWithImpl;
@useResult
$Res call({
 int a, String b
});




}
/// @nodoc
class _$ComplexCopyWithImpl<$Res>
    implements $ComplexCopyWith<$Res> {
  _$ComplexCopyWithImpl(this._self, this._then);

  final Complex _self;
  final $Res Function(Complex) _then;

/// Create a copy of Union
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? a = null,Object? b = null,}) {
  return _then(Complex(
null == a ? _self.a : a // ignore: cast_nullable_to_non_nullable
as int,null == b ? _self.b : b // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$SharedProperty implements DiagnosticableTreeMixin {

 String? get name;
/// Create a copy of SharedProperty
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SharedPropertyCopyWith<SharedProperty> get copyWith => _$SharedPropertyCopyWithImpl<SharedProperty>(this as SharedProperty, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SharedProperty'))
    ..add(DiagnosticsProperty('name', name));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SharedProperty&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SharedProperty(name: $name)';
}


}

/// @nodoc
abstract mixin class $SharedPropertyCopyWith<$Res>  {
  factory $SharedPropertyCopyWith(SharedProperty value, $Res Function(SharedProperty) _then) = _$SharedPropertyCopyWithImpl;
@useResult
$Res call({
 String? name
});




}
/// @nodoc
class _$SharedPropertyCopyWithImpl<$Res>
    implements $SharedPropertyCopyWith<$Res> {
  _$SharedPropertyCopyWithImpl(this._self, this._then);

  final SharedProperty _self;
  final $Res Function(SharedProperty) _then;

/// Create a copy of SharedProperty
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class SharedProperty0 with DiagnosticableTreeMixin implements SharedProperty {
   SharedProperty0({this.name, this.age});
  

@override final  String? name;
 final  int? age;

/// Create a copy of SharedProperty
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SharedProperty0CopyWith<SharedProperty0> get copyWith => _$SharedProperty0CopyWithImpl<SharedProperty0>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SharedProperty.person'))
    ..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('age', age));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SharedProperty0&&(identical(other.name, name) || other.name == name)&&(identical(other.age, age) || other.age == age));
}


@override
int get hashCode => Object.hash(runtimeType,name,age);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SharedProperty.person(name: $name, age: $age)';
}


}

/// @nodoc
abstract mixin class $SharedProperty0CopyWith<$Res> implements $SharedPropertyCopyWith<$Res> {
  factory $SharedProperty0CopyWith(SharedProperty0 value, $Res Function(SharedProperty0) _then) = _$SharedProperty0CopyWithImpl;
@override @useResult
$Res call({
 String? name, int? age
});




}
/// @nodoc
class _$SharedProperty0CopyWithImpl<$Res>
    implements $SharedProperty0CopyWith<$Res> {
  _$SharedProperty0CopyWithImpl(this._self, this._then);

  final SharedProperty0 _self;
  final $Res Function(SharedProperty0) _then;

/// Create a copy of SharedProperty
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? age = freezed,}) {
  return _then(SharedProperty0(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class SharedProperty1 with DiagnosticableTreeMixin implements SharedProperty {
   SharedProperty1({this.name, this.population});
  

@override final  String? name;
 final  int? population;

/// Create a copy of SharedProperty
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SharedProperty1CopyWith<SharedProperty1> get copyWith => _$SharedProperty1CopyWithImpl<SharedProperty1>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SharedProperty.city'))
    ..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('population', population));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SharedProperty1&&(identical(other.name, name) || other.name == name)&&(identical(other.population, population) || other.population == population));
}


@override
int get hashCode => Object.hash(runtimeType,name,population);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SharedProperty.city(name: $name, population: $population)';
}


}

/// @nodoc
abstract mixin class $SharedProperty1CopyWith<$Res> implements $SharedPropertyCopyWith<$Res> {
  factory $SharedProperty1CopyWith(SharedProperty1 value, $Res Function(SharedProperty1) _then) = _$SharedProperty1CopyWithImpl;
@override @useResult
$Res call({
 String? name, int? population
});




}
/// @nodoc
class _$SharedProperty1CopyWithImpl<$Res>
    implements $SharedProperty1CopyWith<$Res> {
  _$SharedProperty1CopyWithImpl(this._self, this._then);

  final SharedProperty1 _self;
  final $Res Function(SharedProperty1) _then;

/// Create a copy of SharedProperty
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? population = freezed,}) {
  return _then(SharedProperty1(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,population: freezed == population ? _self.population : population // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
