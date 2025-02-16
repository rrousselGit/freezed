// NOTE: this does not _directly_ uses Freezed.
// To start the generator, first copy this file to /packages/_internal/models.dart
// Then run the generator for _internal, and copy the generated sources here.

import 'package:freezed/src/templates/assert.dart';
import 'package:freezed/src/templates/parameter_template.dart';
import 'package:freezed/src/templates/properties.dart';
import 'package:freezed/src/templates/prototypes.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

const _sentinel = _Sentinel();

class _Sentinel {
  const _Sentinel();
}

/// A generated property that has for type a class generated using Freezed
///
/// This allows Freezed to support deep copy of the object.
/// This does include primitives like [int] and [List].
class DeepCloneableProperty {
  DeepCloneableProperty({
    required this.name,
    required this.typeName,
    required this.type,
    required this.nullable,
    required this.genericParameters,
  });

  final String name;
  final String typeName;
  final String type;
  final bool nullable;
  final GenericsParameterTemplate genericParameters;

  DeepCloneableProperty Function({bool nullable}) get copyWith {
    return ({Object nullable = _sentinel}) {
      return DeepCloneableProperty(
        name: name,
        typeName: typeName,
        type: type,
        nullable: nullable == _sentinel ? this.nullable : nullable as bool,
        genericParameters: genericParameters,
      );
    };
  }
}

/// The information of a specific constructor of a class tagged with `@freezed`.
///
/// This only includes constructors where Freezed needs to generate something.
@freezed
class ConstructorDetails {
  ConstructorDetails({
    required this.name,
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
    required this.asserts,
  });

  final String name;
  final String unionValue;
  final bool isConst;
  final String redirectedName;
  final ParametersTemplate parameters;
  final List<Property> impliedProperties;
  final bool isDefault;
  final bool isFallback;
  final bool hasJsonSerializable;
  final String fullName;
  final String escapedName;
  final List<String> withDecorators;
  final List<String> implementsDecorators;
  final List<String> decorators;
  final List<DeepCloneableProperty> cloneableProperties;
  final List<AssertTemplate> asserts;

  String get callbackName => constructorNameToCallbackName(name);
}

@freezed
class Data {
  Data({
    required this.name,
    required this.unionKey,
    required this.generateCopyWith,
    required this.generateEqual,
    required this.generateToString,
    required this.generateFromJson,
    required this.generateToJson,
    required this.makeCollectionsImmutable,
    required this.concretePropertiesName,
    required this.constructors,
    required this.genericsDefinitionTemplate,
    required this.genericsParameterTemplate,
    required this.shouldUseExtends,
    required this.genericArgumentFactories,
  }) : assert(constructors.isNotEmpty);

  final String name;
  final String unionKey;
  final bool generateCopyWith;
  final bool generateEqual;
  final bool generateToString;
  final bool generateFromJson;
  final bool generateToJson;
  final bool makeCollectionsImmutable;
  final List<String> concretePropertiesName;
  final List<ConstructorDetails> constructors;
  final GenericsDefinitionTemplate genericsDefinitionTemplate;
  final GenericsParameterTemplate genericsParameterTemplate;
  final bool shouldUseExtends;
  final bool genericArgumentFactories;
}

@freezed
class GlobalData {
  GlobalData({
    required this.hasJson,
    required this.hasDiagnostics,
  });

  final bool hasJson;
  final bool hasDiagnostics;
}
