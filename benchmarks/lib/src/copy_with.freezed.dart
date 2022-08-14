// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'copy_with.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Model {
  int get counter => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ModelCopyWith<Model> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModelCopyWith<$Res> {
  factory $ModelCopyWith(Model value, $Res Function(Model) then) =
      _$ModelCopyWithImpl<$Res>;
  $Res call({int counter});
}

/// @nodoc
class _$ModelCopyWithImpl<$Res> implements $ModelCopyWith<$Res> {
  _$ModelCopyWithImpl(this._value, this._then);

  final Model _value;
  // ignore: unused_field
  final $Res Function(Model) _then;

  @override
  $Res call({
    Object? counter = freezed,
  }) {
    return _then(_value.copyWith(
      counter: counter == freezed
          ? _value.counter
          : counter // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_ModelCopyWith<$Res> implements $ModelCopyWith<$Res> {
  factory _$$_ModelCopyWith(_$_Model value, $Res Function(_$_Model) then) =
      __$$_ModelCopyWithImpl<$Res>;
  @override
  $Res call({int counter});
}

/// @nodoc
class __$$_ModelCopyWithImpl<$Res> extends _$ModelCopyWithImpl<$Res>
    implements _$$_ModelCopyWith<$Res> {
  __$$_ModelCopyWithImpl(_$_Model _value, $Res Function(_$_Model) _then)
      : super(_value, (v) => _then(v as _$_Model));

  @override
  _$_Model get _value => super._value as _$_Model;

  @override
  $Res call({
    Object? counter = freezed,
  }) {
    return _then(_$_Model(
      counter: counter == freezed
          ? _value.counter
          : counter // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_Model implements _Model {
  _$_Model({required this.counter});

  @override
  final int counter;

  @override
  String toString() {
    return 'Model(counter: $counter)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Model &&
            const DeepCollectionEquality().equals(other.counter, counter));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(counter));

  @JsonKey(ignore: true)
  @override
  _$$_ModelCopyWith<_$_Model> get copyWith =>
      __$$_ModelCopyWithImpl<_$_Model>(this, _$identity);
}

abstract class _Model implements Model {
  factory _Model({required final int counter}) = _$_Model;

  @override
  int get counter;
  @override
  @JsonKey(ignore: true)
  _$$_ModelCopyWith<_$_Model> get copyWith =>
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
      _$ModelWrapperCopyWithImpl<$Res>;
  $Res call({Model model});

  $ModelCopyWith<$Res> get model;
}

/// @nodoc
class _$ModelWrapperCopyWithImpl<$Res> implements $ModelWrapperCopyWith<$Res> {
  _$ModelWrapperCopyWithImpl(this._value, this._then);

  final ModelWrapper _value;
  // ignore: unused_field
  final $Res Function(ModelWrapper) _then;

  @override
  $Res call({
    Object? model = freezed,
  }) {
    return _then(_value.copyWith(
      model: model == freezed
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as Model,
    ));
  }

  @override
  $ModelCopyWith<$Res> get model {
    return $ModelCopyWith<$Res>(_value.model, (value) {
      return _then(_value.copyWith(model: value));
    });
  }
}

/// @nodoc
abstract class _$$_ModelWrapperCopyWith<$Res>
    implements $ModelWrapperCopyWith<$Res> {
  factory _$$_ModelWrapperCopyWith(
          _$_ModelWrapper value, $Res Function(_$_ModelWrapper) then) =
      __$$_ModelWrapperCopyWithImpl<$Res>;
  @override
  $Res call({Model model});

  @override
  $ModelCopyWith<$Res> get model;
}

/// @nodoc
class __$$_ModelWrapperCopyWithImpl<$Res>
    extends _$ModelWrapperCopyWithImpl<$Res>
    implements _$$_ModelWrapperCopyWith<$Res> {
  __$$_ModelWrapperCopyWithImpl(
      _$_ModelWrapper _value, $Res Function(_$_ModelWrapper) _then)
      : super(_value, (v) => _then(v as _$_ModelWrapper));

  @override
  _$_ModelWrapper get _value => super._value as _$_ModelWrapper;

  @override
  $Res call({
    Object? model = freezed,
  }) {
    return _then(_$_ModelWrapper(
      model: model == freezed
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as Model,
    ));
  }
}

/// @nodoc

class _$_ModelWrapper implements _ModelWrapper {
  _$_ModelWrapper({required this.model});

  @override
  final Model model;

  @override
  String toString() {
    return 'ModelWrapper(model: $model)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ModelWrapper &&
            const DeepCollectionEquality().equals(other.model, model));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(model));

  @JsonKey(ignore: true)
  @override
  _$$_ModelWrapperCopyWith<_$_ModelWrapper> get copyWith =>
      __$$_ModelWrapperCopyWithImpl<_$_ModelWrapper>(this, _$identity);
}

abstract class _ModelWrapper implements ModelWrapper {
  factory _ModelWrapper({required final Model model}) = _$_ModelWrapper;

  @override
  Model get model;
  @override
  @JsonKey(ignore: true)
  _$$_ModelWrapperCopyWith<_$_ModelWrapper> get copyWith =>
      throw _privateConstructorUsedError;
}
