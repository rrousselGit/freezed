// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CloneablePropertyTearOff {
  const _$CloneablePropertyTearOff();

  _CloneableProperty call(
      {required String name,
      required String typeName,
      required String type,
      required bool nullable,
      required GenericsParameterTemplate genericParameters}) {
    return _CloneableProperty(
      name: name,
      typeName: typeName,
      type: type,
      nullable: nullable,
      genericParameters: genericParameters,
    );
  }
}

/// @nodoc
const $CloneableProperty = _$CloneablePropertyTearOff();

/// @nodoc
mixin _$CloneableProperty {
  String get name => throw _privateConstructorUsedError;
  String get typeName => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  bool get nullable => throw _privateConstructorUsedError;
  GenericsParameterTemplate get genericParameters =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CloneablePropertyCopyWith<CloneableProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CloneablePropertyCopyWith<$Res> {
  factory $CloneablePropertyCopyWith(
          CloneableProperty value, $Res Function(CloneableProperty) then) =
      _$CloneablePropertyCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String typeName,
      String type,
      bool nullable,
      GenericsParameterTemplate genericParameters});
}

/// @nodoc
class _$CloneablePropertyCopyWithImpl<$Res>
    implements $CloneablePropertyCopyWith<$Res> {
  _$CloneablePropertyCopyWithImpl(this._value, this._then);

  final CloneableProperty _value;
  // ignore: unused_field
  final $Res Function(CloneableProperty) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? typeName = freezed,
    Object? type = freezed,
    Object? nullable = freezed,
    Object? genericParameters = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      typeName: typeName == freezed
          ? _value.typeName
          : typeName // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      nullable: nullable == freezed
          ? _value.nullable
          : nullable // ignore: cast_nullable_to_non_nullable
              as bool,
      genericParameters: genericParameters == freezed
          ? _value.genericParameters
          : genericParameters // ignore: cast_nullable_to_non_nullable
              as GenericsParameterTemplate,
    ));
  }
}

/// @nodoc
abstract class _$CloneablePropertyCopyWith<$Res>
    implements $CloneablePropertyCopyWith<$Res> {
  factory _$CloneablePropertyCopyWith(
          _CloneableProperty value, $Res Function(_CloneableProperty) then) =
      __$CloneablePropertyCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String typeName,
      String type,
      bool nullable,
      GenericsParameterTemplate genericParameters});
}

/// @nodoc
class __$CloneablePropertyCopyWithImpl<$Res>
    extends _$CloneablePropertyCopyWithImpl<$Res>
    implements _$CloneablePropertyCopyWith<$Res> {
  __$CloneablePropertyCopyWithImpl(
      _CloneableProperty _value, $Res Function(_CloneableProperty) _then)
      : super(_value, (v) => _then(v as _CloneableProperty));

  @override
  _CloneableProperty get _value => super._value as _CloneableProperty;

  @override
  $Res call({
    Object? name = freezed,
    Object? typeName = freezed,
    Object? type = freezed,
    Object? nullable = freezed,
    Object? genericParameters = freezed,
  }) {
    return _then(_CloneableProperty(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      typeName: typeName == freezed
          ? _value.typeName
          : typeName // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      nullable: nullable == freezed
          ? _value.nullable
          : nullable // ignore: cast_nullable_to_non_nullable
              as bool,
      genericParameters: genericParameters == freezed
          ? _value.genericParameters
          : genericParameters // ignore: cast_nullable_to_non_nullable
              as GenericsParameterTemplate,
    ));
  }
}

/// @nodoc

class _$_CloneableProperty implements _CloneableProperty {
  _$_CloneableProperty(
      {required this.name,
      required this.typeName,
      required this.type,
      required this.nullable,
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
  final GenericsParameterTemplate genericParameters;

  @override
  String toString() {
    return 'CloneableProperty(name: $name, typeName: $typeName, type: $type, nullable: $nullable, genericParameters: $genericParameters)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CloneableProperty &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.typeName, typeName) ||
                other.typeName == typeName) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.nullable, nullable) ||
                other.nullable == nullable) &&
            (identical(other.genericParameters, genericParameters) ||
                other.genericParameters == genericParameters));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, name, typeName, type, nullable, genericParameters);

  @JsonKey(ignore: true)
  @override
  _$CloneablePropertyCopyWith<_CloneableProperty> get copyWith =>
      __$CloneablePropertyCopyWithImpl<_CloneableProperty>(this, _$identity);
}

abstract class _CloneableProperty implements CloneableProperty {
  factory _CloneableProperty(
          {required String name,
          required String typeName,
          required String type,
          required bool nullable,
          required GenericsParameterTemplate genericParameters}) =
      _$_CloneableProperty;

  @override
  String get name;
  @override
  String get typeName;
  @override
  String get type;
  @override
  bool get nullable;
  @override
  GenericsParameterTemplate get genericParameters;
  @override
  @JsonKey(ignore: true)
  _$CloneablePropertyCopyWith<_CloneableProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$ConstructorDetailsTearOff {
  const _$ConstructorDetailsTearOff();

  _ConstructorDetails call(
      {required String name,
      required String unionValue,
      required bool isConst,
      required String redirectedName,
      required ParametersTemplate parameters,
      required List<Property> impliedProperties,
      required bool isDefault,
      required bool isFallback,
      required bool hasJsonSerializable,
      required String fullName,
      required String escapedName,
      required List<String> withDecorators,
      required List<String> implementsDecorators,
      required List<String> decorators,
      required List<CloneableProperty> cloneableProperties,
      required List<AssertTemplate> asserts}) {
    return _ConstructorDetails(
      name: name,
      unionValue: unionValue,
      isConst: isConst,
      redirectedName: redirectedName,
      parameters: parameters,
      impliedProperties: impliedProperties,
      isDefault: isDefault,
      isFallback: isFallback,
      hasJsonSerializable: hasJsonSerializable,
      fullName: fullName,
      escapedName: escapedName,
      withDecorators: withDecorators,
      implementsDecorators: implementsDecorators,
      decorators: decorators,
      cloneableProperties: cloneableProperties,
      asserts: asserts,
    );
  }
}

/// @nodoc
const $ConstructorDetails = _$ConstructorDetailsTearOff();

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
  List<CloneableProperty> get cloneableProperties =>
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
      _$ConstructorDetailsCopyWithImpl<$Res>;
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
      List<CloneableProperty> cloneableProperties,
      List<AssertTemplate> asserts});
}

/// @nodoc
class _$ConstructorDetailsCopyWithImpl<$Res>
    implements $ConstructorDetailsCopyWith<$Res> {
  _$ConstructorDetailsCopyWithImpl(this._value, this._then);

  final ConstructorDetails _value;
  // ignore: unused_field
  final $Res Function(ConstructorDetails) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? unionValue = freezed,
    Object? isConst = freezed,
    Object? redirectedName = freezed,
    Object? parameters = freezed,
    Object? impliedProperties = freezed,
    Object? isDefault = freezed,
    Object? isFallback = freezed,
    Object? hasJsonSerializable = freezed,
    Object? fullName = freezed,
    Object? escapedName = freezed,
    Object? withDecorators = freezed,
    Object? implementsDecorators = freezed,
    Object? decorators = freezed,
    Object? cloneableProperties = freezed,
    Object? asserts = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unionValue: unionValue == freezed
          ? _value.unionValue
          : unionValue // ignore: cast_nullable_to_non_nullable
              as String,
      isConst: isConst == freezed
          ? _value.isConst
          : isConst // ignore: cast_nullable_to_non_nullable
              as bool,
      redirectedName: redirectedName == freezed
          ? _value.redirectedName
          : redirectedName // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: parameters == freezed
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as ParametersTemplate,
      impliedProperties: impliedProperties == freezed
          ? _value.impliedProperties
          : impliedProperties // ignore: cast_nullable_to_non_nullable
              as List<Property>,
      isDefault: isDefault == freezed
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      isFallback: isFallback == freezed
          ? _value.isFallback
          : isFallback // ignore: cast_nullable_to_non_nullable
              as bool,
      hasJsonSerializable: hasJsonSerializable == freezed
          ? _value.hasJsonSerializable
          : hasJsonSerializable // ignore: cast_nullable_to_non_nullable
              as bool,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      escapedName: escapedName == freezed
          ? _value.escapedName
          : escapedName // ignore: cast_nullable_to_non_nullable
              as String,
      withDecorators: withDecorators == freezed
          ? _value.withDecorators
          : withDecorators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      implementsDecorators: implementsDecorators == freezed
          ? _value.implementsDecorators
          : implementsDecorators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      decorators: decorators == freezed
          ? _value.decorators
          : decorators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      cloneableProperties: cloneableProperties == freezed
          ? _value.cloneableProperties
          : cloneableProperties // ignore: cast_nullable_to_non_nullable
              as List<CloneableProperty>,
      asserts: asserts == freezed
          ? _value.asserts
          : asserts // ignore: cast_nullable_to_non_nullable
              as List<AssertTemplate>,
    ));
  }
}

/// @nodoc
abstract class _$ConstructorDetailsCopyWith<$Res>
    implements $ConstructorDetailsCopyWith<$Res> {
  factory _$ConstructorDetailsCopyWith(
          _ConstructorDetails value, $Res Function(_ConstructorDetails) then) =
      __$ConstructorDetailsCopyWithImpl<$Res>;
  @override
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
      List<CloneableProperty> cloneableProperties,
      List<AssertTemplate> asserts});
}

/// @nodoc
class __$ConstructorDetailsCopyWithImpl<$Res>
    extends _$ConstructorDetailsCopyWithImpl<$Res>
    implements _$ConstructorDetailsCopyWith<$Res> {
  __$ConstructorDetailsCopyWithImpl(
      _ConstructorDetails _value, $Res Function(_ConstructorDetails) _then)
      : super(_value, (v) => _then(v as _ConstructorDetails));

  @override
  _ConstructorDetails get _value => super._value as _ConstructorDetails;

  @override
  $Res call({
    Object? name = freezed,
    Object? unionValue = freezed,
    Object? isConst = freezed,
    Object? redirectedName = freezed,
    Object? parameters = freezed,
    Object? impliedProperties = freezed,
    Object? isDefault = freezed,
    Object? isFallback = freezed,
    Object? hasJsonSerializable = freezed,
    Object? fullName = freezed,
    Object? escapedName = freezed,
    Object? withDecorators = freezed,
    Object? implementsDecorators = freezed,
    Object? decorators = freezed,
    Object? cloneableProperties = freezed,
    Object? asserts = freezed,
  }) {
    return _then(_ConstructorDetails(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unionValue: unionValue == freezed
          ? _value.unionValue
          : unionValue // ignore: cast_nullable_to_non_nullable
              as String,
      isConst: isConst == freezed
          ? _value.isConst
          : isConst // ignore: cast_nullable_to_non_nullable
              as bool,
      redirectedName: redirectedName == freezed
          ? _value.redirectedName
          : redirectedName // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: parameters == freezed
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as ParametersTemplate,
      impliedProperties: impliedProperties == freezed
          ? _value.impliedProperties
          : impliedProperties // ignore: cast_nullable_to_non_nullable
              as List<Property>,
      isDefault: isDefault == freezed
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      isFallback: isFallback == freezed
          ? _value.isFallback
          : isFallback // ignore: cast_nullable_to_non_nullable
              as bool,
      hasJsonSerializable: hasJsonSerializable == freezed
          ? _value.hasJsonSerializable
          : hasJsonSerializable // ignore: cast_nullable_to_non_nullable
              as bool,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      escapedName: escapedName == freezed
          ? _value.escapedName
          : escapedName // ignore: cast_nullable_to_non_nullable
              as String,
      withDecorators: withDecorators == freezed
          ? _value.withDecorators
          : withDecorators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      implementsDecorators: implementsDecorators == freezed
          ? _value.implementsDecorators
          : implementsDecorators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      decorators: decorators == freezed
          ? _value.decorators
          : decorators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      cloneableProperties: cloneableProperties == freezed
          ? _value.cloneableProperties
          : cloneableProperties // ignore: cast_nullable_to_non_nullable
              as List<CloneableProperty>,
      asserts: asserts == freezed
          ? _value.asserts
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
      required this.impliedProperties,
      required this.isDefault,
      required this.isFallback,
      required this.hasJsonSerializable,
      required this.fullName,
      required this.escapedName,
      required this.withDecorators,
      required this.implementsDecorators,
      required this.decorators,
      required this.cloneableProperties,
      required this.asserts})
      : super._();

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
  @override
  final List<Property> impliedProperties;
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
  @override
  final List<String> withDecorators;
  @override
  final List<String> implementsDecorators;
  @override
  final List<String> decorators;
  @override
  final List<CloneableProperty> cloneableProperties;
  @override
  final List<AssertTemplate> asserts;

  @override
  String toString() {
    return 'ConstructorDetails(name: $name, unionValue: $unionValue, isConst: $isConst, redirectedName: $redirectedName, parameters: $parameters, impliedProperties: $impliedProperties, isDefault: $isDefault, isFallback: $isFallback, hasJsonSerializable: $hasJsonSerializable, fullName: $fullName, escapedName: $escapedName, withDecorators: $withDecorators, implementsDecorators: $implementsDecorators, decorators: $decorators, cloneableProperties: $cloneableProperties, asserts: $asserts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConstructorDetails &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.unionValue, unionValue) ||
                other.unionValue == unionValue) &&
            (identical(other.isConst, isConst) || other.isConst == isConst) &&
            (identical(other.redirectedName, redirectedName) ||
                other.redirectedName == redirectedName) &&
            (identical(other.parameters, parameters) ||
                other.parameters == parameters) &&
            const DeepCollectionEquality()
                .equals(other.impliedProperties, impliedProperties) &&
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
                .equals(other.withDecorators, withDecorators) &&
            const DeepCollectionEquality()
                .equals(other.implementsDecorators, implementsDecorators) &&
            const DeepCollectionEquality()
                .equals(other.decorators, decorators) &&
            const DeepCollectionEquality()
                .equals(other.cloneableProperties, cloneableProperties) &&
            const DeepCollectionEquality().equals(other.asserts, asserts));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      unionValue,
      isConst,
      redirectedName,
      parameters,
      const DeepCollectionEquality().hash(impliedProperties),
      isDefault,
      isFallback,
      hasJsonSerializable,
      fullName,
      escapedName,
      const DeepCollectionEquality().hash(withDecorators),
      const DeepCollectionEquality().hash(implementsDecorators),
      const DeepCollectionEquality().hash(decorators),
      const DeepCollectionEquality().hash(cloneableProperties),
      const DeepCollectionEquality().hash(asserts));

  @JsonKey(ignore: true)
  @override
  _$ConstructorDetailsCopyWith<_ConstructorDetails> get copyWith =>
      __$ConstructorDetailsCopyWithImpl<_ConstructorDetails>(this, _$identity);
}

abstract class _ConstructorDetails extends ConstructorDetails {
  factory _ConstructorDetails(
      {required String name,
      required String unionValue,
      required bool isConst,
      required String redirectedName,
      required ParametersTemplate parameters,
      required List<Property> impliedProperties,
      required bool isDefault,
      required bool isFallback,
      required bool hasJsonSerializable,
      required String fullName,
      required String escapedName,
      required List<String> withDecorators,
      required List<String> implementsDecorators,
      required List<String> decorators,
      required List<CloneableProperty> cloneableProperties,
      required List<AssertTemplate> asserts}) = _$_ConstructorDetails;
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
  List<CloneableProperty> get cloneableProperties;
  @override
  List<AssertTemplate> get asserts;
  @override
  @JsonKey(ignore: true)
  _$ConstructorDetailsCopyWith<_ConstructorDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$MapConfigTearOff {
  const _$MapConfigTearOff();

  _MapConfig call(
      {required bool map, required bool mapOrNull, required bool maybeMap}) {
    return _MapConfig(
      map: map,
      mapOrNull: mapOrNull,
      maybeMap: maybeMap,
    );
  }
}

/// @nodoc
const $MapConfig = _$MapConfigTearOff();

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
      _$MapConfigCopyWithImpl<$Res>;
  $Res call({bool map, bool mapOrNull, bool maybeMap});
}

/// @nodoc
class _$MapConfigCopyWithImpl<$Res> implements $MapConfigCopyWith<$Res> {
  _$MapConfigCopyWithImpl(this._value, this._then);

  final MapConfig _value;
  // ignore: unused_field
  final $Res Function(MapConfig) _then;

  @override
  $Res call({
    Object? map = freezed,
    Object? mapOrNull = freezed,
    Object? maybeMap = freezed,
  }) {
    return _then(_value.copyWith(
      map: map == freezed
          ? _value.map
          : map // ignore: cast_nullable_to_non_nullable
              as bool,
      mapOrNull: mapOrNull == freezed
          ? _value.mapOrNull
          : mapOrNull // ignore: cast_nullable_to_non_nullable
              as bool,
      maybeMap: maybeMap == freezed
          ? _value.maybeMap
          : maybeMap // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$MapConfigCopyWith<$Res> implements $MapConfigCopyWith<$Res> {
  factory _$MapConfigCopyWith(
          _MapConfig value, $Res Function(_MapConfig) then) =
      __$MapConfigCopyWithImpl<$Res>;
  @override
  $Res call({bool map, bool mapOrNull, bool maybeMap});
}

/// @nodoc
class __$MapConfigCopyWithImpl<$Res> extends _$MapConfigCopyWithImpl<$Res>
    implements _$MapConfigCopyWith<$Res> {
  __$MapConfigCopyWithImpl(_MapConfig _value, $Res Function(_MapConfig) _then)
      : super(_value, (v) => _then(v as _MapConfig));

  @override
  _MapConfig get _value => super._value as _MapConfig;

  @override
  $Res call({
    Object? map = freezed,
    Object? mapOrNull = freezed,
    Object? maybeMap = freezed,
  }) {
    return _then(_MapConfig(
      map: map == freezed
          ? _value.map
          : map // ignore: cast_nullable_to_non_nullable
              as bool,
      mapOrNull: mapOrNull == freezed
          ? _value.mapOrNull
          : mapOrNull // ignore: cast_nullable_to_non_nullable
              as bool,
      maybeMap: maybeMap == freezed
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
            other is _MapConfig &&
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
  _$MapConfigCopyWith<_MapConfig> get copyWith =>
      __$MapConfigCopyWithImpl<_MapConfig>(this, _$identity);
}

abstract class _MapConfig implements MapConfig {
  factory _MapConfig(
      {required bool map,
      required bool mapOrNull,
      required bool maybeMap}) = _$_MapConfig;

  @override
  bool get map;
  @override
  bool get mapOrNull;
  @override
  bool get maybeMap;
  @override
  @JsonKey(ignore: true)
  _$MapConfigCopyWith<_MapConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$WhenConfigTearOff {
  const _$WhenConfigTearOff();

  _WhenConfig call(
      {required bool when, required bool whenOrNull, required bool maybeWhen}) {
    return _WhenConfig(
      when: when,
      whenOrNull: whenOrNull,
      maybeWhen: maybeWhen,
    );
  }
}

/// @nodoc
const $WhenConfig = _$WhenConfigTearOff();

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
      _$WhenConfigCopyWithImpl<$Res>;
  $Res call({bool when, bool whenOrNull, bool maybeWhen});
}

/// @nodoc
class _$WhenConfigCopyWithImpl<$Res> implements $WhenConfigCopyWith<$Res> {
  _$WhenConfigCopyWithImpl(this._value, this._then);

  final WhenConfig _value;
  // ignore: unused_field
  final $Res Function(WhenConfig) _then;

  @override
  $Res call({
    Object? when = freezed,
    Object? whenOrNull = freezed,
    Object? maybeWhen = freezed,
  }) {
    return _then(_value.copyWith(
      when: when == freezed
          ? _value.when
          : when // ignore: cast_nullable_to_non_nullable
              as bool,
      whenOrNull: whenOrNull == freezed
          ? _value.whenOrNull
          : whenOrNull // ignore: cast_nullable_to_non_nullable
              as bool,
      maybeWhen: maybeWhen == freezed
          ? _value.maybeWhen
          : maybeWhen // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$WhenConfigCopyWith<$Res> implements $WhenConfigCopyWith<$Res> {
  factory _$WhenConfigCopyWith(
          _WhenConfig value, $Res Function(_WhenConfig) then) =
      __$WhenConfigCopyWithImpl<$Res>;
  @override
  $Res call({bool when, bool whenOrNull, bool maybeWhen});
}

/// @nodoc
class __$WhenConfigCopyWithImpl<$Res> extends _$WhenConfigCopyWithImpl<$Res>
    implements _$WhenConfigCopyWith<$Res> {
  __$WhenConfigCopyWithImpl(
      _WhenConfig _value, $Res Function(_WhenConfig) _then)
      : super(_value, (v) => _then(v as _WhenConfig));

  @override
  _WhenConfig get _value => super._value as _WhenConfig;

  @override
  $Res call({
    Object? when = freezed,
    Object? whenOrNull = freezed,
    Object? maybeWhen = freezed,
  }) {
    return _then(_WhenConfig(
      when: when == freezed
          ? _value.when
          : when // ignore: cast_nullable_to_non_nullable
              as bool,
      whenOrNull: whenOrNull == freezed
          ? _value.whenOrNull
          : whenOrNull // ignore: cast_nullable_to_non_nullable
              as bool,
      maybeWhen: maybeWhen == freezed
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
            other is _WhenConfig &&
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
  _$WhenConfigCopyWith<_WhenConfig> get copyWith =>
      __$WhenConfigCopyWithImpl<_WhenConfig>(this, _$identity);
}

abstract class _WhenConfig implements WhenConfig {
  factory _WhenConfig(
      {required bool when,
      required bool whenOrNull,
      required bool maybeWhen}) = _$_WhenConfig;

  @override
  bool get when;
  @override
  bool get whenOrNull;
  @override
  bool get maybeWhen;
  @override
  @JsonKey(ignore: true)
  _$WhenConfigCopyWith<_WhenConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$DataTearOff {
  const _$DataTearOff();

  _Data call(
      {required String name,
      required String unionKey,
      required bool generateCopyWith,
      required bool generateEqual,
      required bool generateToString,
      required MapConfig map,
      required WhenConfig when,
      required bool generateFromJson,
      required bool generateToJson,
      required List<String> concretePropertiesName,
      required List<ConstructorDetails> constructors,
      required GenericsDefinitionTemplate genericsDefinitionTemplate,
      required GenericsParameterTemplate genericsParameterTemplate,
      required bool shouldUseExtends}) {
    return _Data(
      name: name,
      unionKey: unionKey,
      generateCopyWith: generateCopyWith,
      generateEqual: generateEqual,
      generateToString: generateToString,
      map: map,
      when: when,
      generateFromJson: generateFromJson,
      generateToJson: generateToJson,
      concretePropertiesName: concretePropertiesName,
      constructors: constructors,
      genericsDefinitionTemplate: genericsDefinitionTemplate,
      genericsParameterTemplate: genericsParameterTemplate,
      shouldUseExtends: shouldUseExtends,
    );
  }
}

/// @nodoc
const $Data = _$DataTearOff();

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
  List<String> get concretePropertiesName => throw _privateConstructorUsedError;
  List<ConstructorDetails> get constructors =>
      throw _privateConstructorUsedError;
  GenericsDefinitionTemplate get genericsDefinitionTemplate =>
      throw _privateConstructorUsedError;
  GenericsParameterTemplate get genericsParameterTemplate =>
      throw _privateConstructorUsedError;
  bool get shouldUseExtends => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DataCopyWith<Data> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataCopyWith<$Res> {
  factory $DataCopyWith(Data value, $Res Function(Data) then) =
      _$DataCopyWithImpl<$Res>;
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
      List<String> concretePropertiesName,
      List<ConstructorDetails> constructors,
      GenericsDefinitionTemplate genericsDefinitionTemplate,
      GenericsParameterTemplate genericsParameterTemplate,
      bool shouldUseExtends});

  $MapConfigCopyWith<$Res> get map;
  $WhenConfigCopyWith<$Res> get when;
}

/// @nodoc
class _$DataCopyWithImpl<$Res> implements $DataCopyWith<$Res> {
  _$DataCopyWithImpl(this._value, this._then);

  final Data _value;
  // ignore: unused_field
  final $Res Function(Data) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? unionKey = freezed,
    Object? generateCopyWith = freezed,
    Object? generateEqual = freezed,
    Object? generateToString = freezed,
    Object? map = freezed,
    Object? when = freezed,
    Object? generateFromJson = freezed,
    Object? generateToJson = freezed,
    Object? concretePropertiesName = freezed,
    Object? constructors = freezed,
    Object? genericsDefinitionTemplate = freezed,
    Object? genericsParameterTemplate = freezed,
    Object? shouldUseExtends = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unionKey: unionKey == freezed
          ? _value.unionKey
          : unionKey // ignore: cast_nullable_to_non_nullable
              as String,
      generateCopyWith: generateCopyWith == freezed
          ? _value.generateCopyWith
          : generateCopyWith // ignore: cast_nullable_to_non_nullable
              as bool,
      generateEqual: generateEqual == freezed
          ? _value.generateEqual
          : generateEqual // ignore: cast_nullable_to_non_nullable
              as bool,
      generateToString: generateToString == freezed
          ? _value.generateToString
          : generateToString // ignore: cast_nullable_to_non_nullable
              as bool,
      map: map == freezed
          ? _value.map
          : map // ignore: cast_nullable_to_non_nullable
              as MapConfig,
      when: when == freezed
          ? _value.when
          : when // ignore: cast_nullable_to_non_nullable
              as WhenConfig,
      generateFromJson: generateFromJson == freezed
          ? _value.generateFromJson
          : generateFromJson // ignore: cast_nullable_to_non_nullable
              as bool,
      generateToJson: generateToJson == freezed
          ? _value.generateToJson
          : generateToJson // ignore: cast_nullable_to_non_nullable
              as bool,
      concretePropertiesName: concretePropertiesName == freezed
          ? _value.concretePropertiesName
          : concretePropertiesName // ignore: cast_nullable_to_non_nullable
              as List<String>,
      constructors: constructors == freezed
          ? _value.constructors
          : constructors // ignore: cast_nullable_to_non_nullable
              as List<ConstructorDetails>,
      genericsDefinitionTemplate: genericsDefinitionTemplate == freezed
          ? _value.genericsDefinitionTemplate
          : genericsDefinitionTemplate // ignore: cast_nullable_to_non_nullable
              as GenericsDefinitionTemplate,
      genericsParameterTemplate: genericsParameterTemplate == freezed
          ? _value.genericsParameterTemplate
          : genericsParameterTemplate // ignore: cast_nullable_to_non_nullable
              as GenericsParameterTemplate,
      shouldUseExtends: shouldUseExtends == freezed
          ? _value.shouldUseExtends
          : shouldUseExtends // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $MapConfigCopyWith<$Res> get map {
    return $MapConfigCopyWith<$Res>(_value.map, (value) {
      return _then(_value.copyWith(map: value));
    });
  }

  @override
  $WhenConfigCopyWith<$Res> get when {
    return $WhenConfigCopyWith<$Res>(_value.when, (value) {
      return _then(_value.copyWith(when: value));
    });
  }
}

/// @nodoc
abstract class _$DataCopyWith<$Res> implements $DataCopyWith<$Res> {
  factory _$DataCopyWith(_Data value, $Res Function(_Data) then) =
      __$DataCopyWithImpl<$Res>;
  @override
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
      List<String> concretePropertiesName,
      List<ConstructorDetails> constructors,
      GenericsDefinitionTemplate genericsDefinitionTemplate,
      GenericsParameterTemplate genericsParameterTemplate,
      bool shouldUseExtends});

  @override
  $MapConfigCopyWith<$Res> get map;
  @override
  $WhenConfigCopyWith<$Res> get when;
}

/// @nodoc
class __$DataCopyWithImpl<$Res> extends _$DataCopyWithImpl<$Res>
    implements _$DataCopyWith<$Res> {
  __$DataCopyWithImpl(_Data _value, $Res Function(_Data) _then)
      : super(_value, (v) => _then(v as _Data));

  @override
  _Data get _value => super._value as _Data;

  @override
  $Res call({
    Object? name = freezed,
    Object? unionKey = freezed,
    Object? generateCopyWith = freezed,
    Object? generateEqual = freezed,
    Object? generateToString = freezed,
    Object? map = freezed,
    Object? when = freezed,
    Object? generateFromJson = freezed,
    Object? generateToJson = freezed,
    Object? concretePropertiesName = freezed,
    Object? constructors = freezed,
    Object? genericsDefinitionTemplate = freezed,
    Object? genericsParameterTemplate = freezed,
    Object? shouldUseExtends = freezed,
  }) {
    return _then(_Data(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unionKey: unionKey == freezed
          ? _value.unionKey
          : unionKey // ignore: cast_nullable_to_non_nullable
              as String,
      generateCopyWith: generateCopyWith == freezed
          ? _value.generateCopyWith
          : generateCopyWith // ignore: cast_nullable_to_non_nullable
              as bool,
      generateEqual: generateEqual == freezed
          ? _value.generateEqual
          : generateEqual // ignore: cast_nullable_to_non_nullable
              as bool,
      generateToString: generateToString == freezed
          ? _value.generateToString
          : generateToString // ignore: cast_nullable_to_non_nullable
              as bool,
      map: map == freezed
          ? _value.map
          : map // ignore: cast_nullable_to_non_nullable
              as MapConfig,
      when: when == freezed
          ? _value.when
          : when // ignore: cast_nullable_to_non_nullable
              as WhenConfig,
      generateFromJson: generateFromJson == freezed
          ? _value.generateFromJson
          : generateFromJson // ignore: cast_nullable_to_non_nullable
              as bool,
      generateToJson: generateToJson == freezed
          ? _value.generateToJson
          : generateToJson // ignore: cast_nullable_to_non_nullable
              as bool,
      concretePropertiesName: concretePropertiesName == freezed
          ? _value.concretePropertiesName
          : concretePropertiesName // ignore: cast_nullable_to_non_nullable
              as List<String>,
      constructors: constructors == freezed
          ? _value.constructors
          : constructors // ignore: cast_nullable_to_non_nullable
              as List<ConstructorDetails>,
      genericsDefinitionTemplate: genericsDefinitionTemplate == freezed
          ? _value.genericsDefinitionTemplate
          : genericsDefinitionTemplate // ignore: cast_nullable_to_non_nullable
              as GenericsDefinitionTemplate,
      genericsParameterTemplate: genericsParameterTemplate == freezed
          ? _value.genericsParameterTemplate
          : genericsParameterTemplate // ignore: cast_nullable_to_non_nullable
              as GenericsParameterTemplate,
      shouldUseExtends: shouldUseExtends == freezed
          ? _value.shouldUseExtends
          : shouldUseExtends // ignore: cast_nullable_to_non_nullable
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
      required this.concretePropertiesName,
      required this.constructors,
      required this.genericsDefinitionTemplate,
      required this.genericsParameterTemplate,
      required this.shouldUseExtends})
      : assert(constructors.isNotEmpty);

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
  final List<String> concretePropertiesName;
  @override
  final List<ConstructorDetails> constructors;
  @override
  final GenericsDefinitionTemplate genericsDefinitionTemplate;
  @override
  final GenericsParameterTemplate genericsParameterTemplate;
  @override
  final bool shouldUseExtends;

  @override
  String toString() {
    return 'Data(name: $name, unionKey: $unionKey, generateCopyWith: $generateCopyWith, generateEqual: $generateEqual, generateToString: $generateToString, map: $map, when: $when, generateFromJson: $generateFromJson, generateToJson: $generateToJson, concretePropertiesName: $concretePropertiesName, constructors: $constructors, genericsDefinitionTemplate: $genericsDefinitionTemplate, genericsParameterTemplate: $genericsParameterTemplate, shouldUseExtends: $shouldUseExtends)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Data &&
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
            const DeepCollectionEquality()
                .equals(other.concretePropertiesName, concretePropertiesName) &&
            const DeepCollectionEquality()
                .equals(other.constructors, constructors) &&
            (identical(other.genericsDefinitionTemplate,
                    genericsDefinitionTemplate) ||
                other.genericsDefinitionTemplate ==
                    genericsDefinitionTemplate) &&
            (identical(other.genericsParameterTemplate,
                    genericsParameterTemplate) ||
                other.genericsParameterTemplate == genericsParameterTemplate) &&
            (identical(other.shouldUseExtends, shouldUseExtends) ||
                other.shouldUseExtends == shouldUseExtends));
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
      const DeepCollectionEquality().hash(concretePropertiesName),
      const DeepCollectionEquality().hash(constructors),
      genericsDefinitionTemplate,
      genericsParameterTemplate,
      shouldUseExtends);

  @JsonKey(ignore: true)
  @override
  _$DataCopyWith<_Data> get copyWith =>
      __$DataCopyWithImpl<_Data>(this, _$identity);
}

abstract class _Data implements Data {
  factory _Data(
      {required String name,
      required String unionKey,
      required bool generateCopyWith,
      required bool generateEqual,
      required bool generateToString,
      required MapConfig map,
      required WhenConfig when,
      required bool generateFromJson,
      required bool generateToJson,
      required List<String> concretePropertiesName,
      required List<ConstructorDetails> constructors,
      required GenericsDefinitionTemplate genericsDefinitionTemplate,
      required GenericsParameterTemplate genericsParameterTemplate,
      required bool shouldUseExtends}) = _$_Data;

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
  @JsonKey(ignore: true)
  _$DataCopyWith<_Data> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
class _$GlobalDataTearOff {
  const _$GlobalDataTearOff();

  _GlobalData call({required bool hasJson, required bool hasDiagnostics}) {
    return _GlobalData(
      hasJson: hasJson,
      hasDiagnostics: hasDiagnostics,
    );
  }
}

/// @nodoc
const $GlobalData = _$GlobalDataTearOff();

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
      _$GlobalDataCopyWithImpl<$Res>;
  $Res call({bool hasJson, bool hasDiagnostics});
}

/// @nodoc
class _$GlobalDataCopyWithImpl<$Res> implements $GlobalDataCopyWith<$Res> {
  _$GlobalDataCopyWithImpl(this._value, this._then);

  final GlobalData _value;
  // ignore: unused_field
  final $Res Function(GlobalData) _then;

  @override
  $Res call({
    Object? hasJson = freezed,
    Object? hasDiagnostics = freezed,
  }) {
    return _then(_value.copyWith(
      hasJson: hasJson == freezed
          ? _value.hasJson
          : hasJson // ignore: cast_nullable_to_non_nullable
              as bool,
      hasDiagnostics: hasDiagnostics == freezed
          ? _value.hasDiagnostics
          : hasDiagnostics // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$GlobalDataCopyWith<$Res> implements $GlobalDataCopyWith<$Res> {
  factory _$GlobalDataCopyWith(
          _GlobalData value, $Res Function(_GlobalData) then) =
      __$GlobalDataCopyWithImpl<$Res>;
  @override
  $Res call({bool hasJson, bool hasDiagnostics});
}

/// @nodoc
class __$GlobalDataCopyWithImpl<$Res> extends _$GlobalDataCopyWithImpl<$Res>
    implements _$GlobalDataCopyWith<$Res> {
  __$GlobalDataCopyWithImpl(
      _GlobalData _value, $Res Function(_GlobalData) _then)
      : super(_value, (v) => _then(v as _GlobalData));

  @override
  _GlobalData get _value => super._value as _GlobalData;

  @override
  $Res call({
    Object? hasJson = freezed,
    Object? hasDiagnostics = freezed,
  }) {
    return _then(_GlobalData(
      hasJson: hasJson == freezed
          ? _value.hasJson
          : hasJson // ignore: cast_nullable_to_non_nullable
              as bool,
      hasDiagnostics: hasDiagnostics == freezed
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
            other is _GlobalData &&
            (identical(other.hasJson, hasJson) || other.hasJson == hasJson) &&
            (identical(other.hasDiagnostics, hasDiagnostics) ||
                other.hasDiagnostics == hasDiagnostics));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hasJson, hasDiagnostics);

  @JsonKey(ignore: true)
  @override
  _$GlobalDataCopyWith<_GlobalData> get copyWith =>
      __$GlobalDataCopyWithImpl<_GlobalData>(this, _$identity);
}

abstract class _GlobalData implements GlobalData {
  factory _GlobalData({required bool hasJson, required bool hasDiagnostics}) =
      _$_GlobalData;

  @override
  bool get hasJson;
  @override
  bool get hasDiagnostics;
  @override
  @JsonKey(ignore: true)
  _$GlobalDataCopyWith<_GlobalData> get copyWith =>
      throw _privateConstructorUsedError;
}
