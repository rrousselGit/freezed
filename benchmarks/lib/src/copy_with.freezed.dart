// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'copy_with.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Model {

 int get counter;
/// Create a copy of Model
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModelCopyWith<Model> get copyWith => _$ModelCopyWithImpl<Model>(this as Model, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Model&&(identical(other.counter, counter) || other.counter == counter));
}


@override
int get hashCode => Object.hash(runtimeType,counter);

@override
String toString() {
  return 'Model(counter: $counter)';
}


}

/// @nodoc
abstract mixin class $ModelCopyWith<$Res>  {
  factory $ModelCopyWith(Model value, $Res Function(Model) _then) = _$ModelCopyWithImpl;
@useResult
$Res call({
 int counter
});




}
/// @nodoc
class _$ModelCopyWithImpl<$Res>
    implements $ModelCopyWith<$Res> {
  _$ModelCopyWithImpl(this._self, this._then);

  final Model _self;
  final $Res Function(Model) _then;

/// Create a copy of Model
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? counter = null,}) {
  return _then(_self.copyWith(
counter: null == counter ? _self.counter : counter // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc


class _Model implements Model {
   _Model({required this.counter});
  

@override final  int counter;

/// Create a copy of Model
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ModelCopyWith<_Model> get copyWith => __$ModelCopyWithImpl<_Model>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Model&&(identical(other.counter, counter) || other.counter == counter));
}


@override
int get hashCode => Object.hash(runtimeType,counter);

@override
String toString() {
  return 'Model(counter: $counter)';
}


}

/// @nodoc
abstract mixin class _$ModelCopyWith<$Res> implements $ModelCopyWith<$Res> {
  factory _$ModelCopyWith(_Model value, $Res Function(_Model) _then) = __$ModelCopyWithImpl;
@override @useResult
$Res call({
 int counter
});




}
/// @nodoc
class __$ModelCopyWithImpl<$Res>
    implements _$ModelCopyWith<$Res> {
  __$ModelCopyWithImpl(this._self, this._then);

  final _Model _self;
  final $Res Function(_Model) _then;

/// Create a copy of Model
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? counter = null,}) {
  return _then(_Model(
counter: null == counter ? _self.counter : counter // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ModelWrapper {

 Model get model;
/// Create a copy of ModelWrapper
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModelWrapperCopyWith<ModelWrapper> get copyWith => _$ModelWrapperCopyWithImpl<ModelWrapper>(this as ModelWrapper, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModelWrapper&&(identical(other.model, model) || other.model == model));
}


@override
int get hashCode => Object.hash(runtimeType,model);

@override
String toString() {
  return 'ModelWrapper(model: $model)';
}


}

/// @nodoc
abstract mixin class $ModelWrapperCopyWith<$Res>  {
  factory $ModelWrapperCopyWith(ModelWrapper value, $Res Function(ModelWrapper) _then) = _$ModelWrapperCopyWithImpl;
@useResult
$Res call({
 Model model
});


$ModelCopyWith<$Res> get model;

}
/// @nodoc
class _$ModelWrapperCopyWithImpl<$Res>
    implements $ModelWrapperCopyWith<$Res> {
  _$ModelWrapperCopyWithImpl(this._self, this._then);

  final ModelWrapper _self;
  final $Res Function(ModelWrapper) _then;

/// Create a copy of ModelWrapper
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? model = null,}) {
  return _then(_self.copyWith(
model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as Model,
  ));
}
/// Create a copy of ModelWrapper
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ModelCopyWith<$Res> get model {
  
  return $ModelCopyWith<$Res>(_self.model, (value) {
    return _then(_self.copyWith(model: value));
  });
}
}


/// @nodoc


class _ModelWrapper implements ModelWrapper {
   _ModelWrapper({required this.model});
  

@override final  Model model;

/// Create a copy of ModelWrapper
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ModelWrapperCopyWith<_ModelWrapper> get copyWith => __$ModelWrapperCopyWithImpl<_ModelWrapper>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ModelWrapper&&(identical(other.model, model) || other.model == model));
}


@override
int get hashCode => Object.hash(runtimeType,model);

@override
String toString() {
  return 'ModelWrapper(model: $model)';
}


}

/// @nodoc
abstract mixin class _$ModelWrapperCopyWith<$Res> implements $ModelWrapperCopyWith<$Res> {
  factory _$ModelWrapperCopyWith(_ModelWrapper value, $Res Function(_ModelWrapper) _then) = __$ModelWrapperCopyWithImpl;
@override @useResult
$Res call({
 Model model
});


@override $ModelCopyWith<$Res> get model;

}
/// @nodoc
class __$ModelWrapperCopyWithImpl<$Res>
    implements _$ModelWrapperCopyWith<$Res> {
  __$ModelWrapperCopyWithImpl(this._self, this._then);

  final _ModelWrapper _self;
  final $Res Function(_ModelWrapper) _then;

/// Create a copy of ModelWrapper
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? model = null,}) {
  return _then(_ModelWrapper(
model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as Model,
  ));
}

/// Create a copy of ModelWrapper
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ModelCopyWith<$Res> get model {
  
  return $ModelCopyWith<$Res>(_self.model, (value) {
    return _then(_self.copyWith(model: value));
  });
}
}

// dart format on
