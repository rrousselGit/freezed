// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diagnosticable.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Example<T> implements DiagnosticableTreeMixin {

 dynamic get theAnswer;


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Example<$T>'))
    ..add(DiagnosticsProperty('theAnswer', theAnswer));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Example<T>&&const DeepCollectionEquality().equals(other.theAnswer, theAnswer));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(theAnswer));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Example<$T>(theAnswer: $theAnswer)';
}


}

/// @nodoc
class $ExampleCopyWith<T,$Res>  {
$ExampleCopyWith(Example<T> _, $Res Function(Example<T>) __);
}


/// @nodoc


class _Example<T> extends Example<T> with DiagnosticableTreeMixin {
   _Example(this.a, this.b): super._();
  

 final  int a;
 final  String b;

/// Create a copy of Example
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExampleCopyWith<T, _Example<T>> get copyWith => __$ExampleCopyWithImpl<T, _Example<T>>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Example<$T>'))
    ..add(DiagnosticsProperty('a', a))..add(DiagnosticsProperty('b', b));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Example<T>&&(identical(other.a, a) || other.a == a)&&(identical(other.b, b) || other.b == b));
}


@override
int get hashCode => Object.hash(runtimeType,a,b);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
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


class _Example2<T> extends Example<T> with DiagnosticableTreeMixin {
   _Example2(this.c): super._();
  

 final  T c;

/// Create a copy of Example
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Example2CopyWith<T, _Example2<T>> get copyWith => __$Example2CopyWithImpl<T, _Example2<T>>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Example<$T>.named'))
    ..add(DiagnosticsProperty('c', c));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Example2<T>&&const DeepCollectionEquality().equals(other.c, c));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(c));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
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
mixin _$ConcreteExample<T> implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ConcreteExample<$T>'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConcreteExample<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ConcreteExample<$T>()';
}


}

/// @nodoc
class $ConcreteExampleCopyWith<T,$Res>  {
$ConcreteExampleCopyWith(ConcreteExample<T> _, $Res Function(ConcreteExample<T>) __);
}


/// @nodoc


class _ConcreteExample<T> extends ConcreteExample<T> with DiagnosticableTreeMixin {
   _ConcreteExample(): super._();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ConcreteExample<$T>'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConcreteExample<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ConcreteExample<$T>()';
}


}




/// @nodoc
mixin _$ToString {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToString);
}


@override
int get hashCode => runtimeType.hashCode;



}

/// @nodoc
class $ToStringCopyWith<$Res>  {
$ToStringCopyWith(ToString _, $Res Function(ToString) __);
}


/// @nodoc


class _ToString extends ToString {
   _ToString(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToString);
}


@override
int get hashCode => runtimeType.hashCode;



}




// dart format on
