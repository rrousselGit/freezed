// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'copy_with.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Model {
  int get counter => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ModelCopyWith<Model> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModelCopyWith<$Res> {
  factory $ModelCopyWith(Model value, $Res Function(Model) then) =
      _$ModelCopyWithImpl<$Res, Model>;
  @useResult
  $Res call({int counter});
}

/// @nodoc
class _$ModelCopyWithImpl<$Res, $Val extends Model>
    implements $ModelCopyWith<$Res> {
  _$ModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? counter = null,
  }) {
    return _then(_value.copyWith(
      counter: null == counter
          ? _value.counter
          : counter // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ModelImplCopyWith<$Res> implements $ModelCopyWith<$Res> {
  factory _$$ModelImplCopyWith(
          _$ModelImpl value, $Res Function(_$ModelImpl) then) =
      __$$ModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int counter});
}

/// @nodoc
class __$$ModelImplCopyWithImpl<$Res>
    extends _$ModelCopyWithImpl<$Res, _$ModelImpl>
    implements _$$ModelImplCopyWith<$Res> {
  __$$ModelImplCopyWithImpl(
      _$ModelImpl _value, $Res Function(_$ModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? counter = null,
  }) {
    return _then(_$ModelImpl(
      counter: null == counter
          ? _value.counter
          : counter // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ModelImpl implements _Model {
  _$ModelImpl({required this.counter});

  @override
  final int counter;

  @override
  String toString() {
    return 'Model.Model(counter: $counter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModelImpl &&
            (identical(other.counter, counter) || other.counter == counter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, counter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ModelImplCopyWith<_$ModelImpl> get copyWith =>
      __$$ModelImplCopyWithImpl<_$ModelImpl>(this, _$identity);
}

abstract class _Model implements Model {
  factory _Model({required final int counter}) = _$ModelImpl;

  @override
  int get counter;
  @override
  @JsonKey(ignore: true)
  _$$ModelImplCopyWith<_$ModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ModelWrapper {
  Model get model => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ModelWrapperCopyWith<ModelWrapper> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModelWrapperCopyWith<$Res> {
  factory $ModelWrapperCopyWith(
          ModelWrapper value, $Res Function(ModelWrapper) then) =
      _$ModelWrapperCopyWithImpl<$Res, ModelWrapper>;
  @useResult
  $Res call({Model model});

  $ModelCopyWith<$Res> get model;
}

/// @nodoc
class _$ModelWrapperCopyWithImpl<$Res, $Val extends ModelWrapper>
    implements $ModelWrapperCopyWith<$Res> {
  _$ModelWrapperCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? model = null,
  }) {
    return _then(_value.copyWith(
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as Model,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ModelCopyWith<$Res> get model {
    return $ModelCopyWith<$Res>(_value.model, (value) {
      return _then(_value.copyWith(model: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ModelWrapperImplCopyWith<$Res>
    implements $ModelWrapperCopyWith<$Res> {
  factory _$$ModelWrapperImplCopyWith(
          _$ModelWrapperImpl value, $Res Function(_$ModelWrapperImpl) then) =
      __$$ModelWrapperImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Model model});

  @override
  $ModelCopyWith<$Res> get model;
}

/// @nodoc
class __$$ModelWrapperImplCopyWithImpl<$Res>
    extends _$ModelWrapperCopyWithImpl<$Res, _$ModelWrapperImpl>
    implements _$$ModelWrapperImplCopyWith<$Res> {
  __$$ModelWrapperImplCopyWithImpl(
      _$ModelWrapperImpl _value, $Res Function(_$ModelWrapperImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? model = null,
  }) {
    return _then(_$ModelWrapperImpl(
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as Model,
    ));
  }
}

/// @nodoc

class _$ModelWrapperImpl implements _ModelWrapper {
  _$ModelWrapperImpl({required this.model});

  @override
  final Model model;

  @override
  String toString() {
    return 'ModelWrapper.ModelWrapper(model: $model)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModelWrapperImpl &&
            (identical(other.model, model) || other.model == model));
  }

  @override
  int get hashCode => Object.hash(runtimeType, model);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ModelWrapperImplCopyWith<_$ModelWrapperImpl> get copyWith =>
      __$$ModelWrapperImplCopyWithImpl<_$ModelWrapperImpl>(this, _$identity);
}

abstract class _ModelWrapper implements ModelWrapper {
  factory _ModelWrapper({required final Model model}) = _$ModelWrapperImpl;

  @override
  Model get model;
  @override
  @JsonKey(ignore: true)
  _$$ModelWrapperImplCopyWith<_$ModelWrapperImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
