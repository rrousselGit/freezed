// dart format width=80
// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'equal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ModelWithList {

 List<int> get someList; int get counter;
/// Create a copy of ModelWithList
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModelWithListCopyWith<ModelWithList> get copyWith => _$ModelWithListCopyWithImpl<ModelWithList>(this as ModelWithList, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModelWithList&&const DeepCollectionEquality().equals(other.someList, someList)&&(identical(other.counter, counter) || other.counter == counter));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(someList),counter);

@override
String toString() {
  return 'ModelWithList(someList: $someList, counter: $counter)';
}


}

/// @nodoc
abstract mixin class $ModelWithListCopyWith<$Res>  {
  factory $ModelWithListCopyWith(ModelWithList value, $Res Function(ModelWithList) _then) = _$ModelWithListCopyWithImpl;
@useResult
$Res call({
 List<int> someList, int counter
});




}
/// @nodoc
class _$ModelWithListCopyWithImpl<$Res>
    implements $ModelWithListCopyWith<$Res> {
  _$ModelWithListCopyWithImpl(this._self, this._then);

  final ModelWithList _self;
  final $Res Function(ModelWithList) _then;

/// Create a copy of ModelWithList
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? someList = null,Object? counter = null,}) {
  return _then(_self.copyWith(
someList: null == someList ? _self.someList : someList // ignore: cast_nullable_to_non_nullable
as List<int>,counter: null == counter ? _self.counter : counter // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc


class _ModelWithList implements ModelWithList {
   _ModelWithList({final  List<int> someList = const <int>[], this.counter = 0}): _someList = someList;


 final  List<int> _someList;
@override@JsonKey() List<int> get someList {
  if (_someList is EqualUnmodifiableListView) return _someList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_someList);
}

@override@JsonKey() final  int counter;

/// Create a copy of ModelWithList
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ModelWithListCopyWith<_ModelWithList> get copyWith => __$ModelWithListCopyWithImpl<_ModelWithList>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ModelWithList&&const DeepCollectionEquality().equals(other._someList, _someList)&&(identical(other.counter, counter) || other.counter == counter));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_someList),counter);

@override
String toString() {
  return 'ModelWithList(someList: $someList, counter: $counter)';
}


}

/// @nodoc
abstract mixin class _$ModelWithListCopyWith<$Res> implements $ModelWithListCopyWith<$Res> {
  factory _$ModelWithListCopyWith(_ModelWithList value, $Res Function(_ModelWithList) _then) = __$ModelWithListCopyWithImpl;
@override @useResult
$Res call({
 List<int> someList, int counter
});




}
/// @nodoc
class __$ModelWithListCopyWithImpl<$Res>
    implements _$ModelWithListCopyWith<$Res> {
  __$ModelWithListCopyWithImpl(this._self, this._then);

  final _ModelWithList _self;
  final $Res Function(_ModelWithList) _then;

/// Create a copy of ModelWithList
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? someList = null,Object? counter = null,}) {
  return _then(_ModelWithList(
someList: null == someList ? _self._someList : someList // ignore: cast_nullable_to_non_nullable
as List<int>,counter: null == counter ? _self.counter : counter // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
