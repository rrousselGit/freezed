// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$CloneablePropertyTearOff {
  const _$CloneablePropertyTearOff();

// ignore: unused_element
  _CloneableProperty call(
      {@required String name,
      @required String typeName,
      @required String type,
      @required GenericsParameterTemplate genericParameters}) {
    return _CloneableProperty(
      name: name,
      typeName: typeName,
      type: type,
      genericParameters: genericParameters,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $CloneableProperty = _$CloneablePropertyTearOff();

/// @nodoc
mixin _$CloneableProperty {
  String get name;
  String get typeName;
  String get type;
  GenericsParameterTemplate get genericParameters;

  $CloneablePropertyCopyWith<CloneableProperty> get copyWith;
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
    Object name = freezed,
    Object typeName = freezed,
    Object type = freezed,
    Object genericParameters = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed ? _value.name : name as String,
      typeName: typeName == freezed ? _value.typeName : typeName as String,
      type: type == freezed ? _value.type : type as String,
      genericParameters: genericParameters == freezed
          ? _value.genericParameters
          : genericParameters as GenericsParameterTemplate,
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
    Object name = freezed,
    Object typeName = freezed,
    Object type = freezed,
    Object genericParameters = freezed,
  }) {
    return _then(_CloneableProperty(
      name: name == freezed ? _value.name : name as String,
      typeName: typeName == freezed ? _value.typeName : typeName as String,
      type: type == freezed ? _value.type : type as String,
      genericParameters: genericParameters == freezed
          ? _value.genericParameters
          : genericParameters as GenericsParameterTemplate,
    ));
  }
}

/// @nodoc
class _$_CloneableProperty implements _CloneableProperty {
  _$_CloneableProperty(
      {@required this.name,
      @required this.typeName,
      @required this.type,
      @required this.genericParameters})
      : assert(name != null),
        assert(typeName != null),
        assert(type != null),
        assert(genericParameters != null);

  @override
  final String name;
  @override
  final String typeName;
  @override
  final String type;
  @override
  final GenericsParameterTemplate genericParameters;

  @override
  String toString() {
    return 'CloneableProperty(name: $name, typeName: $typeName, type: $type, genericParameters: $genericParameters)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CloneableProperty &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.typeName, typeName) ||
                const DeepCollectionEquality()
                    .equals(other.typeName, typeName)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.genericParameters, genericParameters) ||
                const DeepCollectionEquality()
                    .equals(other.genericParameters, genericParameters)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(typeName) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(genericParameters);

  @override
  _$CloneablePropertyCopyWith<_CloneableProperty> get copyWith =>
      __$CloneablePropertyCopyWithImpl<_CloneableProperty>(this, _$identity);
}

abstract class _CloneableProperty implements CloneableProperty {
  factory _CloneableProperty(
          {@required String name,
          @required String typeName,
          @required String type,
          @required GenericsParameterTemplate genericParameters}) =
      _$_CloneableProperty;

  @override
  String get name;
  @override
  String get typeName;
  @override
  String get type;
  @override
  GenericsParameterTemplate get genericParameters;
  @override
  _$CloneablePropertyCopyWith<_CloneableProperty> get copyWith;
}

/// @nodoc
class _$ConstructorDetailsTearOff {
  const _$ConstructorDetailsTearOff();

// ignore: unused_element
  _ConstructorDetails call(
      {@required String name,
      @required bool isConst,
      @required String redirectedName,
      @required ParametersTemplate parameters,
      @required List<Property> impliedProperties,
      @required bool isDefault,
      @required bool hasJsonSerializable,
      @required String fullName,
      @required List<String> withDecorators,
      @required List<String> implementsDecorators,
      @required List<String> decorators,
      @required List<CloneableProperty> cloneableProperties,
      @required bool canOverrideToString,
      @required List<AssertTemplate> asserts}) {
    return _ConstructorDetails(
      name: name,
      isConst: isConst,
      redirectedName: redirectedName,
      parameters: parameters,
      impliedProperties: impliedProperties,
      isDefault: isDefault,
      hasJsonSerializable: hasJsonSerializable,
      fullName: fullName,
      withDecorators: withDecorators,
      implementsDecorators: implementsDecorators,
      decorators: decorators,
      cloneableProperties: cloneableProperties,
      canOverrideToString: canOverrideToString,
      asserts: asserts,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $ConstructorDetails = _$ConstructorDetailsTearOff();

/// @nodoc
mixin _$ConstructorDetails {
  String get name;
  bool get isConst;
  String get redirectedName;
  ParametersTemplate get parameters;
  List<Property> get impliedProperties;
  bool get isDefault;
  bool get hasJsonSerializable;
  String get fullName;
  List<String> get withDecorators;
  List<String> get implementsDecorators;
  List<String> get decorators;
  List<CloneableProperty> get cloneableProperties;
  bool get canOverrideToString;
  List<AssertTemplate> get asserts;

  $ConstructorDetailsCopyWith<ConstructorDetails> get copyWith;
}

/// @nodoc
abstract class $ConstructorDetailsCopyWith<$Res> {
  factory $ConstructorDetailsCopyWith(
          ConstructorDetails value, $Res Function(ConstructorDetails) then) =
      _$ConstructorDetailsCopyWithImpl<$Res>;
  $Res call(
      {String name,
      bool isConst,
      String redirectedName,
      ParametersTemplate parameters,
      List<Property> impliedProperties,
      bool isDefault,
      bool hasJsonSerializable,
      String fullName,
      List<String> withDecorators,
      List<String> implementsDecorators,
      List<String> decorators,
      List<CloneableProperty> cloneableProperties,
      bool canOverrideToString,
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
    Object name = freezed,
    Object isConst = freezed,
    Object redirectedName = freezed,
    Object parameters = freezed,
    Object impliedProperties = freezed,
    Object isDefault = freezed,
    Object hasJsonSerializable = freezed,
    Object fullName = freezed,
    Object withDecorators = freezed,
    Object implementsDecorators = freezed,
    Object decorators = freezed,
    Object cloneableProperties = freezed,
    Object canOverrideToString = freezed,
    Object asserts = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed ? _value.name : name as String,
      isConst: isConst == freezed ? _value.isConst : isConst as bool,
      redirectedName: redirectedName == freezed
          ? _value.redirectedName
          : redirectedName as String,
      parameters: parameters == freezed
          ? _value.parameters
          : parameters as ParametersTemplate,
      impliedProperties: impliedProperties == freezed
          ? _value.impliedProperties
          : impliedProperties as List<Property>,
      isDefault: isDefault == freezed ? _value.isDefault : isDefault as bool,
      hasJsonSerializable: hasJsonSerializable == freezed
          ? _value.hasJsonSerializable
          : hasJsonSerializable as bool,
      fullName: fullName == freezed ? _value.fullName : fullName as String,
      withDecorators: withDecorators == freezed
          ? _value.withDecorators
          : withDecorators as List<String>,
      implementsDecorators: implementsDecorators == freezed
          ? _value.implementsDecorators
          : implementsDecorators as List<String>,
      decorators: decorators == freezed
          ? _value.decorators
          : decorators as List<String>,
      cloneableProperties: cloneableProperties == freezed
          ? _value.cloneableProperties
          : cloneableProperties as List<CloneableProperty>,
      canOverrideToString: canOverrideToString == freezed
          ? _value.canOverrideToString
          : canOverrideToString as bool,
      asserts:
          asserts == freezed ? _value.asserts : asserts as List<AssertTemplate>,
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
      bool isConst,
      String redirectedName,
      ParametersTemplate parameters,
      List<Property> impliedProperties,
      bool isDefault,
      bool hasJsonSerializable,
      String fullName,
      List<String> withDecorators,
      List<String> implementsDecorators,
      List<String> decorators,
      List<CloneableProperty> cloneableProperties,
      bool canOverrideToString,
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
    Object name = freezed,
    Object isConst = freezed,
    Object redirectedName = freezed,
    Object parameters = freezed,
    Object impliedProperties = freezed,
    Object isDefault = freezed,
    Object hasJsonSerializable = freezed,
    Object fullName = freezed,
    Object withDecorators = freezed,
    Object implementsDecorators = freezed,
    Object decorators = freezed,
    Object cloneableProperties = freezed,
    Object canOverrideToString = freezed,
    Object asserts = freezed,
  }) {
    return _then(_ConstructorDetails(
      name: name == freezed ? _value.name : name as String,
      isConst: isConst == freezed ? _value.isConst : isConst as bool,
      redirectedName: redirectedName == freezed
          ? _value.redirectedName
          : redirectedName as String,
      parameters: parameters == freezed
          ? _value.parameters
          : parameters as ParametersTemplate,
      impliedProperties: impliedProperties == freezed
          ? _value.impliedProperties
          : impliedProperties as List<Property>,
      isDefault: isDefault == freezed ? _value.isDefault : isDefault as bool,
      hasJsonSerializable: hasJsonSerializable == freezed
          ? _value.hasJsonSerializable
          : hasJsonSerializable as bool,
      fullName: fullName == freezed ? _value.fullName : fullName as String,
      withDecorators: withDecorators == freezed
          ? _value.withDecorators
          : withDecorators as List<String>,
      implementsDecorators: implementsDecorators == freezed
          ? _value.implementsDecorators
          : implementsDecorators as List<String>,
      decorators: decorators == freezed
          ? _value.decorators
          : decorators as List<String>,
      cloneableProperties: cloneableProperties == freezed
          ? _value.cloneableProperties
          : cloneableProperties as List<CloneableProperty>,
      canOverrideToString: canOverrideToString == freezed
          ? _value.canOverrideToString
          : canOverrideToString as bool,
      asserts:
          asserts == freezed ? _value.asserts : asserts as List<AssertTemplate>,
    ));
  }
}

/// @nodoc
class _$_ConstructorDetails extends _ConstructorDetails {
  _$_ConstructorDetails(
      {@required this.name,
      @required this.isConst,
      @required this.redirectedName,
      @required this.parameters,
      @required this.impliedProperties,
      @required this.isDefault,
      @required this.hasJsonSerializable,
      @required this.fullName,
      @required this.withDecorators,
      @required this.implementsDecorators,
      @required this.decorators,
      @required this.cloneableProperties,
      @required this.canOverrideToString,
      @required this.asserts})
      : assert(name != null),
        assert(isConst != null),
        assert(redirectedName != null),
        assert(parameters != null),
        assert(impliedProperties != null),
        assert(isDefault != null),
        assert(hasJsonSerializable != null),
        assert(fullName != null),
        assert(withDecorators != null),
        assert(implementsDecorators != null),
        assert(decorators != null),
        assert(cloneableProperties != null),
        assert(canOverrideToString != null),
        assert(asserts != null),
        super._();

  @override
  final String name;
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
  final bool hasJsonSerializable;
  @override
  final String fullName;
  @override
  final List<String> withDecorators;
  @override
  final List<String> implementsDecorators;
  @override
  final List<String> decorators;
  @override
  final List<CloneableProperty> cloneableProperties;
  @override
  final bool canOverrideToString;
  @override
  final List<AssertTemplate> asserts;

  @override
  String toString() {
    return 'ConstructorDetails(name: $name, isConst: $isConst, redirectedName: $redirectedName, parameters: $parameters, impliedProperties: $impliedProperties, isDefault: $isDefault, hasJsonSerializable: $hasJsonSerializable, fullName: $fullName, withDecorators: $withDecorators, implementsDecorators: $implementsDecorators, decorators: $decorators, cloneableProperties: $cloneableProperties, canOverrideToString: $canOverrideToString, asserts: $asserts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ConstructorDetails &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.isConst, isConst) ||
                const DeepCollectionEquality()
                    .equals(other.isConst, isConst)) &&
            (identical(other.redirectedName, redirectedName) ||
                const DeepCollectionEquality()
                    .equals(other.redirectedName, redirectedName)) &&
            (identical(other.parameters, parameters) ||
                const DeepCollectionEquality()
                    .equals(other.parameters, parameters)) &&
            (identical(other.impliedProperties, impliedProperties) ||
                const DeepCollectionEquality()
                    .equals(other.impliedProperties, impliedProperties)) &&
            (identical(other.isDefault, isDefault) ||
                const DeepCollectionEquality()
                    .equals(other.isDefault, isDefault)) &&
            (identical(other.hasJsonSerializable, hasJsonSerializable) ||
                const DeepCollectionEquality()
                    .equals(other.hasJsonSerializable, hasJsonSerializable)) &&
            (identical(other.fullName, fullName) ||
                const DeepCollectionEquality()
                    .equals(other.fullName, fullName)) &&
            (identical(other.withDecorators, withDecorators) ||
                const DeepCollectionEquality()
                    .equals(other.withDecorators, withDecorators)) &&
            (identical(other.implementsDecorators, implementsDecorators) ||
                const DeepCollectionEquality().equals(
                    other.implementsDecorators, implementsDecorators)) &&
            (identical(other.decorators, decorators) ||
                const DeepCollectionEquality()
                    .equals(other.decorators, decorators)) &&
            (identical(other.cloneableProperties, cloneableProperties) ||
                const DeepCollectionEquality()
                    .equals(other.cloneableProperties, cloneableProperties)) &&
            (identical(other.canOverrideToString, canOverrideToString) ||
                const DeepCollectionEquality()
                    .equals(other.canOverrideToString, canOverrideToString)) &&
            (identical(other.asserts, asserts) ||
                const DeepCollectionEquality().equals(other.asserts, asserts)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(isConst) ^
      const DeepCollectionEquality().hash(redirectedName) ^
      const DeepCollectionEquality().hash(parameters) ^
      const DeepCollectionEquality().hash(impliedProperties) ^
      const DeepCollectionEquality().hash(isDefault) ^
      const DeepCollectionEquality().hash(hasJsonSerializable) ^
      const DeepCollectionEquality().hash(fullName) ^
      const DeepCollectionEquality().hash(withDecorators) ^
      const DeepCollectionEquality().hash(implementsDecorators) ^
      const DeepCollectionEquality().hash(decorators) ^
      const DeepCollectionEquality().hash(cloneableProperties) ^
      const DeepCollectionEquality().hash(canOverrideToString) ^
      const DeepCollectionEquality().hash(asserts);

  @override
  _$ConstructorDetailsCopyWith<_ConstructorDetails> get copyWith =>
      __$ConstructorDetailsCopyWithImpl<_ConstructorDetails>(this, _$identity);
}

abstract class _ConstructorDetails extends ConstructorDetails {
  _ConstructorDetails._() : super._();
  factory _ConstructorDetails(
      {@required String name,
      @required bool isConst,
      @required String redirectedName,
      @required ParametersTemplate parameters,
      @required List<Property> impliedProperties,
      @required bool isDefault,
      @required bool hasJsonSerializable,
      @required String fullName,
      @required List<String> withDecorators,
      @required List<String> implementsDecorators,
      @required List<String> decorators,
      @required List<CloneableProperty> cloneableProperties,
      @required bool canOverrideToString,
      @required List<AssertTemplate> asserts}) = _$_ConstructorDetails;

  @override
  String get name;
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
  bool get hasJsonSerializable;
  @override
  String get fullName;
  @override
  List<String> get withDecorators;
  @override
  List<String> get implementsDecorators;
  @override
  List<String> get decorators;
  @override
  List<CloneableProperty> get cloneableProperties;
  @override
  bool get canOverrideToString;
  @override
  List<AssertTemplate> get asserts;
  @override
  _$ConstructorDetailsCopyWith<_ConstructorDetails> get copyWith;
}

/// @nodoc
class _$DataTearOff {
  const _$DataTearOff();

// ignore: unused_element
  _Data call(
      {@required String name,
      @required List<LateGetter> lateGetters,
      @required bool needsJsonSerializable,
      @required String unionKey,
      @required List<ConstructorDetails> constructors,
      @required GenericsDefinitionTemplate genericsDefinitionTemplate,
      @required GenericsParameterTemplate genericsParameterTemplate,
      @required bool shouldUseExtends}) {
    return _Data(
      name: name,
      lateGetters: lateGetters,
      needsJsonSerializable: needsJsonSerializable,
      unionKey: unionKey,
      constructors: constructors,
      genericsDefinitionTemplate: genericsDefinitionTemplate,
      genericsParameterTemplate: genericsParameterTemplate,
      shouldUseExtends: shouldUseExtends,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $Data = _$DataTearOff();

/// @nodoc
mixin _$Data {
  String get name;
  List<LateGetter> get lateGetters;
  bool get needsJsonSerializable;
  String get unionKey;
  List<ConstructorDetails> get constructors;
  GenericsDefinitionTemplate get genericsDefinitionTemplate;
  GenericsParameterTemplate get genericsParameterTemplate;
  bool get shouldUseExtends;

  $DataCopyWith<Data> get copyWith;
}

/// @nodoc
abstract class $DataCopyWith<$Res> {
  factory $DataCopyWith(Data value, $Res Function(Data) then) =
      _$DataCopyWithImpl<$Res>;
  $Res call(
      {String name,
      List<LateGetter> lateGetters,
      bool needsJsonSerializable,
      String unionKey,
      List<ConstructorDetails> constructors,
      GenericsDefinitionTemplate genericsDefinitionTemplate,
      GenericsParameterTemplate genericsParameterTemplate,
      bool shouldUseExtends});
}

/// @nodoc
class _$DataCopyWithImpl<$Res> implements $DataCopyWith<$Res> {
  _$DataCopyWithImpl(this._value, this._then);

  final Data _value;
  // ignore: unused_field
  final $Res Function(Data) _then;

  @override
  $Res call({
    Object name = freezed,
    Object lateGetters = freezed,
    Object needsJsonSerializable = freezed,
    Object unionKey = freezed,
    Object constructors = freezed,
    Object genericsDefinitionTemplate = freezed,
    Object genericsParameterTemplate = freezed,
    Object shouldUseExtends = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed ? _value.name : name as String,
      lateGetters: lateGetters == freezed
          ? _value.lateGetters
          : lateGetters as List<LateGetter>,
      needsJsonSerializable: needsJsonSerializable == freezed
          ? _value.needsJsonSerializable
          : needsJsonSerializable as bool,
      unionKey: unionKey == freezed ? _value.unionKey : unionKey as String,
      constructors: constructors == freezed
          ? _value.constructors
          : constructors as List<ConstructorDetails>,
      genericsDefinitionTemplate: genericsDefinitionTemplate == freezed
          ? _value.genericsDefinitionTemplate
          : genericsDefinitionTemplate as GenericsDefinitionTemplate,
      genericsParameterTemplate: genericsParameterTemplate == freezed
          ? _value.genericsParameterTemplate
          : genericsParameterTemplate as GenericsParameterTemplate,
      shouldUseExtends: shouldUseExtends == freezed
          ? _value.shouldUseExtends
          : shouldUseExtends as bool,
    ));
  }
}

/// @nodoc
abstract class _$DataCopyWith<$Res> implements $DataCopyWith<$Res> {
  factory _$DataCopyWith(_Data value, $Res Function(_Data) then) =
      __$DataCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      List<LateGetter> lateGetters,
      bool needsJsonSerializable,
      String unionKey,
      List<ConstructorDetails> constructors,
      GenericsDefinitionTemplate genericsDefinitionTemplate,
      GenericsParameterTemplate genericsParameterTemplate,
      bool shouldUseExtends});
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
    Object name = freezed,
    Object lateGetters = freezed,
    Object needsJsonSerializable = freezed,
    Object unionKey = freezed,
    Object constructors = freezed,
    Object genericsDefinitionTemplate = freezed,
    Object genericsParameterTemplate = freezed,
    Object shouldUseExtends = freezed,
  }) {
    return _then(_Data(
      name: name == freezed ? _value.name : name as String,
      lateGetters: lateGetters == freezed
          ? _value.lateGetters
          : lateGetters as List<LateGetter>,
      needsJsonSerializable: needsJsonSerializable == freezed
          ? _value.needsJsonSerializable
          : needsJsonSerializable as bool,
      unionKey: unionKey == freezed ? _value.unionKey : unionKey as String,
      constructors: constructors == freezed
          ? _value.constructors
          : constructors as List<ConstructorDetails>,
      genericsDefinitionTemplate: genericsDefinitionTemplate == freezed
          ? _value.genericsDefinitionTemplate
          : genericsDefinitionTemplate as GenericsDefinitionTemplate,
      genericsParameterTemplate: genericsParameterTemplate == freezed
          ? _value.genericsParameterTemplate
          : genericsParameterTemplate as GenericsParameterTemplate,
      shouldUseExtends: shouldUseExtends == freezed
          ? _value.shouldUseExtends
          : shouldUseExtends as bool,
    ));
  }
}

/// @nodoc
class _$_Data implements _Data {
  _$_Data(
      {@required this.name,
      @required this.lateGetters,
      @required this.needsJsonSerializable,
      @required this.unionKey,
      @required this.constructors,
      @required this.genericsDefinitionTemplate,
      @required this.genericsParameterTemplate,
      @required this.shouldUseExtends})
      : assert(name != null),
        assert(lateGetters != null),
        assert(needsJsonSerializable != null),
        assert(unionKey != null),
        assert(constructors != null),
        assert(genericsDefinitionTemplate != null),
        assert(genericsParameterTemplate != null),
        assert(shouldUseExtends != null),
        assert(constructors.isNotEmpty),
        assert(unionKey != null);

  @override
  final String name;
  @override
  final List<LateGetter> lateGetters;
  @override
  final bool needsJsonSerializable;
  @override
  final String unionKey;
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
    return 'Data(name: $name, lateGetters: $lateGetters, needsJsonSerializable: $needsJsonSerializable, unionKey: $unionKey, constructors: $constructors, genericsDefinitionTemplate: $genericsDefinitionTemplate, genericsParameterTemplate: $genericsParameterTemplate, shouldUseExtends: $shouldUseExtends)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Data &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.lateGetters, lateGetters) ||
                const DeepCollectionEquality()
                    .equals(other.lateGetters, lateGetters)) &&
            (identical(other.needsJsonSerializable, needsJsonSerializable) ||
                const DeepCollectionEquality().equals(
                    other.needsJsonSerializable, needsJsonSerializable)) &&
            (identical(other.unionKey, unionKey) ||
                const DeepCollectionEquality()
                    .equals(other.unionKey, unionKey)) &&
            (identical(other.constructors, constructors) ||
                const DeepCollectionEquality()
                    .equals(other.constructors, constructors)) &&
            (identical(other.genericsDefinitionTemplate,
                    genericsDefinitionTemplate) ||
                const DeepCollectionEquality().equals(
                    other.genericsDefinitionTemplate,
                    genericsDefinitionTemplate)) &&
            (identical(other.genericsParameterTemplate,
                    genericsParameterTemplate) ||
                const DeepCollectionEquality().equals(
                    other.genericsParameterTemplate,
                    genericsParameterTemplate)) &&
            (identical(other.shouldUseExtends, shouldUseExtends) ||
                const DeepCollectionEquality()
                    .equals(other.shouldUseExtends, shouldUseExtends)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(lateGetters) ^
      const DeepCollectionEquality().hash(needsJsonSerializable) ^
      const DeepCollectionEquality().hash(unionKey) ^
      const DeepCollectionEquality().hash(constructors) ^
      const DeepCollectionEquality().hash(genericsDefinitionTemplate) ^
      const DeepCollectionEquality().hash(genericsParameterTemplate) ^
      const DeepCollectionEquality().hash(shouldUseExtends);

  @override
  _$DataCopyWith<_Data> get copyWith =>
      __$DataCopyWithImpl<_Data>(this, _$identity);
}

abstract class _Data implements Data {
  factory _Data(
      {@required String name,
      @required List<LateGetter> lateGetters,
      @required bool needsJsonSerializable,
      @required String unionKey,
      @required List<ConstructorDetails> constructors,
      @required GenericsDefinitionTemplate genericsDefinitionTemplate,
      @required GenericsParameterTemplate genericsParameterTemplate,
      @required bool shouldUseExtends}) = _$_Data;

  @override
  String get name;
  @override
  List<LateGetter> get lateGetters;
  @override
  bool get needsJsonSerializable;
  @override
  String get unionKey;
  @override
  List<ConstructorDetails> get constructors;
  @override
  GenericsDefinitionTemplate get genericsDefinitionTemplate;
  @override
  GenericsParameterTemplate get genericsParameterTemplate;
  @override
  bool get shouldUseExtends;
  @override
  _$DataCopyWith<_Data> get copyWith;
}

/// @nodoc
class _$GlobalDataTearOff {
  const _$GlobalDataTearOff();

// ignore: unused_element
  _GlobalData call({@required bool hasJson, @required bool hasDiagnostics}) {
    return _GlobalData(
      hasJson: hasJson,
      hasDiagnostics: hasDiagnostics,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $GlobalData = _$GlobalDataTearOff();

/// @nodoc
mixin _$GlobalData {
  bool get hasJson;
  bool get hasDiagnostics;

  $GlobalDataCopyWith<GlobalData> get copyWith;
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
    Object hasJson = freezed,
    Object hasDiagnostics = freezed,
  }) {
    return _then(_value.copyWith(
      hasJson: hasJson == freezed ? _value.hasJson : hasJson as bool,
      hasDiagnostics: hasDiagnostics == freezed
          ? _value.hasDiagnostics
          : hasDiagnostics as bool,
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
    Object hasJson = freezed,
    Object hasDiagnostics = freezed,
  }) {
    return _then(_GlobalData(
      hasJson: hasJson == freezed ? _value.hasJson : hasJson as bool,
      hasDiagnostics: hasDiagnostics == freezed
          ? _value.hasDiagnostics
          : hasDiagnostics as bool,
    ));
  }
}

/// @nodoc
class _$_GlobalData implements _GlobalData {
  _$_GlobalData({@required this.hasJson, @required this.hasDiagnostics})
      : assert(hasJson != null),
        assert(hasDiagnostics != null);

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
        (other is _GlobalData &&
            (identical(other.hasJson, hasJson) ||
                const DeepCollectionEquality()
                    .equals(other.hasJson, hasJson)) &&
            (identical(other.hasDiagnostics, hasDiagnostics) ||
                const DeepCollectionEquality()
                    .equals(other.hasDiagnostics, hasDiagnostics)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(hasJson) ^
      const DeepCollectionEquality().hash(hasDiagnostics);

  @override
  _$GlobalDataCopyWith<_GlobalData> get copyWith =>
      __$GlobalDataCopyWithImpl<_GlobalData>(this, _$identity);
}

abstract class _GlobalData implements GlobalData {
  factory _GlobalData({@required bool hasJson, @required bool hasDiagnostics}) =
      _$_GlobalData;

  @override
  bool get hasJson;
  @override
  bool get hasDiagnostics;
  @override
  _$GlobalDataCopyWith<_GlobalData> get copyWith;
}
