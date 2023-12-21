// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'equal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ModelWithList {
  List<int> get someList => throw _privateConstructorUsedError;
  int get counter => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ModelWithListCopyWith<ModelWithList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModelWithListCopyWith<$Res> {
  factory $ModelWithListCopyWith(
          ModelWithList value, $Res Function(ModelWithList) then) =
      _$ModelWithListCopyWithImpl<$Res, ModelWithList>;
  @useResult
  $Res call({List<int> someList, int counter});
}

/// @nodoc
class _$ModelWithListCopyWithImpl<$Res, $Val extends ModelWithList>
    implements $ModelWithListCopyWith<$Res> {
  _$ModelWithListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? someList = null,
    Object? counter = null,
  }) {
    return _then(_value.copyWith(
      someList: null == someList
          ? _value.someList
          : someList // ignore: cast_nullable_to_non_nullable
              as List<int>,
      counter: null == counter
          ? _value.counter
          : counter // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ModelWithListCopyWith<$Res>
    implements $ModelWithListCopyWith<$Res> {
  factory _$$_ModelWithListCopyWith(
          _$_ModelWithList value, $Res Function(_$_ModelWithList) then) =
      __$$_ModelWithListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<int> someList, int counter});
}

/// @nodoc
class __$$_ModelWithListCopyWithImpl<$Res>
    extends _$ModelWithListCopyWithImpl<$Res, _$_ModelWithList>
    implements _$$_ModelWithListCopyWith<$Res> {
  __$$_ModelWithListCopyWithImpl(
      _$_ModelWithList _value, $Res Function(_$_ModelWithList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? someList = null,
    Object? counter = null,
  }) {
    return _then(_$_ModelWithList(
      someList: null == someList
          ? _value._someList
          : someList // ignore: cast_nullable_to_non_nullable
              as List<int>,
      counter: null == counter
          ? _value.counter
          : counter // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_ModelWithList implements _ModelWithList {
  _$_ModelWithList({final List<int> someList = const <int>[], this.counter = 0})
      : _someList = someList;

  final List<int> _someList;
  @override
  @JsonKey()
  List<int> get someList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_someList);
  }

  @override
  @JsonKey()
  final int counter;

  @override
  String toString() {
    return 'ModelWithList(someList: $someList, counter: $counter)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ModelWithList &&
            const DeepCollectionEquality().equals(other._someList, _someList) &&
            const DeepCollectionEquality().equals(other.counter, counter));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_someList),
      const DeepCollectionEquality().hash(counter));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ModelWithListCopyWith<_$_ModelWithList> get copyWith =>
      __$$_ModelWithListCopyWithImpl<_$_ModelWithList>(this, _$identity);
}

abstract class _ModelWithList implements ModelWithList {
  factory _ModelWithList({final List<int> someList, final int counter}) =
      _$_ModelWithList;

  @override
  List<int> get someList;
  @override
  int get counter;
  @override
  @JsonKey(ignore: true)
  _$$_ModelWithListCopyWith<_$_ModelWithList> get copyWith =>
      throw _privateConstructorUsedError;
}
