// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'non_diagnosticable.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Example<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Example<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Example<$T>()';
}


}

/// @nodoc
class $ExampleCopyWith<T,$Res>  {
$ExampleCopyWith(Example<T> _, $Res Function(Example<T>) __);
}



/// @nodoc


class _Example<T> implements Example<T> {
   _Example(this.a, this.b);
  

 final  int a;
 final  String b;

/// Create a copy of Example
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExampleCopyWith<T, _Example<T>> get copyWith => __$ExampleCopyWithImpl<T, _Example<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Example<T>&&(identical(other.a, a) || other.a == a)&&(identical(other.b, b) || other.b == b));
}


@override
int get hashCode => Object.hash(runtimeType,a,b);

@override
String toString() {
  return 'Example<$T>(a: $a, b: $b)';
}


}

/// @nodoc
abstract mixin class _$ExampleCopyWith<T,$Res> implements $ExampleCopyWith<T, $Res> {
  factory _$ExampleCopyWith(_Example<T> value, $Res Function(_Example<T>) _then) = __$ExampleCopyWithImpl;
@useResult
$Res call({
 int a, String b
});




}
/// @nodoc
class __$ExampleCopyWithImpl<T,$Res>
    implements _$ExampleCopyWith<T, $Res> {
  __$ExampleCopyWithImpl(this._self, this._then);

  final _Example<T> _self;
  final $Res Function(_Example<T>) _then;

/// Create a copy of Example
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? a = null,Object? b = null,}) {
  return _then(_Example<T>(
null == a ? _self.a : a // ignore: cast_nullable_to_non_nullable
as int,null == b ? _self.b : b // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Example2<T> implements Example<T> {
   _Example2(this.c);
  

 final  T c;

/// Create a copy of Example
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Example2CopyWith<T, _Example2<T>> get copyWith => __$Example2CopyWithImpl<T, _Example2<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Example2<T>&&const DeepCollectionEquality().equals(other.c, c));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(c));

@override
String toString() {
  return 'Example<$T>.named(c: $c)';
}


}

/// @nodoc
abstract mixin class _$Example2CopyWith<T,$Res> implements $ExampleCopyWith<T, $Res> {
  factory _$Example2CopyWith(_Example2<T> value, $Res Function(_Example2<T>) _then) = __$Example2CopyWithImpl;
@useResult
$Res call({
 T c
});




}
/// @nodoc
class __$Example2CopyWithImpl<T,$Res>
    implements _$Example2CopyWith<T, $Res> {
  __$Example2CopyWithImpl(this._self, this._then);

  final _Example2<T> _self;
  final $Res Function(_Example2<T>) _then;

/// Create a copy of Example
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? c = freezed,}) {
  return _then(_Example2<T>(
freezed == c ? _self.c : c // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc
mixin _$SimpleImplements {

 String get name;
/// Create a copy of SimpleImplements
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SimpleImplementsCopyWith<SimpleImplements> get copyWith => _$SimpleImplementsCopyWithImpl<SimpleImplements>(this as SimpleImplements, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SimpleImplements&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'SimpleImplements(name: $name)';
}


}

/// @nodoc
abstract mixin class $SimpleImplementsCopyWith<$Res>  {
  factory $SimpleImplementsCopyWith(SimpleImplements value, $Res Function(SimpleImplements) _then) = _$SimpleImplementsCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$SimpleImplementsCopyWithImpl<$Res>
    implements $SimpleImplementsCopyWith<$Res> {
  _$SimpleImplementsCopyWithImpl(this._self, this._then);

  final SimpleImplements _self;
  final $Res Function(SimpleImplements) _then;

/// Create a copy of SimpleImplements
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc


class SimplePerson implements SimpleImplements {
  const SimplePerson(this.name, this.age);
  

@override final  String name;
 final  int age;

/// Create a copy of SimpleImplements
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SimplePersonCopyWith<SimplePerson> get copyWith => _$SimplePersonCopyWithImpl<SimplePerson>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SimplePerson&&(identical(other.name, name) || other.name == name)&&(identical(other.age, age) || other.age == age));
}


@override
int get hashCode => Object.hash(runtimeType,name,age);

@override
String toString() {
  return 'SimpleImplements.person(name: $name, age: $age)';
}


}

/// @nodoc
abstract mixin class $SimplePersonCopyWith<$Res> implements $SimpleImplementsCopyWith<$Res> {
  factory $SimplePersonCopyWith(SimplePerson value, $Res Function(SimplePerson) _then) = _$SimplePersonCopyWithImpl;
@override @useResult
$Res call({
 String name, int age
});




}
/// @nodoc
class _$SimplePersonCopyWithImpl<$Res>
    implements $SimplePersonCopyWith<$Res> {
  _$SimplePersonCopyWithImpl(this._self, this._then);

  final SimplePerson _self;
  final $Res Function(SimplePerson) _then;

/// Create a copy of SimpleImplements
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? age = null,}) {
  return _then(SimplePerson(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class SimpleStreet with AdministrativeArea<House> implements SimpleImplements {
  const SimpleStreet(this.name);
  

@override final  String name;

/// Create a copy of SimpleImplements
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SimpleStreetCopyWith<SimpleStreet> get copyWith => _$SimpleStreetCopyWithImpl<SimpleStreet>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SimpleStreet&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'SimpleImplements.street(name: $name)';
}


}

/// @nodoc
abstract mixin class $SimpleStreetCopyWith<$Res> implements $SimpleImplementsCopyWith<$Res> {
  factory $SimpleStreetCopyWith(SimpleStreet value, $Res Function(SimpleStreet) _then) = _$SimpleStreetCopyWithImpl;
@override @useResult
$Res call({
 String name
});




}
/// @nodoc
class _$SimpleStreetCopyWithImpl<$Res>
    implements $SimpleStreetCopyWith<$Res> {
  _$SimpleStreetCopyWithImpl(this._self, this._then);

  final SimpleStreet _self;
  final $Res Function(SimpleStreet) _then;

/// Create a copy of SimpleImplements
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(SimpleStreet(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SimpleCity with House implements SimpleImplements {
  const SimpleCity(this.name, this.population);
  

@override final  String name;
 final  int population;

/// Create a copy of SimpleImplements
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SimpleCityCopyWith<SimpleCity> get copyWith => _$SimpleCityCopyWithImpl<SimpleCity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SimpleCity&&(identical(other.name, name) || other.name == name)&&(identical(other.population, population) || other.population == population));
}


@override
int get hashCode => Object.hash(runtimeType,name,population);

@override
String toString() {
  return 'SimpleImplements.city(name: $name, population: $population)';
}


}

/// @nodoc
abstract mixin class $SimpleCityCopyWith<$Res> implements $SimpleImplementsCopyWith<$Res> {
  factory $SimpleCityCopyWith(SimpleCity value, $Res Function(SimpleCity) _then) = _$SimpleCityCopyWithImpl;
@override @useResult
$Res call({
 String name, int population
});




}
/// @nodoc
class _$SimpleCityCopyWithImpl<$Res>
    implements $SimpleCityCopyWith<$Res> {
  _$SimpleCityCopyWithImpl(this._self, this._then);

  final SimpleCity _self;
  final $Res Function(SimpleCity) _then;

/// Create a copy of SimpleImplements
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? population = null,}) {
  return _then(SimpleCity(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == population ? _self.population : population // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class SimpleCountry with House implements SimpleImplements, GeographicArea {
  const SimpleCountry(this.name, this.population);
  

@override final  String name;
 final  int population;

/// Create a copy of SimpleImplements
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SimpleCountryCopyWith<SimpleCountry> get copyWith => _$SimpleCountryCopyWithImpl<SimpleCountry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SimpleCountry&&(identical(other.name, name) || other.name == name)&&(identical(other.population, population) || other.population == population));
}


@override
int get hashCode => Object.hash(runtimeType,name,population);

@override
String toString() {
  return 'SimpleImplements.country(name: $name, population: $population)';
}


}

/// @nodoc
abstract mixin class $SimpleCountryCopyWith<$Res> implements $SimpleImplementsCopyWith<$Res> {
  factory $SimpleCountryCopyWith(SimpleCountry value, $Res Function(SimpleCountry) _then) = _$SimpleCountryCopyWithImpl;
@override @useResult
$Res call({
 String name, int population
});




}
/// @nodoc
class _$SimpleCountryCopyWithImpl<$Res>
    implements $SimpleCountryCopyWith<$Res> {
  _$SimpleCountryCopyWithImpl(this._self, this._then);

  final SimpleCountry _self;
  final $Res Function(SimpleCountry) _then;

/// Create a copy of SimpleImplements
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? population = null,}) {
  return _then(SimpleCountry(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == population ? _self.population : population // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$CustomMethodImplements {

 String get name;
/// Create a copy of CustomMethodImplements
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomMethodImplementsCopyWith<CustomMethodImplements> get copyWith => _$CustomMethodImplementsCopyWithImpl<CustomMethodImplements>(this as CustomMethodImplements, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomMethodImplements&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'CustomMethodImplements(name: $name)';
}


}

/// @nodoc
abstract mixin class $CustomMethodImplementsCopyWith<$Res>  {
  factory $CustomMethodImplementsCopyWith(CustomMethodImplements value, $Res Function(CustomMethodImplements) _then) = _$CustomMethodImplementsCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$CustomMethodImplementsCopyWithImpl<$Res>
    implements $CustomMethodImplementsCopyWith<$Res> {
  _$CustomMethodImplementsCopyWithImpl(this._self, this._then);

  final CustomMethodImplements _self;
  final $Res Function(CustomMethodImplements) _then;

/// Create a copy of CustomMethodImplements
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc


class PersonCustomMethod extends CustomMethodImplements {
  const PersonCustomMethod(this.name, this.age): super._();
  

@override final  String name;
 final  int age;

/// Create a copy of CustomMethodImplements
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonCustomMethodCopyWith<PersonCustomMethod> get copyWith => _$PersonCustomMethodCopyWithImpl<PersonCustomMethod>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonCustomMethod&&(identical(other.name, name) || other.name == name)&&(identical(other.age, age) || other.age == age));
}


@override
int get hashCode => Object.hash(runtimeType,name,age);

@override
String toString() {
  return 'CustomMethodImplements.person(name: $name, age: $age)';
}


}

/// @nodoc
abstract mixin class $PersonCustomMethodCopyWith<$Res> implements $CustomMethodImplementsCopyWith<$Res> {
  factory $PersonCustomMethodCopyWith(PersonCustomMethod value, $Res Function(PersonCustomMethod) _then) = _$PersonCustomMethodCopyWithImpl;
@override @useResult
$Res call({
 String name, int age
});




}
/// @nodoc
class _$PersonCustomMethodCopyWithImpl<$Res>
    implements $PersonCustomMethodCopyWith<$Res> {
  _$PersonCustomMethodCopyWithImpl(this._self, this._then);

  final PersonCustomMethod _self;
  final $Res Function(PersonCustomMethod) _then;

/// Create a copy of CustomMethodImplements
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? age = null,}) {
  return _then(PersonCustomMethod(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class StreetCustomMethod extends CustomMethodImplements with Shop, AdministrativeArea<House> {
  const StreetCustomMethod(this.name): super._();
  

@override final  String name;

/// Create a copy of CustomMethodImplements
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StreetCustomMethodCopyWith<StreetCustomMethod> get copyWith => _$StreetCustomMethodCopyWithImpl<StreetCustomMethod>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StreetCustomMethod&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'CustomMethodImplements.street(name: $name)';
}


}

/// @nodoc
abstract mixin class $StreetCustomMethodCopyWith<$Res> implements $CustomMethodImplementsCopyWith<$Res> {
  factory $StreetCustomMethodCopyWith(StreetCustomMethod value, $Res Function(StreetCustomMethod) _then) = _$StreetCustomMethodCopyWithImpl;
@override @useResult
$Res call({
 String name
});




}
/// @nodoc
class _$StreetCustomMethodCopyWithImpl<$Res>
    implements $StreetCustomMethodCopyWith<$Res> {
  _$StreetCustomMethodCopyWithImpl(this._self, this._then);

  final StreetCustomMethod _self;
  final $Res Function(StreetCustomMethod) _then;

/// Create a copy of CustomMethodImplements
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(StreetCustomMethod(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CityCustomMethod extends CustomMethodImplements with House implements GeographicArea {
  const CityCustomMethod(this.name, this.population): super._();
  

@override final  String name;
 final  int population;

/// Create a copy of CustomMethodImplements
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CityCustomMethodCopyWith<CityCustomMethod> get copyWith => _$CityCustomMethodCopyWithImpl<CityCustomMethod>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CityCustomMethod&&(identical(other.name, name) || other.name == name)&&(identical(other.population, population) || other.population == population));
}


@override
int get hashCode => Object.hash(runtimeType,name,population);

@override
String toString() {
  return 'CustomMethodImplements.city(name: $name, population: $population)';
}


}

/// @nodoc
abstract mixin class $CityCustomMethodCopyWith<$Res> implements $CustomMethodImplementsCopyWith<$Res> {
  factory $CityCustomMethodCopyWith(CityCustomMethod value, $Res Function(CityCustomMethod) _then) = _$CityCustomMethodCopyWithImpl;
@override @useResult
$Res call({
 String name, int population
});




}
/// @nodoc
class _$CityCustomMethodCopyWithImpl<$Res>
    implements $CityCustomMethodCopyWith<$Res> {
  _$CityCustomMethodCopyWithImpl(this._self, this._then);

  final CityCustomMethod _self;
  final $Res Function(CityCustomMethod) _then;

/// Create a copy of CustomMethodImplements
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? population = null,}) {
  return _then(CityCustomMethod(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == population ? _self.population : population // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class DuplexCustomMethod extends CustomMethodImplements implements Shop, GeographicArea {
  const DuplexCustomMethod(this.name): super._();
  

@override final  String name;

/// Create a copy of CustomMethodImplements
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DuplexCustomMethodCopyWith<DuplexCustomMethod> get copyWith => _$DuplexCustomMethodCopyWithImpl<DuplexCustomMethod>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DuplexCustomMethod&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'CustomMethodImplements.duplex(name: $name)';
}


}

/// @nodoc
abstract mixin class $DuplexCustomMethodCopyWith<$Res> implements $CustomMethodImplementsCopyWith<$Res> {
  factory $DuplexCustomMethodCopyWith(DuplexCustomMethod value, $Res Function(DuplexCustomMethod) _then) = _$DuplexCustomMethodCopyWithImpl;
@override @useResult
$Res call({
 String name
});




}
/// @nodoc
class _$DuplexCustomMethodCopyWithImpl<$Res>
    implements $DuplexCustomMethodCopyWith<$Res> {
  _$DuplexCustomMethodCopyWithImpl(this._self, this._then);

  final DuplexCustomMethod _self;
  final $Res Function(DuplexCustomMethod) _then;

/// Create a copy of CustomMethodImplements
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(DuplexCustomMethod(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$GenericImplements<T> {

 String get name;
/// Create a copy of GenericImplements
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GenericImplementsCopyWith<T, GenericImplements<T>> get copyWith => _$GenericImplementsCopyWithImpl<T, GenericImplements<T>>(this as GenericImplements<T>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GenericImplements<T>&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'GenericImplements<$T>(name: $name)';
}


}

/// @nodoc
abstract mixin class $GenericImplementsCopyWith<T,$Res>  {
  factory $GenericImplementsCopyWith(GenericImplements<T> value, $Res Function(GenericImplements<T>) _then) = _$GenericImplementsCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$GenericImplementsCopyWithImpl<T,$Res>
    implements $GenericImplementsCopyWith<T, $Res> {
  _$GenericImplementsCopyWithImpl(this._self, this._then);

  final GenericImplements<T> _self;
  final $Res Function(GenericImplements<T>) _then;

/// Create a copy of GenericImplements
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc


class GenericPerson<T> implements GenericImplements<T> {
  const GenericPerson(this.name, this.age);
  

@override final  String name;
 final  int age;

/// Create a copy of GenericImplements
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GenericPersonCopyWith<T, GenericPerson<T>> get copyWith => _$GenericPersonCopyWithImpl<T, GenericPerson<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GenericPerson<T>&&(identical(other.name, name) || other.name == name)&&(identical(other.age, age) || other.age == age));
}


@override
int get hashCode => Object.hash(runtimeType,name,age);

@override
String toString() {
  return 'GenericImplements<$T>.person(name: $name, age: $age)';
}


}

/// @nodoc
abstract mixin class $GenericPersonCopyWith<T,$Res> implements $GenericImplementsCopyWith<T, $Res> {
  factory $GenericPersonCopyWith(GenericPerson<T> value, $Res Function(GenericPerson<T>) _then) = _$GenericPersonCopyWithImpl;
@override @useResult
$Res call({
 String name, int age
});




}
/// @nodoc
class _$GenericPersonCopyWithImpl<T,$Res>
    implements $GenericPersonCopyWith<T, $Res> {
  _$GenericPersonCopyWithImpl(this._self, this._then);

  final GenericPerson<T> _self;
  final $Res Function(GenericPerson<T>) _then;

/// Create a copy of GenericImplements
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? age = null,}) {
  return _then(GenericPerson<T>(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class GenericCity<T> with House implements GenericImplements<T>, GeographicArea {
  const GenericCity(this.name, this.population);
  

@override final  String name;
 final  int population;

/// Create a copy of GenericImplements
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GenericCityCopyWith<T, GenericCity<T>> get copyWith => _$GenericCityCopyWithImpl<T, GenericCity<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GenericCity<T>&&(identical(other.name, name) || other.name == name)&&(identical(other.population, population) || other.population == population));
}


@override
int get hashCode => Object.hash(runtimeType,name,population);

@override
String toString() {
  return 'GenericImplements<$T>.city(name: $name, population: $population)';
}


}

/// @nodoc
abstract mixin class $GenericCityCopyWith<T,$Res> implements $GenericImplementsCopyWith<T, $Res> {
  factory $GenericCityCopyWith(GenericCity<T> value, $Res Function(GenericCity<T>) _then) = _$GenericCityCopyWithImpl;
@override @useResult
$Res call({
 String name, int population
});




}
/// @nodoc
class _$GenericCityCopyWithImpl<T,$Res>
    implements $GenericCityCopyWith<T, $Res> {
  _$GenericCityCopyWithImpl(this._self, this._then);

  final GenericCity<T> _self;
  final $Res Function(GenericCity<T>) _then;

/// Create a copy of GenericImplements
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? population = null,}) {
  return _then(GenericCity<T>(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == population ? _self.population : population // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
