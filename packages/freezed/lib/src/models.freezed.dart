// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DeepCloneableProperty {
  String get name => throw _privateConstructorUsedError;
  String get typeName => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  bool get nullable => throw _privateConstructorUsedError;
  bool get isDowncastedToNullable => throw _privateConstructorUsedError;
  GenericsParameterTemplate get genericParameters =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeepCloneablePropertyCopyWith<DeepCloneableProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeepCloneablePropertyCopyWith<$Res> {
  factory $DeepCloneablePropertyCopyWith(DeepCloneableProperty value,
          $Res Function(DeepCloneableProperty) then) =
      _$DeepCloneablePropertyCopyWithImpl<$Res, DeepCloneableProperty>;
  @useResult
  $Res call(
      {String name,
      String typeName,
      String type,
      bool nullable,
      bool isDowncastedToNullable,
      GenericsParameterTemplate genericParameters});
}

/// @nodoc
class _$DeepCloneablePropertyCopyWithImpl<$Res,
        $Val extends DeepCloneableProperty>
    implements $DeepCloneablePropertyCopyWith<$Res> {
  _$DeepCloneablePropertyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? typeName = null,
    Object? type = null,
    Object? nullable = null,
    Object? isDowncastedToNullable = null,
    Object? genericParameters = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      typeName: null == typeName
          ? _value.typeName
          : typeName // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      nullable: null == nullable
          ? _value.nullable
          : nullable // ignore: cast_nullable_to_non_nullable
              as bool,
      isDowncastedToNullable: null == isDowncastedToNullable
          ? _value.isDowncastedToNullable
          : isDowncastedToNullable // ignore: cast_nullable_to_non_nullable
              as bool,
      genericParameters: null == genericParameters
          ? _value.genericParameters
          : genericParameters // ignore: cast_nullable_to_non_nullable
              as GenericsParameterTemplate,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DeepCloneablePropertyCopyWith<$Res>
    implements $DeepCloneablePropertyCopyWith<$Res> {
  factory _$$_DeepCloneablePropertyCopyWith(_$_DeepCloneableProperty value,
          $Res Function(_$_DeepCloneableProperty) then) =
      __$$_DeepCloneablePropertyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String typeName,
      String type,
      bool nullable,
      bool isDowncastedToNullable,
      GenericsParameterTemplate genericParameters});
}

/// @nodoc
class __$$_DeepCloneablePropertyCopyWithImpl<$Res>
    extends _$DeepCloneablePropertyCopyWithImpl<$Res, _$_DeepCloneableProperty>
    implements _$$_DeepCloneablePropertyCopyWith<$Res> {
  __$$_DeepCloneablePropertyCopyWithImpl(_$_DeepCloneableProperty _value,
      $Res Function(_$_DeepCloneableProperty) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? typeName = null,
    Object? type = null,
    Object? nullable = null,
    Object? isDowncastedToNullable = null,
    Object? genericParameters = null,
  }) {
    return _then(_$_DeepCloneableProperty(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      typeName: null == typeName
          ? _value.typeName
          : typeName // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      nullable: null == nullable
          ? _value.nullable
          : nullable // ignore: cast_nullable_to_non_nullable
              as bool,
      isDowncastedToNullable: null == isDowncastedToNullable
          ? _value.isDowncastedToNullable
          : isDowncastedToNullable // ignore: cast_nullable_to_non_nullable
              as bool,
      genericParameters: null == genericParameters
          ? _value.genericParameters
          : genericParameters // ignore: cast_nullable_to_non_nullable
              as GenericsParameterTemplate,
    ));
  }
}

/// @nodoc

class _$_DeepCloneableProperty implements _DeepCloneableProperty {
  _$_DeepCloneableProperty(
      {required this.name,
      required this.typeName,
      required this.type,
      required this.nullable,
      required this.isDowncastedToNullable,
      required this.genericParameters});

  @override
  final String name;
  @override
  final String typeName;
  @override
  final String type;
  @override
  final bool nullable;
  @override
  final bool isDowncastedToNullable;
  @override
  final GenericsParameterTemplate genericParameters;

  @override
  String toString() {
    return 'DeepCloneableProperty(name: $name, typeName: $typeName, type: $type, nullable: $nullable, isDowncastedToNullable: $isDowncastedToNullable, genericParameters: $genericParameters)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeepCloneableProperty &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.typeName, typeName) ||
                other.typeName == typeName) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.nullable, nullable) ||
                other.nullable == nullable) &&
            (identical(other.isDowncastedToNullable, isDowncastedToNullable) ||
                other.isDowncastedToNullable == isDowncastedToNullable) &&
            (identical(other.genericParameters, genericParameters) ||
                other.genericParameters == genericParameters));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, typeName, type, nullable,
      isDowncastedToNullable, genericParameters);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DeepCloneablePropertyCopyWith<_$_DeepCloneableProperty> get copyWith =>
      __$$_DeepCloneablePropertyCopyWithImpl<_$_DeepCloneableProperty>(
          this, _$identity);
}

abstract class _DeepCloneableProperty implements DeepCloneableProperty {
  factory _DeepCloneableProperty(
          {required final String name,
          required final String typeName,
          required final String type,
          required final bool nullable,
          required final bool isDowncastedToNullable,
          required final GenericsParameterTemplate genericParameters}) =
      _$_DeepCloneableProperty;

  @override
  String get name;
  @override
  String get typeName;
  @override
  String get type;
  @override
  bool get nullable;
  @override
  bool get isDowncastedToNullable;
  @override
  GenericsParameterTemplate get genericParameters;
  @override
  @JsonKey(ignore: true)
  _$$_DeepCloneablePropertyCopyWith<_$_DeepCloneableProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ConstructorDetails {
  String get name => throw _privateConstructorUsedError;
  String get unionValue => throw _privateConstructorUsedError;
  bool get isConst => throw _privateConstructorUsedError;
  String get redirectedName => throw _privateConstructorUsedError;
  ParametersTemplate get parameters => throw _privateConstructorUsedError;
  List<Property> get impliedProperties => throw _privateConstructorUsedError;
  bool get isDefault => throw _privateConstructorUsedError;
  bool get isFallback => throw _privateConstructorUsedError;
  bool get hasJsonSerializable => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get escapedName => throw _privateConstructorUsedError;
  List<String> get withDecorators => throw _privateConstructorUsedError;
  List<String> get implementsDecorators => throw _privateConstructorUsedError;
  List<String> get decorators => throw _privateConstructorUsedError;
  List<DeepCloneableProperty> get cloneableProperties =>
      throw _privateConstructorUsedError;
  List<AssertTemplate> get asserts => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ConstructorDetailsCopyWith<ConstructorDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConstructorDetailsCopyWith<$Res> {
  factory $ConstructorDetailsCopyWith(
          ConstructorDetails value, $Res Function(ConstructorDetails) then) =
      _$ConstructorDetailsCopyWithImpl<$Res, ConstructorDetails>;
  @useResult
  $Res call(
      {String name,
      String unionValue,
      bool isConst,
      String redirectedName,
      ParametersTemplate parameters,
      List<Property> impliedProperties,
      bool isDefault,
      bool isFallback,
      bool hasJsonSerializable,
      String fullName,
      String escapedName,
      List<String> withDecorators,
      List<String> implementsDecorators,
      List<String> decorators,
      List<DeepCloneableProperty> cloneableProperties,
      List<AssertTemplate> asserts});
}

/// @nodoc
class _$ConstructorDetailsCopyWithImpl<$Res, $Val extends ConstructorDetails>
    implements $ConstructorDetailsCopyWith<$Res> {
  _$ConstructorDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? unionValue = null,
    Object? isConst = null,
    Object? redirectedName = null,
    Object? parameters = null,
    Object? impliedProperties = null,
    Object? isDefault = null,
    Object? isFallback = null,
    Object? hasJsonSerializable = null,
    Object? fullName = null,
    Object? escapedName = null,
    Object? withDecorators = null,
    Object? implementsDecorators = null,
    Object? decorators = null,
    Object? cloneableProperties = null,
    Object? asserts = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unionValue: null == unionValue
          ? _value.unionValue
          : unionValue // ignore: cast_nullable_to_non_nullable
              as String,
      isConst: null == isConst
          ? _value.isConst
          : isConst // ignore: cast_nullable_to_non_nullable
              as bool,
      redirectedName: null == redirectedName
          ? _value.redirectedName
          : redirectedName // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: null == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as ParametersTemplate,
      impliedProperties: null == impliedProperties
          ? _value.impliedProperties
          : impliedProperties // ignore: cast_nullable_to_non_nullable
              as List<Property>,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      isFallback: null == isFallback
          ? _value.isFallback
          : isFallback // ignore: cast_nullable_to_non_nullable
              as bool,
      hasJsonSerializable: null == hasJsonSerializable
          ? _value.hasJsonSerializable
          : hasJsonSerializable // ignore: cast_nullable_to_non_nullable
              as bool,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      escapedName: null == escapedName
          ? _value.escapedName
          : escapedName // ignore: cast_nullable_to_non_nullable
              as String,
      withDecorators: null == withDecorators
          ? _value.withDecorators
          : withDecorators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      implementsDecorators: null == implementsDecorators
          ? _value.implementsDecorators
          : implementsDecorators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      decorators: null == decorators
          ? _value.decorators
          : decorators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      cloneableProperties: null == cloneableProperties
          ? _value.cloneableProperties
          : cloneableProperties // ignore: cast_nullable_to_non_nullable
              as List<DeepCloneableProperty>,
      asserts: null == asserts
          ? _value.asserts
          : asserts // ignore: cast_nullable_to_non_nullable
              as List<AssertTemplate>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ConstructorDetailsCopyWith<$Res>
    implements $ConstructorDetailsCopyWith<$Res> {
  factory _$$_ConstructorDetailsCopyWith(_$_ConstructorDetails value,
          $Res Function(_$_ConstructorDetails) then) =
      __$$_ConstructorDetailsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String unionValue,
      bool isConst,
      String redirectedName,
      ParametersTemplate parameters,
      List<Property> impliedProperties,
      bool isDefault,
      bool isFallback,
      bool hasJsonSerializable,
      String fullName,
      String escapedName,
      List<String> withDecorators,
      List<String> implementsDecorators,
      List<String> decorators,
      List<DeepCloneableProperty> cloneableProperties,
      List<AssertTemplate> asserts});
}

/// @nodoc
class __$$_ConstructorDetailsCopyWithImpl<$Res>
    extends _$ConstructorDetailsCopyWithImpl<$Res, _$_ConstructorDetails>
    implements _$$_ConstructorDetailsCopyWith<$Res> {
  __$$_ConstructorDetailsCopyWithImpl(
      _$_ConstructorDetails _value, $Res Function(_$_ConstructorDetails) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? unionValue = null,
    Object? isConst = null,
    Object? redirectedName = null,
    Object? parameters = null,
    Object? impliedProperties = null,
    Object? isDefault = null,
    Object? isFallback = null,
    Object? hasJsonSerializable = null,
    Object? fullName = null,
    Object? escapedName = null,
    Object? withDecorators = null,
    Object? implementsDecorators = null,
    Object? decorators = null,
    Object? cloneableProperties = null,
    Object? asserts = null,
  }) {
    return _then(_$_ConstructorDetails(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unionValue: null == unionValue
          ? _value.unionValue
          : unionValue // ignore: cast_nullable_to_non_nullable
              as String,
      isConst: null == isConst
          ? _value.isConst
          : isConst // ignore: cast_nullable_to_non_nullable
              as bool,
      redirectedName: null == redirectedName
          ? _value.redirectedName
          : redirectedName // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: null == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as ParametersTemplate,
      impliedProperties: null == impliedProperties
          ? _value._impliedProperties
          : impliedProperties // ignore: cast_nullable_to_non_nullable
              as List<Property>,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      isFallback: null == isFallback
          ? _value.isFallback
          : isFallback // ignore: cast_nullable_to_non_nullable
              as bool,
      hasJsonSerializable: null == hasJsonSerializable
          ? _value.hasJsonSerializable
          : hasJsonSerializable // ignore: cast_nullable_to_non_nullable
              as bool,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      escapedName: null == escapedName
          ? _value.escapedName
          : escapedName // ignore: cast_nullable_to_non_nullable
              as String,
      withDecorators: null == withDecorators
          ? _value._withDecorators
          : withDecorators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      implementsDecorators: null == implementsDecorators
          ? _value._implementsDecorators
          : implementsDecorators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      decorators: null == decorators
          ? _value._decorators
          : decorators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      cloneableProperties: null == cloneableProperties
          ? _value._cloneableProperties
          : cloneableProperties // ignore: cast_nullable_to_non_nullable
              as List<DeepCloneableProperty>,
      asserts: null == asserts
          ? _value._asserts
          : asserts // ignore: cast_nullable_to_non_nullable
              as List<AssertTemplate>,
    ));
  }
}

/// @nodoc

class _$_ConstructorDetails extends _ConstructorDetails {
  _$_ConstructorDetails(
      {required this.name,
      required this.unionValue,
      required this.isConst,
      required this.redirectedName,
      required this.parameters,
      required final List<Property> impliedProperties,
      required this.isDefault,
      required this.isFallback,
      required this.hasJsonSerializable,
      required this.fullName,
      required this.escapedName,
      required final List<String> withDecorators,
      required final List<String> implementsDecorators,
      required final List<String> decorators,
      required final List<DeepCloneableProperty> cloneableProperties,
      required final List<AssertTemplate> asserts})
      : _impliedProperties = impliedProperties,
        _withDecorators = withDecorators,
        _implementsDecorators = implementsDecorators,
        _decorators = decorators,
        _cloneableProperties = cloneableProperties,
        _asserts = asserts,
        super._();

  @override
  final String name;
  @override
  final String unionValue;
  @override
  final bool isConst;
  @override
  final String redirectedName;
  @override
  final ParametersTemplate parameters;
  final List<Property> _impliedProperties;
  @override
  List<Property> get impliedProperties {
    if (_impliedProperties is EqualUnmodifiableListView)
      return _impliedProperties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_impliedProperties);
  }

  @override
  final bool isDefault;
  @override
  final bool isFallback;
  @override
  final bool hasJsonSerializable;
  @override
  final String fullName;
  @override
  final String escapedName;
  final List<String> _withDecorators;
  @override
  List<String> get withDecorators {
    if (_withDecorators is EqualUnmodifiableListView) return _withDecorators;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_withDecorators);
  }

  final List<String> _implementsDecorators;
  @override
  List<String> get implementsDecorators {
    if (_implementsDecorators is EqualUnmodifiableListView)
      return _implementsDecorators;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_implementsDecorators);
  }

  final List<String> _decorators;
  @override
  List<String> get decorators {
    if (_decorators is EqualUnmodifiableListView) return _decorators;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_decorators);
  }

  final List<DeepCloneableProperty> _cloneableProperties;
  @override
  List<DeepCloneableProperty> get cloneableProperties {
    if (_cloneableProperties is EqualUnmodifiableListView)
      return _cloneableProperties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cloneableProperties);
  }

  final List<AssertTemplate> _asserts;
  @override
  List<AssertTemplate> get asserts {
    if (_asserts is EqualUnmodifiableListView) return _asserts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_asserts);
  }

  @override
  String toString() {
    return 'ConstructorDetails(name: $name, unionValue: $unionValue, isConst: $isConst, redirectedName: $redirectedName, parameters: $parameters, impliedProperties: $impliedProperties, isDefault: $isDefault, isFallback: $isFallback, hasJsonSerializable: $hasJsonSerializable, fullName: $fullName, escapedName: $escapedName, withDecorators: $withDecorators, implementsDecorators: $implementsDecorators, decorators: $decorators, cloneableProperties: $cloneableProperties, asserts: $asserts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConstructorDetails &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.unionValue, unionValue) ||
                other.unionValue == unionValue) &&
            (identical(other.isConst, isConst) || other.isConst == isConst) &&
            (identical(other.redirectedName, redirectedName) ||
                other.redirectedName == redirectedName) &&
            (identical(other.parameters, parameters) ||
                other.parameters == parameters) &&
            const DeepCollectionEquality()
                .equals(other._impliedProperties, _impliedProperties) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.isFallback, isFallback) ||
                other.isFallback == isFallback) &&
            (identical(other.hasJsonSerializable, hasJsonSerializable) ||
                other.hasJsonSerializable == hasJsonSerializable) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.escapedName, escapedName) ||
                other.escapedName == escapedName) &&
            const DeepCollectionEquality()
                .equals(other._withDecorators, _withDecorators) &&
            const DeepCollectionEquality()
                .equals(other._implementsDecorators, _implementsDecorators) &&
            const DeepCollectionEquality()
                .equals(other._decorators, _decorators) &&
            const DeepCollectionEquality()
                .equals(other._cloneableProperties, _cloneableProperties) &&
            const DeepCollectionEquality().equals(other._asserts, _asserts));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      unionValue,
      isConst,
      redirectedName,
      parameters,
      const DeepCollectionEquality().hash(_impliedProperties),
      isDefault,
      isFallback,
      hasJsonSerializable,
      fullName,
      escapedName,
      const DeepCollectionEquality().hash(_withDecorators),
      const DeepCollectionEquality().hash(_implementsDecorators),
      const DeepCollectionEquality().hash(_decorators),
      const DeepCollectionEquality().hash(_cloneableProperties),
      const DeepCollectionEquality().hash(_asserts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ConstructorDetailsCopyWith<_$_ConstructorDetails> get copyWith =>
      __$$_ConstructorDetailsCopyWithImpl<_$_ConstructorDetails>(
          this, _$identity);
}

abstract class _ConstructorDetails extends ConstructorDetails {
  factory _ConstructorDetails(
      {required final String name,
      required final String unionValue,
      required final bool isConst,
      required final String redirectedName,
      required final ParametersTemplate parameters,
      required final List<Property> impliedProperties,
      required final bool isDefault,
      required final bool isFallback,
      required final bool hasJsonSerializable,
      required final String fullName,
      required final String escapedName,
      required final List<String> withDecorators,
      required final List<String> implementsDecorators,
      required final List<String> decorators,
      required final List<DeepCloneableProperty> cloneableProperties,
      required final List<AssertTemplate> asserts}) = _$_ConstructorDetails;
  _ConstructorDetails._() : super._();

  @override
  String get name;
  @override
  String get unionValue;
  @override
  bool get isConst;
  @override
  String get redirectedName;
  @override
  ParametersTemplate get parameters;
  @override
  List<Property> get impliedProperties;
  @override
  bool get isDefault;
  @override
  bool get isFallback;
  @override
  bool get hasJsonSerializable;
  @override
  String get fullName;
  @override
  String get escapedName;
  @override
  List<String> get withDecorators;
  @override
  List<String> get implementsDecorators;
  @override
  List<String> get decorators;
  @override
  List<DeepCloneableProperty> get cloneableProperties;
  @override
  List<AssertTemplate> get asserts;
  @override
  @JsonKey(ignore: true)
  _$$_ConstructorDetailsCopyWith<_$_ConstructorDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MapConfig {
  bool get map => throw _privateConstructorUsedError;
  bool get mapOrNull => throw _privateConstructorUsedError;
  bool get maybeMap => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MapConfigCopyWith<MapConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapConfigCopyWith<$Res> {
  factory $MapConfigCopyWith(MapConfig value, $Res Function(MapConfig) then) =
      _$MapConfigCopyWithImpl<$Res, MapConfig>;
  @useResult
  $Res call({bool map, bool mapOrNull, bool maybeMap});
}

/// @nodoc
class _$MapConfigCopyWithImpl<$Res, $Val extends MapConfig>
    implements $MapConfigCopyWith<$Res> {
  _$MapConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? map = null,
    Object? mapOrNull = null,
    Object? maybeMap = null,
  }) {
    return _then(_value.copyWith(
      map: null == map
          ? _value.map
          : map // ignore: cast_nullable_to_non_nullable
              as bool,
      mapOrNull: null == mapOrNull
          ? _value.mapOrNull
          : mapOrNull // ignore: cast_nullable_to_non_nullable
              as bool,
      maybeMap: null == maybeMap
          ? _value.maybeMap
          : maybeMap // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MapConfigCopyWith<$Res> implements $MapConfigCopyWith<$Res> {
  factory _$$_MapConfigCopyWith(
          _$_MapConfig value, $Res Function(_$_MapConfig) then) =
      __$$_MapConfigCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool map, bool mapOrNull, bool maybeMap});
}

/// @nodoc
class __$$_MapConfigCopyWithImpl<$Res>
    extends _$MapConfigCopyWithImpl<$Res, _$_MapConfig>
    implements _$$_MapConfigCopyWith<$Res> {
  __$$_MapConfigCopyWithImpl(
      _$_MapConfig _value, $Res Function(_$_MapConfig) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? map = null,
    Object? mapOrNull = null,
    Object? maybeMap = null,
  }) {
    return _then(_$_MapConfig(
      map: null == map
          ? _value.map
          : map // ignore: cast_nullable_to_non_nullable
              as bool,
      mapOrNull: null == mapOrNull
          ? _value.mapOrNull
          : mapOrNull // ignore: cast_nullable_to_non_nullable
              as bool,
      maybeMap: null == maybeMap
          ? _value.maybeMap
          : maybeMap // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_MapConfig implements _MapConfig {
  _$_MapConfig(
      {required this.map, required this.mapOrNull, required this.maybeMap});

  @override
  final bool map;
  @override
  final bool mapOrNull;
  @override
  final bool maybeMap;

  @override
  String toString() {
    return 'MapConfig(map: $map, mapOrNull: $mapOrNull, maybeMap: $maybeMap)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MapConfig &&
            (identical(other.map, map) || other.map == map) &&
            (identical(other.mapOrNull, mapOrNull) ||
                other.mapOrNull == mapOrNull) &&
            (identical(other.maybeMap, maybeMap) ||
                other.maybeMap == maybeMap));
  }

  @override
  int get hashCode => Object.hash(runtimeType, map, mapOrNull, maybeMap);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MapConfigCopyWith<_$_MapConfig> get copyWith =>
      __$$_MapConfigCopyWithImpl<_$_MapConfig>(this, _$identity);
}

abstract class _MapConfig implements MapConfig {
  factory _MapConfig(
      {required final bool map,
      required final bool mapOrNull,
      required final bool maybeMap}) = _$_MapConfig;

  @override
  bool get map;
  @override
  bool get mapOrNull;
  @override
  bool get maybeMap;
  @override
  @JsonKey(ignore: true)
  _$$_MapConfigCopyWith<_$_MapConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WhenConfig {
  bool get when => throw _privateConstructorUsedError;
  bool get whenOrNull => throw _privateConstructorUsedError;
  bool get maybeWhen => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WhenConfigCopyWith<WhenConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WhenConfigCopyWith<$Res> {
  factory $WhenConfigCopyWith(
          WhenConfig value, $Res Function(WhenConfig) then) =
      _$WhenConfigCopyWithImpl<$Res, WhenConfig>;
  @useResult
  $Res call({bool when, bool whenOrNull, bool maybeWhen});
}

/// @nodoc
class _$WhenConfigCopyWithImpl<$Res, $Val extends WhenConfig>
    implements $WhenConfigCopyWith<$Res> {
  _$WhenConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? when = null,
    Object? whenOrNull = null,
    Object? maybeWhen = null,
  }) {
    return _then(_value.copyWith(
      when: null == when
          ? _value.when
          : when // ignore: cast_nullable_to_non_nullable
              as bool,
      whenOrNull: null == whenOrNull
          ? _value.whenOrNull
          : whenOrNull // ignore: cast_nullable_to_non_nullable
              as bool,
      maybeWhen: null == maybeWhen
          ? _value.maybeWhen
          : maybeWhen // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WhenConfigCopyWith<$Res>
    implements $WhenConfigCopyWith<$Res> {
  factory _$$_WhenConfigCopyWith(
          _$_WhenConfig value, $Res Function(_$_WhenConfig) then) =
      __$$_WhenConfigCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool when, bool whenOrNull, bool maybeWhen});
}

/// @nodoc
class __$$_WhenConfigCopyWithImpl<$Res>
    extends _$WhenConfigCopyWithImpl<$Res, _$_WhenConfig>
    implements _$$_WhenConfigCopyWith<$Res> {
  __$$_WhenConfigCopyWithImpl(
      _$_WhenConfig _value, $Res Function(_$_WhenConfig) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? when = null,
    Object? whenOrNull = null,
    Object? maybeWhen = null,
  }) {
    return _then(_$_WhenConfig(
      when: null == when
          ? _value.when
          : when // ignore: cast_nullable_to_non_nullable
              as bool,
      whenOrNull: null == whenOrNull
          ? _value.whenOrNull
          : whenOrNull // ignore: cast_nullable_to_non_nullable
              as bool,
      maybeWhen: null == maybeWhen
          ? _value.maybeWhen
          : maybeWhen // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_WhenConfig implements _WhenConfig {
  _$_WhenConfig(
      {required this.when, required this.whenOrNull, required this.maybeWhen});

  @override
  final bool when;
  @override
  final bool whenOrNull;
  @override
  final bool maybeWhen;

  @override
  String toString() {
    return 'WhenConfig(when: $when, whenOrNull: $whenOrNull, maybeWhen: $maybeWhen)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WhenConfig &&
            (identical(other.when, when) || other.when == when) &&
            (identical(other.whenOrNull, whenOrNull) ||
                other.whenOrNull == whenOrNull) &&
            (identical(other.maybeWhen, maybeWhen) ||
                other.maybeWhen == maybeWhen));
  }

  @override
  int get hashCode => Object.hash(runtimeType, when, whenOrNull, maybeWhen);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WhenConfigCopyWith<_$_WhenConfig> get copyWith =>
      __$$_WhenConfigCopyWithImpl<_$_WhenConfig>(this, _$identity);
}

abstract class _WhenConfig implements WhenConfig {
  factory _WhenConfig(
      {required final bool when,
      required final bool whenOrNull,
      required final bool maybeWhen}) = _$_WhenConfig;

  @override
  bool get when;
  @override
  bool get whenOrNull;
  @override
  bool get maybeWhen;
  @override
  @JsonKey(ignore: true)
  _$$_WhenConfigCopyWith<_$_WhenConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Data {
  String get name => throw _privateConstructorUsedError;
  String get unionKey => throw _privateConstructorUsedError;
  bool get generateCopyWith => throw _privateConstructorUsedError;
  bool get generateEqual => throw _privateConstructorUsedError;
  bool get generateToString => throw _privateConstructorUsedError;
  MapConfig get map => throw _privateConstructorUsedError;
  WhenConfig get when => throw _privateConstructorUsedError;
  bool get generateFromJson => throw _privateConstructorUsedError;
  bool get generateToJson => throw _privateConstructorUsedError;
  bool get makeCollectionsImmutable => throw _privateConstructorUsedError;
  List<String> get concretePropertiesName => throw _privateConstructorUsedError;
  List<ConstructorDetails> get constructors =>
      throw _privateConstructorUsedError;
  GenericsDefinitionTemplate get genericsDefinitionTemplate =>
      throw _privateConstructorUsedError;
  GenericsParameterTemplate get genericsParameterTemplate =>
      throw _privateConstructorUsedError;
  bool get shouldUseExtends => throw _privateConstructorUsedError;
  bool get genericArgumentFactories => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DataCopyWith<Data> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataCopyWith<$Res> {
  factory $DataCopyWith(Data value, $Res Function(Data) then) =
      _$DataCopyWithImpl<$Res, Data>;
  @useResult
  $Res call(
      {String name,
      String unionKey,
      bool generateCopyWith,
      bool generateEqual,
      bool generateToString,
      MapConfig map,
      WhenConfig when,
      bool generateFromJson,
      bool generateToJson,
      bool makeCollectionsImmutable,
      List<String> concretePropertiesName,
      List<ConstructorDetails> constructors,
      GenericsDefinitionTemplate genericsDefinitionTemplate,
      GenericsParameterTemplate genericsParameterTemplate,
      bool shouldUseExtends,
      bool genericArgumentFactories});

  $MapConfigCopyWith<$Res> get map;
  $WhenConfigCopyWith<$Res> get when;
}

/// @nodoc
class _$DataCopyWithImpl<$Res, $Val extends Data>
    implements $DataCopyWith<$Res> {
  _$DataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? unionKey = null,
    Object? generateCopyWith = null,
    Object? generateEqual = null,
    Object? generateToString = null,
    Object? map = null,
    Object? when = null,
    Object? generateFromJson = null,
    Object? generateToJson = null,
    Object? makeCollectionsImmutable = null,
    Object? concretePropertiesName = null,
    Object? constructors = null,
    Object? genericsDefinitionTemplate = null,
    Object? genericsParameterTemplate = null,
    Object? shouldUseExtends = null,
    Object? genericArgumentFactories = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unionKey: null == unionKey
          ? _value.unionKey
          : unionKey // ignore: cast_nullable_to_non_nullable
              as String,
      generateCopyWith: null == generateCopyWith
          ? _value.generateCopyWith
          : generateCopyWith // ignore: cast_nullable_to_non_nullable
              as bool,
      generateEqual: null == generateEqual
          ? _value.generateEqual
          : generateEqual // ignore: cast_nullable_to_non_nullable
              as bool,
      generateToString: null == generateToString
          ? _value.generateToString
          : generateToString // ignore: cast_nullable_to_non_nullable
              as bool,
      map: null == map
          ? _value.map
          : map // ignore: cast_nullable_to_non_nullable
              as MapConfig,
      when: null == when
          ? _value.when
          : when // ignore: cast_nullable_to_non_nullable
              as WhenConfig,
      generateFromJson: null == generateFromJson
          ? _value.generateFromJson
          : generateFromJson // ignore: cast_nullable_to_non_nullable
              as bool,
      generateToJson: null == generateToJson
          ? _value.generateToJson
          : generateToJson // ignore: cast_nullable_to_non_nullable
              as bool,
      makeCollectionsImmutable: null == makeCollectionsImmutable
          ? _value.makeCollectionsImmutable
          : makeCollectionsImmutable // ignore: cast_nullable_to_non_nullable
              as bool,
      concretePropertiesName: null == concretePropertiesName
          ? _value.concretePropertiesName
          : concretePropertiesName // ignore: cast_nullable_to_non_nullable
              as List<String>,
      constructors: null == constructors
          ? _value.constructors
          : constructors // ignore: cast_nullable_to_non_nullable
              as List<ConstructorDetails>,
      genericsDefinitionTemplate: null == genericsDefinitionTemplate
          ? _value.genericsDefinitionTemplate
          : genericsDefinitionTemplate // ignore: cast_nullable_to_non_nullable
              as GenericsDefinitionTemplate,
      genericsParameterTemplate: null == genericsParameterTemplate
          ? _value.genericsParameterTemplate
          : genericsParameterTemplate // ignore: cast_nullable_to_non_nullable
              as GenericsParameterTemplate,
      shouldUseExtends: null == shouldUseExtends
          ? _value.shouldUseExtends
          : shouldUseExtends // ignore: cast_nullable_to_non_nullable
              as bool,
      genericArgumentFactories: null == genericArgumentFactories
          ? _value.genericArgumentFactories
          : genericArgumentFactories // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MapConfigCopyWith<$Res> get map {
    return $MapConfigCopyWith<$Res>(_value.map, (value) {
      return _then(_value.copyWith(map: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $WhenConfigCopyWith<$Res> get when {
    return $WhenConfigCopyWith<$Res>(_value.when, (value) {
      return _then(_value.copyWith(when: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_DataCopyWith<$Res> implements $DataCopyWith<$Res> {
  factory _$$_DataCopyWith(_$_Data value, $Res Function(_$_Data) then) =
      __$$_DataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String unionKey,
      bool generateCopyWith,
      bool generateEqual,
      bool generateToString,
      MapConfig map,
      WhenConfig when,
      bool generateFromJson,
      bool generateToJson,
      bool makeCollectionsImmutable,
      List<String> concretePropertiesName,
      List<ConstructorDetails> constructors,
      GenericsDefinitionTemplate genericsDefinitionTemplate,
      GenericsParameterTemplate genericsParameterTemplate,
      bool shouldUseExtends,
      bool genericArgumentFactories});

  @override
  $MapConfigCopyWith<$Res> get map;
  @override
  $WhenConfigCopyWith<$Res> get when;
}

/// @nodoc
class __$$_DataCopyWithImpl<$Res> extends _$DataCopyWithImpl<$Res, _$_Data>
    implements _$$_DataCopyWith<$Res> {
  __$$_DataCopyWithImpl(_$_Data _value, $Res Function(_$_Data) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? unionKey = null,
    Object? generateCopyWith = null,
    Object? generateEqual = null,
    Object? generateToString = null,
    Object? map = null,
    Object? when = null,
    Object? generateFromJson = null,
    Object? generateToJson = null,
    Object? makeCollectionsImmutable = null,
    Object? concretePropertiesName = null,
    Object? constructors = null,
    Object? genericsDefinitionTemplate = null,
    Object? genericsParameterTemplate = null,
    Object? shouldUseExtends = null,
    Object? genericArgumentFactories = null,
  }) {
    return _then(_$_Data(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unionKey: null == unionKey
          ? _value.unionKey
          : unionKey // ignore: cast_nullable_to_non_nullable
              as String,
      generateCopyWith: null == generateCopyWith
          ? _value.generateCopyWith
          : generateCopyWith // ignore: cast_nullable_to_non_nullable
              as bool,
      generateEqual: null == generateEqual
          ? _value.generateEqual
          : generateEqual // ignore: cast_nullable_to_non_nullable
              as bool,
      generateToString: null == generateToString
          ? _value.generateToString
          : generateToString // ignore: cast_nullable_to_non_nullable
              as bool,
      map: null == map
          ? _value.map
          : map // ignore: cast_nullable_to_non_nullable
              as MapConfig,
      when: null == when
          ? _value.when
          : when // ignore: cast_nullable_to_non_nullable
              as WhenConfig,
      generateFromJson: null == generateFromJson
          ? _value.generateFromJson
          : generateFromJson // ignore: cast_nullable_to_non_nullable
              as bool,
      generateToJson: null == generateToJson
          ? _value.generateToJson
          : generateToJson // ignore: cast_nullable_to_non_nullable
              as bool,
      makeCollectionsImmutable: null == makeCollectionsImmutable
          ? _value.makeCollectionsImmutable
          : makeCollectionsImmutable // ignore: cast_nullable_to_non_nullable
              as bool,
      concretePropertiesName: null == concretePropertiesName
          ? _value._concretePropertiesName
          : concretePropertiesName // ignore: cast_nullable_to_non_nullable
              as List<String>,
      constructors: null == constructors
          ? _value._constructors
          : constructors // ignore: cast_nullable_to_non_nullable
              as List<ConstructorDetails>,
      genericsDefinitionTemplate: null == genericsDefinitionTemplate
          ? _value.genericsDefinitionTemplate
          : genericsDefinitionTemplate // ignore: cast_nullable_to_non_nullable
              as GenericsDefinitionTemplate,
      genericsParameterTemplate: null == genericsParameterTemplate
          ? _value.genericsParameterTemplate
          : genericsParameterTemplate // ignore: cast_nullable_to_non_nullable
              as GenericsParameterTemplate,
      shouldUseExtends: null == shouldUseExtends
          ? _value.shouldUseExtends
          : shouldUseExtends // ignore: cast_nullable_to_non_nullable
              as bool,
      genericArgumentFactories: null == genericArgumentFactories
          ? _value.genericArgumentFactories
          : genericArgumentFactories // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_Data implements _Data {
  _$_Data(
      {required this.name,
      required this.unionKey,
      required this.generateCopyWith,
      required this.generateEqual,
      required this.generateToString,
      required this.map,
      required this.when,
      required this.generateFromJson,
      required this.generateToJson,
      required this.makeCollectionsImmutable,
      required final List<String> concretePropertiesName,
      required final List<ConstructorDetails> constructors,
      required this.genericsDefinitionTemplate,
      required this.genericsParameterTemplate,
      required this.shouldUseExtends,
      required this.genericArgumentFactories})
      : assert(constructors.isNotEmpty),
        _concretePropertiesName = concretePropertiesName,
        _constructors = constructors;

  @override
  final String name;
  @override
  final String unionKey;
  @override
  final bool generateCopyWith;
  @override
  final bool generateEqual;
  @override
  final bool generateToString;
  @override
  final MapConfig map;
  @override
  final WhenConfig when;
  @override
  final bool generateFromJson;
  @override
  final bool generateToJson;
  @override
  final bool makeCollectionsImmutable;
  final List<String> _concretePropertiesName;
  @override
  List<String> get concretePropertiesName {
    if (_concretePropertiesName is EqualUnmodifiableListView)
      return _concretePropertiesName;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_concretePropertiesName);
  }

  final List<ConstructorDetails> _constructors;
  @override
  List<ConstructorDetails> get constructors {
    if (_constructors is EqualUnmodifiableListView) return _constructors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_constructors);
  }

  @override
  final GenericsDefinitionTemplate genericsDefinitionTemplate;
  @override
  final GenericsParameterTemplate genericsParameterTemplate;
  @override
  final bool shouldUseExtends;
  @override
  final bool genericArgumentFactories;

  @override
  String toString() {
    return 'Data(name: $name, unionKey: $unionKey, generateCopyWith: $generateCopyWith, generateEqual: $generateEqual, generateToString: $generateToString, map: $map, when: $when, generateFromJson: $generateFromJson, generateToJson: $generateToJson, makeCollectionsImmutable: $makeCollectionsImmutable, concretePropertiesName: $concretePropertiesName, constructors: $constructors, genericsDefinitionTemplate: $genericsDefinitionTemplate, genericsParameterTemplate: $genericsParameterTemplate, shouldUseExtends: $shouldUseExtends, genericArgumentFactories: $genericArgumentFactories)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Data &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.unionKey, unionKey) ||
                other.unionKey == unionKey) &&
            (identical(other.generateCopyWith, generateCopyWith) ||
                other.generateCopyWith == generateCopyWith) &&
            (identical(other.generateEqual, generateEqual) ||
                other.generateEqual == generateEqual) &&
            (identical(other.generateToString, generateToString) ||
                other.generateToString == generateToString) &&
            (identical(other.map, map) || other.map == map) &&
            (identical(other.when, when) || other.when == when) &&
            (identical(other.generateFromJson, generateFromJson) ||
                other.generateFromJson == generateFromJson) &&
            (identical(other.generateToJson, generateToJson) ||
                other.generateToJson == generateToJson) &&
            (identical(
                    other.makeCollectionsImmutable, makeCollectionsImmutable) ||
                other.makeCollectionsImmutable == makeCollectionsImmutable) &&
            const DeepCollectionEquality().equals(
                other._concretePropertiesName, _concretePropertiesName) &&
            const DeepCollectionEquality()
                .equals(other._constructors, _constructors) &&
            (identical(other.genericsDefinitionTemplate,
                    genericsDefinitionTemplate) ||
                other.genericsDefinitionTemplate ==
                    genericsDefinitionTemplate) &&
            (identical(other.genericsParameterTemplate,
                    genericsParameterTemplate) ||
                other.genericsParameterTemplate == genericsParameterTemplate) &&
            (identical(other.shouldUseExtends, shouldUseExtends) ||
                other.shouldUseExtends == shouldUseExtends) &&
            (identical(
                    other.genericArgumentFactories, genericArgumentFactories) ||
                other.genericArgumentFactories == genericArgumentFactories));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      unionKey,
      generateCopyWith,
      generateEqual,
      generateToString,
      map,
      when,
      generateFromJson,
      generateToJson,
      makeCollectionsImmutable,
      const DeepCollectionEquality().hash(_concretePropertiesName),
      const DeepCollectionEquality().hash(_constructors),
      genericsDefinitionTemplate,
      genericsParameterTemplate,
      shouldUseExtends,
      genericArgumentFactories);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DataCopyWith<_$_Data> get copyWith =>
      __$$_DataCopyWithImpl<_$_Data>(this, _$identity);
}

abstract class _Data implements Data {
  factory _Data(
      {required final String name,
      required final String unionKey,
      required final bool generateCopyWith,
      required final bool generateEqual,
      required final bool generateToString,
      required final MapConfig map,
      required final WhenConfig when,
      required final bool generateFromJson,
      required final bool generateToJson,
      required final bool makeCollectionsImmutable,
      required final List<String> concretePropertiesName,
      required final List<ConstructorDetails> constructors,
      required final GenericsDefinitionTemplate genericsDefinitionTemplate,
      required final GenericsParameterTemplate genericsParameterTemplate,
      required final bool shouldUseExtends,
      required final bool genericArgumentFactories}) = _$_Data;

  @override
  String get name;
  @override
  String get unionKey;
  @override
  bool get generateCopyWith;
  @override
  bool get generateEqual;
  @override
  bool get generateToString;
  @override
  MapConfig get map;
  @override
  WhenConfig get when;
  @override
  bool get generateFromJson;
  @override
  bool get generateToJson;
  @override
  bool get makeCollectionsImmutable;
  @override
  List<String> get concretePropertiesName;
  @override
  List<ConstructorDetails> get constructors;
  @override
  GenericsDefinitionTemplate get genericsDefinitionTemplate;
  @override
  GenericsParameterTemplate get genericsParameterTemplate;
  @override
  bool get shouldUseExtends;
  @override
  bool get genericArgumentFactories;
  @override
  @JsonKey(ignore: true)
  _$$_DataCopyWith<_$_Data> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GlobalData {
  bool get hasJson => throw _privateConstructorUsedError;
  bool get hasDiagnostics => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GlobalDataCopyWith<GlobalData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GlobalDataCopyWith<$Res> {
  factory $GlobalDataCopyWith(
          GlobalData value, $Res Function(GlobalData) then) =
      _$GlobalDataCopyWithImpl<$Res, GlobalData>;
  @useResult
  $Res call({bool hasJson, bool hasDiagnostics});
}

/// @nodoc
class _$GlobalDataCopyWithImpl<$Res, $Val extends GlobalData>
    implements $GlobalDataCopyWith<$Res> {
  _$GlobalDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasJson = null,
    Object? hasDiagnostics = null,
  }) {
    return _then(_value.copyWith(
      hasJson: null == hasJson
          ? _value.hasJson
          : hasJson // ignore: cast_nullable_to_non_nullable
              as bool,
      hasDiagnostics: null == hasDiagnostics
          ? _value.hasDiagnostics
          : hasDiagnostics // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GlobalDataCopyWith<$Res>
    implements $GlobalDataCopyWith<$Res> {
  factory _$$_GlobalDataCopyWith(
          _$_GlobalData value, $Res Function(_$_GlobalData) then) =
      __$$_GlobalDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool hasJson, bool hasDiagnostics});
}

/// @nodoc
class __$$_GlobalDataCopyWithImpl<$Res>
    extends _$GlobalDataCopyWithImpl<$Res, _$_GlobalData>
    implements _$$_GlobalDataCopyWith<$Res> {
  __$$_GlobalDataCopyWithImpl(
      _$_GlobalData _value, $Res Function(_$_GlobalData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasJson = null,
    Object? hasDiagnostics = null,
  }) {
    return _then(_$_GlobalData(
      hasJson: null == hasJson
          ? _value.hasJson
          : hasJson // ignore: cast_nullable_to_non_nullable
              as bool,
      hasDiagnostics: null == hasDiagnostics
          ? _value.hasDiagnostics
          : hasDiagnostics // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_GlobalData implements _GlobalData {
  _$_GlobalData({required this.hasJson, required this.hasDiagnostics});

  @override
  final bool hasJson;
  @override
  final bool hasDiagnostics;

  @override
  String toString() {
    return 'GlobalData(hasJson: $hasJson, hasDiagnostics: $hasDiagnostics)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GlobalData &&
            (identical(other.hasJson, hasJson) || other.hasJson == hasJson) &&
            (identical(other.hasDiagnostics, hasDiagnostics) ||
                other.hasDiagnostics == hasDiagnostics));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hasJson, hasDiagnostics);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GlobalDataCopyWith<_$_GlobalData> get copyWith =>
      __$$_GlobalDataCopyWithImpl<_$_GlobalData>(this, _$identity);
}

abstract class _GlobalData implements GlobalData {
  factory _GlobalData(
      {required final bool hasJson,
      required final bool hasDiagnostics}) = _$_GlobalData;

  @override
  bool get hasJson;
  @override
  bool get hasDiagnostics;
  @override
  @JsonKey(ignore: true)
  _$$_GlobalDataCopyWith<_$_GlobalData> get copyWith =>
      throw _privateConstructorUsedError;
}
