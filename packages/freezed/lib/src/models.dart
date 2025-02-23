// NOTE: this does not _directly_ uses Freezed.
// To start the generator, first copy this file to /packages/_internal/models.dart
// Then run the generator for _internal, and copy the generated sources here.

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';
import 'package:freezed/src/ast.dart';
import 'package:freezed/src/string.dart';
import 'package:freezed/src/templates/concrete_template.dart';
import 'package:freezed/src/templates/parameter_template.dart';
import 'package:freezed/src/templates/properties.dart';
import 'package:freezed/src/templates/prototypes.dart';
import 'package:freezed/src/tools/recursive_import_locator.dart';
import 'package:freezed/src/tools/type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:source_gen/source_gen.dart';

const _sentinel = _Sentinel();

class _Sentinel {
  const _Sentinel();
}

extension on Element {
  bool get hasJsonSerializable {
    return const TypeChecker.fromRuntime(JsonSerializable).hasAnnotationOf(
      this,
      throwOnUnresolved: false,
    );
  }
}

extension on ConstructorElement {
  bool isFallbackUnion(String? fallbackConstructorName) {
    final constructorName = isDefaultConstructor(this) ? 'default' : name;
    return constructorName == fallbackConstructorName;
  }

  String unionValue(FreezedUnionCase? unionCase) {
    final annotation = const TypeChecker.fromRuntime(FreezedUnionValue)
        .firstAnnotationOf(this, throwOnUnresolved: false);
    if (annotation != null) {
      return annotation.getField('value')!.toStringValue()!;
    }

    final constructorName = isDefaultConstructor(this) ? 'default' : name;
    switch (unionCase) {
      case null:
      case FreezedUnionCase.none:
        return constructorName;
      case FreezedUnionCase.kebab:
        return constructorName.kebabCase;
      case FreezedUnionCase.pascal:
        return constructorName.pascalCase;
      case FreezedUnionCase.snake:
        return constructorName.snakeCase;
      case FreezedUnionCase.screamingSnake:
        return constructorName.screamingSnake;
    }
  }
}

const freezedType = TypeChecker.fromRuntime(Freezed);

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

  static Iterable<DeepCloneableProperty> parseAll(
    ConstructorElement constructor,
    Freezed globalConfigs,
  ) sync* {
    for (final parameter in constructor.parameters) {
      final type = parseTypeSource(parameter);

      final parameterType = parameter.type;
      if (parameterType is! InterfaceType) continue;
      final typeElement = parameterType.element;
      if (typeElement is! ClassElement) continue;

      // If the type is not defined in the same library, we skip it
      if (typeElement.library.source.uri != constructor.library.source.uri) {
        continue;
      }

      final freezedAnnotation = freezedType.firstAnnotationOf(
        typeElement,
        throwOnUnresolved: false,
      );

      /// Handles classes annotated with Freezed
      if (freezedAnnotation == null) continue;

      final configs = ClassConfig.parseAnnotation(
        freezedAnnotation,
        globalConfigs,
      );
      // copyWith not enabled, so the property is not cloneable
      if (configs.copyWith == false) continue;

      yield DeepCloneableProperty(
        name: parameter.name,
        type: type!,
        nullable: parameter.type.isNullable,
        typeName: typeElement.name,
        genericParameters: GenericsParameterTemplate(
          (parameter.type as InterfaceType)
              .typeArguments
              .map((e) => e.getDisplayString())
              .toList(),
        ),
      );
    }
  }

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

extension on FormalParameter {
  TypeAnnotation? typeAnnotation() {
    final that = this;
    return switch (that) {
      DefaultFormalParameter() => that.parameter.typeAnnotation(),
      FieldFormalParameter() => that.type,
      FunctionTypedFormalParameter() => throw UnsupportedError(
          'Parameters of format `T name()` are not supported. Use `T Function()` name.',
        ),
      SimpleFormalParameter() => that.type,
      SuperFormalParameter() => that.type,
    };
  }
}

/// The information of a specific constructor of a class tagged with ``.
///
/// This only includes constructors where Freezed needs to generate something.

class ConstructorDetails {
  ConstructorDetails({
    required this.name,
    required this.unionValue,
    required this.isConst,
    required this.redirectedName,
    required this.parameters,
    required this.properties,
    required this.isDefault,
    required this.isFallback,
    required this.hasJsonSerializable,
    required this.fullName,
    required this.escapedName,
    required this.withDecorators,
    required this.implementsDecorators,
    required this.decorators,
    required this.deepCloneableProperties,
    required this.asserts,
  });

  static void _assertValidNormalConstructorUsage(
    ClassDeclaration declaration,
    ConstructorDeclaration constructor,
  ) {
    final freezedCtors = declaration.constructors.where(
      (e) => e.factoryKeyword != null && e.redirectedConstructor != null,
    );

    if (constructor.factoryKeyword == null &&
        constructor.name?.lexeme != '_' &&
        freezedCtors.isNotEmpty) {
      throw InvalidGenerationSourceError(
        'Classes decorated with @freezed can only have a single non-factory constructor.',
        element: constructor.declaredElement,
      );
    }

    if (constructor.name?.lexeme == '_') {
      for (final param in constructor.parameters.parameters) {
        if (param.isPositional) {
          for (final ctor in freezedCtors) {
            final hasMatchingParam = ctor.parameters.parameters
                .any((e) => e.name?.lexeme == param.name?.lexeme);
            if (hasMatchingParam) continue;

            throw InvalidGenerationSourceError(
              '''
A non-factory constructor specified a positional parameter named ${param.name},
but at least one constructor does not have a matching parameter.

When specifying fields in non-factory constructor then specifying factory constructors, either:
- the parameter should be named
- or all constructors in the class should specify that parameter.
''',
              element: constructor.declaredElement,
            );
          }
        }
      }
    }
  }

  static void _assertValidFreezedConstructorUsage(
    ConstructorDeclaration constructor, {
    required String className,
  }) {
    for (final parameter in constructor.parameters.parameters) {
      final parameterElement = parameter.declaredElement;
      if (parameterElement == null) continue;

      if (parameterElement.type.nullabilitySuffix !=
              NullabilitySuffix.question &&
          parameterElement.isOptional &&
          parameterElement.defaultValue == null &&
          !parameterElement.type.isDynamic2) {
        final ctorName = constructor.name == null ? '' : '.${constructor.name}';

        throw InvalidGenerationSourceError(
          'The parameter `${parameter.name}` of `$className$ctorName` is non-nullable but is neither required nor marked with @Default',
          element: parameter.declaredElement,
        );
      }
    }
  }

  static List<ConstructorDetails> parseAll(
    ClassDeclaration declaration,
    ClassConfig configs, {
    required Freezed globalConfigs,
  }) {
    final result = <ConstructorDetails>[];

    final manualConstructor = declaration.constructors
        .where((e) => e.name?.lexeme == '_')
        .firstOrNull;

    for (final constructor in declaration.constructors) {
      if (constructor.factoryKeyword == null ||
          constructor.name?.lexeme == 'fromJson') {
        _assertValidNormalConstructorUsage(declaration, constructor);
        continue;
      }

      final redirectedName =
          constructor.redirectedConstructor?.type.name2.lexeme;

      if (redirectedName == null) {
        _assertValidNormalConstructorUsage(declaration, constructor);
        continue;
      }

      _assertValidFreezedConstructorUsage(
        constructor,
        className: declaration.name.lexeme,
      );

      final excludedProperties = manualConstructor?.parameters.parameters
              .map((e) => e.declaredElement!.name)
              .toSet() ??
          <String>{};

      final allProperties = [
        for (final parameter in constructor.parameters.parameters)
          Property.fromFormalParameter(
            parameter,
            addImplicitFinal: configs.annotation.addImplicitFinal,
            isSynthetic: !excludedProperties.contains(parameter.name!.lexeme),
          ),
      ];

      result.add(
        ConstructorDetails(
          asserts: AssertAnnotation.parseAll(constructor).toList(),
          name: constructor.name?.lexeme ?? '',
          unionValue: constructor.declaredElement!.unionValue(
            configs.annotation.unionValueCase,
          ),
          isConst: constructor.constKeyword != null,
          fullName: constructor.fullName,
          escapedName: constructor.escapedName,
          properties: allProperties,
          decorators: constructor.metadata
              .where((element) {
                final elementSourceUri =
                    element.element?.declaration?.librarySource?.uri;

                final isFreezedAnnotation = elementSourceUri != null &&
                    elementSourceUri.scheme == 'package' &&
                    elementSourceUri.pathSegments.isNotEmpty &&
                    elementSourceUri.pathSegments.first == 'freezed_annotation';

                return !isFreezedAnnotation;
              })
              .map((e) => e.toSource())
              .toList(),
          withDecorators: WithAnnotation.parseAll(constructor.declaredElement!)
              .toSet()
              .toList(),
          implementsDecorators:
              ImplementsAnnotation.parseAll(constructor.declaredElement!)
                  .toSet()
                  .toList(),
          isDefault: isDefaultConstructor(constructor.declaredElement!),
          hasJsonSerializable: constructor.declaredElement!.hasJsonSerializable,
          isFallback: constructor.declaredElement!
              .isFallbackUnion(configs.annotation.fallbackUnion),
          deepCloneableProperties: DeepCloneableProperty.parseAll(
            constructor.declaredElement!,
            globalConfigs,
          ).toList(),
          parameters: ParametersTemplate.fromParameterList(
            constructor.parameters.parameters,
            addImplicitFinal: configs.annotation.addImplicitFinal,
          ),
          redirectedName: redirectedName,
        ),
      );
    }

    if (result.length > 1 && result.any((c) => c.name.startsWith('_'))) {
      throw InvalidGenerationSourceError(
        'A freezed union cannot have private constructors',
        element: declaration.declaredElement,
      );
    }

    if (configs.annotation.fallbackUnion != null &&
        result.none((c) => c.isFallback)) {
      throw InvalidGenerationSourceError(
        'Fallback union was specified but no ${configs.annotation.fallbackUnion} constructor exists.',
        element: declaration.declaredElement,
      );
    }

    return result;
  }

  final String name;
  final String unionValue;
  final bool isConst;
  final String redirectedName;
  final ParametersTemplate parameters;
  final List<Property> properties;
  final bool isDefault;
  final bool isFallback;
  final bool hasJsonSerializable;
  final String fullName;
  final String escapedName;
  final List<WithAnnotation> withDecorators;
  final List<ImplementsAnnotation> implementsDecorators;
  final List<String> decorators;
  final List<DeepCloneableProperty> deepCloneableProperties;
  final List<AssertAnnotation> asserts;

  String get callbackName => constructorNameToCallbackName(name);

  bool isSynthetic({required String param}) {
    return properties
        .where((element) => element.name == param)
        .first
        .isSynthetic;
  }
}

class ImplementsAnnotation {
  ImplementsAnnotation({required this.type});

  static Iterable<ImplementsAnnotation> parseAll(
    ConstructorElement constructor,
  ) sync* {
    for (final meta in const TypeChecker.fromRuntime(Implements)
        .annotationsOf(constructor, throwOnUnresolved: false)) {
      final stringType = meta.getField('stringType');
      if (stringType?.isNull == false) {
        yield ImplementsAnnotation(type: stringType!.toStringValue()!);
      } else {
        yield ImplementsAnnotation(
          type: resolveFullTypeStringFrom(
            constructor.library,
            (meta.type! as InterfaceType).typeArguments.single,
          ),
        );
      }
    }
  }

  final String type;
}

class WithAnnotation {
  WithAnnotation({required this.type});

  static Iterable<WithAnnotation> parseAll(
      ConstructorElement constructor) sync* {
    for (final metadata in constructor.metadata) {
      if (!metadata.isWith) continue;
      final object = metadata.computeConstantValue()!;

      final stringType = object.getField('stringType');
      if (stringType?.isNull == false) {
        yield WithAnnotation(type: stringType!.toStringValue()!);
      } else {
        yield WithAnnotation(
          type: resolveFullTypeStringFrom(
            constructor.library,
            (object.type! as InterfaceType).typeArguments.single,
          ),
        );
      }
    }
  }

  final String type;
}

class AssertAnnotation {
  AssertAnnotation({required this.code, required this.message});

  static Iterable<AssertAnnotation> parseAll(
    ConstructorDeclaration constructor,
  ) sync* {
    for (final meta in const TypeChecker.fromRuntime(Assert).annotationsOf(
      constructor.declaredElement!,
    )) {
      yield AssertAnnotation(
        code: meta.getField('eval')!.toStringValue()!,
        message: meta.getField('message')!.toStringValue(),
      );
    }
  }

  final String code;
  final String? message;

  @override
  String toString() {
    if (message != null) {
      return "assert($code, '$message')";
    }
    return 'assert($code)';
  }
}

class ConstructorInvocation {
  ConstructorInvocation({
    required this.name,
    required this.positional,
    required this.named,
  });
  final String? name;
  final List<String> positional;
  final List<String> named;
}

class CopyWithTarget {
  CopyWithTarget({required this.parameters, required this.name});
  final ParametersTemplate parameters;
  final String? name;
}

class Class {
  Class({
    required this.name,
    required this.options,
    required this.concretePropertiesName,
    required this.constructors,
    required this.genericsDefinitionTemplate,
    required this.genericsParameterTemplate,
    required this.superCall,
    required this.properties,
    required this.copyWithTarget,
  }) : assert(constructors.isNotEmpty);

  final String name;
  final ClassConfig options;
  final List<String> concretePropertiesName;
  final List<ConstructorDetails> constructors;
  final GenericsDefinitionTemplate genericsDefinitionTemplate;
  final GenericsParameterTemplate genericsParameterTemplate;
  final ConstructorInvocation? superCall;
  final CopyWithTarget? copyWithTarget;
  final PropertyList properties;

  static Class from(
    ClassDeclaration declaration,
    ClassConfig configs, {
    required Freezed globalConfigs,
  }) {
    final privateCtor = declaration.constructors.where((ctor) {
      return ctor.name?.lexeme == '_' && ctor.factoryKeyword == null;
    }).firstOrNull;

    for (final field in declaration.declaredElement!.fields) {
      _assertValidFieldUsage(field, shouldUseExtends: privateCtor != null);
    }

    final constructors = ConstructorDetails.parseAll(
      declaration,
      configs,
      globalConfigs: globalConfigs,
    );

    final properties = PropertyList()
      ..readableProperties.addAll(
        _computeReadableProperties(declaration, constructors),
      )
      ..cloneableProperties.addAll(
        _computeCloneableProperties(
          declaration,
          constructors,
          configs,
        ),
      );

    final copyWithTarget =
        constructors.isNotEmpty ? null : declaration.copyWithTarget;
    final copyWithInvocation = copyWithTarget == null
        ? null
        : CopyWithTarget(
            name: copyWithTarget.name?.lexeme,
            parameters: ParametersTemplate.fromParameterList(
              // Only include parameters that are cloneable
              copyWithTarget.parameters.parameters.where((e) {
                return properties.cloneableProperties
                    .map((e) => e.name)
                    .contains(e.name!.lexeme);
              }),
              addImplicitFinal: configs.annotation.addImplicitFinal,
            ),
          );

    final superCall = privateCtor == null
        ? null
        : ConstructorInvocation(
            name: '_',
            positional: privateCtor.parameters.parameters
                .where((e) => e.isPositional)
                .map((e) => e.name!.lexeme)
                .toList(),
            named: privateCtor.parameters.parameters
                .where((e) => e.isNamed)
                .map((e) => e.name!.lexeme)
                .toList(),
          );

    return Class(
      name: declaration.name.lexeme,
      copyWithTarget: copyWithInvocation,
      properties: properties,
      superCall: superCall,
      options: configs,
      constructors: constructors,
      concretePropertiesName: [
        for (final p in declaration.declaredElement!.fields)
          if (!p.isStatic) p.name,
      ],
      genericsDefinitionTemplate: GenericsDefinitionTemplate.fromGenericElement(
        declaration.declaredElement!.typeParameters,
      ),
      genericsParameterTemplate: GenericsParameterTemplate.fromGenericElement(
        declaration.declaredElement!.typeParameters,
      ),
    );
  }

  static Iterable<Property> _computeCloneableProperties(
    ClassDeclaration declaration,
    List<ConstructorDetails> constructorsNeedsGeneration,
    ClassConfig configs,
  ) sync* {
    if (constructorsNeedsGeneration.isNotEmpty) {
      yield* _commonParametersBetweenAllConstructors(
        constructorsNeedsGeneration,
      ).cloneableProperties;
      return;
    }

    // Pick `(default ?? _)` constructor
    final targetConstructor = declaration.copyWithTarget;
    if (targetConstructor == null) return;

    for (final parameter in targetConstructor.parameters.parameters) {
      yield Property.fromFormalParameter(
        parameter,
        addImplicitFinal: configs.annotation.addImplicitFinal,
        isSynthetic: false,
      );
    }
  }

  static Iterable<Property> _computeReadableProperties(
    ClassDeclaration declaration,
    List<ConstructorDetails> constructorsNeedsGeneration,
  ) sync* {
    final typesMap = <String,
        List<
            ({
              TypeAnnotation? type,
              String? doc,
              bool isFinal,
              bool isSynthetic,
              List<String> decorators,
            })?>>{};
    void setForName({
      required String name,
      required TypeAnnotation? type,
      required int index,
      required String? doc,
      required bool isFinal,
      required bool isSynthetic,
      required List<String> decorators,
    }) {
      final list = typesMap.putIfAbsent(
        name,
        () => List.filled(constructorsNeedsGeneration.length + 1, null),
      );
      list[index] = (
        type: type,
        doc: doc,
        isFinal: isFinal,
        isSynthetic: isSynthetic,
        decorators: decorators,
      );
    }

    final properties = declaration.properties;

    for (final property in properties) {
      setForName(
        name: property.$2.name.lexeme,
        type: property.$1.fields.type,
        index: 0,
        doc: property.$1.documentation,
        isFinal: property.$1.fields.isFinal,
        isSynthetic: false,
        decorators: switch (property.$1.declaredElement) {
          final e? => parseDecorators(e.metadata),
          null => [],
        },
      );
    }

    for (final (index, freezedCtor) in constructorsNeedsGeneration.indexed) {
      final ctor = declaration.constructors
          .where((e) => (e.name?.lexeme ?? '') == freezedCtor.name)
          .first;

      for (final parameter in ctor.parameters.parameters) {
        final freezedParameter = freezedCtor.parameters.allParameters
            .where((e) => e.name == parameter.name?.lexeme)
            .first;

        setForName(
          name: parameter.name!.lexeme,
          type: parameter.typeAnnotation(),
          index: index + 1,
          isSynthetic: true,
          doc: parameter.documentation,
          isFinal: freezedParameter.isFinal,
          decorators: freezedParameter.decorators,
        );
      }
    }

    late final typeSystem = declaration.declaredElement!.library.typeSystem;
    late final typeProvider = declaration.declaredElement!.library.typeProvider;

    fieldLoop:
    for (final entry in typesMap.entries) {
      final name = entry.key;

      // late for: https://github.com/dart-lang/language/issues/4272
      late String typeString;
      String? doc;
      late bool isFinal;
      late DartType type;
      late List<String> decorators;
      late bool isSynthetic;
      switch (entry.value) {
        case []:
          throw AssertionError('Unreachable');
        // Only fields
        case [final fieldType?, ...]:
        // Only a single constructor and no field
        case [null, final fieldType?]:
          type = fieldType.type?.type ?? typeProvider.dynamicType;
          typeString = fieldType.type?.toSource() ?? type.toString();
          doc = fieldType.doc;
          isFinal = fieldType.isFinal;
          decorators = fieldType.decorators;
          isSynthetic = fieldType.isSynthetic;
        case [...]:
          final fields = entry.value.skip(1);
          // Field not present in all constructors, so skip it as we can't read it from the interface.
          if (fields.contains(null)) continue fieldLoop;

          doc = fields.map((e) => e!.doc).nonNulls.firstOrNull;
          decorators = fields.expand((e) => e!.decorators).toSet().toList();
          isSynthetic = true;

          final typeSources = fields.map((e) => e?.type?.toSource()).toSet();
          if (typeSources.length == 1) {
            type = fields
                .map((e) => e!.type?.type ?? typeProvider.dynamicType)
                .first;
            // All constructors use the exact same type. No need to check lower-bounds,
            // and we can paste the type in the generated source directly.
            typeString = typeSources.single ?? type.toString();
            isFinal = fields.any((e) => e!.isFinal);

            break;
          }

          type = fields
              .map((e) => e!.type?.type ?? typeProvider.dynamicType)
              .reduce((a, b) => typeSystem.leastUpperBound(a, b));
          isFinal = true;

          typeString = resolveFullTypeStringFrom(
            declaration.declaredElement!.library,
            type,
          );
      }

      yield Property(
        name: name,
        type: typeString,
        isNullable: type.isNullable,
        isDartList: type.isDartCoreList,
        isDartMap: type.isDartCoreMap,
        isDartSet: type.isDartCoreSet,
        isPossiblyDartCollection: type.isPossiblyDartCollection,
        isFinal: isFinal,
        isSynthetic: isSynthetic,
        decorators: decorators,
        defaultValueSource: null,
        doc: doc ?? '',
        hasJsonKey: false,
      );
    }
  }

  static PropertyList _commonParametersBetweenAllConstructors(
    List<ConstructorDetails> constructorsNeedsGeneration,
  ) {
    final result = PropertyList();
    if (constructorsNeedsGeneration.isEmpty) return result;

    if (constructorsNeedsGeneration case [final ctor]) {
      result.cloneableProperties.addAll(
        constructorsNeedsGeneration.first.parameters.allParameters
            .map((e) => Property.fromParameter(e, isSynthetic: true)),
      );
      result.readableProperties.addAll(result.cloneableProperties
          .where((p) => ctor.isSynthetic(param: p.name)));
      return result;
    }

    parameterLoop:
    for (final parameter
        in constructorsNeedsGeneration.first.parameters.allParameters) {
      final isSynthetic =
          constructorsNeedsGeneration.first.isSynthetic(param: parameter.name);

      final library = parameter.parameterElement!.library!;

      var commonTypeBetweenAllUnionConstructors =
          parameter.parameterElement!.type;

      for (final constructor in constructorsNeedsGeneration) {
        final matchingParameter = constructor.parameters.allParameters
            .firstWhereOrNull((p) => p.name == parameter.name);
        // The property is not present in one of the union cases, so shouldn't
        // be present in the abstract class.
        if (matchingParameter == null) continue parameterLoop;

        commonTypeBetweenAllUnionConstructors =
            library.typeSystem.leastUpperBound(
          commonTypeBetweenAllUnionConstructors,
          matchingParameter.parameterElement!.type,
        );
      }

      final matchingParameters = constructorsNeedsGeneration
          .expand((element) => element.parameters.allParameters)
          .where((element) => element.name == parameter.name)
          .toList();

      final isFinal = matchingParameters.any(
        (element) =>
            element.isFinal ||
            element.parameterElement?.type !=
                commonTypeBetweenAllUnionConstructors,
      );

      final nonNullableCommonType = library.typeSystem
          .promoteToNonNull(commonTypeBetweenAllUnionConstructors);

      final didDowncast = matchingParameters.any(
        (element) =>
            element.parameterElement?.type !=
            commonTypeBetweenAllUnionConstructors,
      );
      final didNonNullDowncast = matchingParameters.any(
        (element) =>
            element.parameterElement?.type !=
                commonTypeBetweenAllUnionConstructors &&
            element.parameterElement?.type != nonNullableCommonType,
      );
      final didNullDowncast = !didNonNullDowncast && didDowncast;

      final commonTypeString = resolveFullTypeStringFrom(
        library,
        commonTypeBetweenAllUnionConstructors,
      );

      final commonProperty = Property(
        isFinal: isFinal,
        type: commonTypeString,
        isNullable: commonTypeBetweenAllUnionConstructors.isNullable,
        isDartList: commonTypeBetweenAllUnionConstructors.isDartCoreList,
        isDartMap: commonTypeBetweenAllUnionConstructors.isDartCoreMap,
        isDartSet: commonTypeBetweenAllUnionConstructors.isDartCoreSet,
        isPossiblyDartCollection:
            commonTypeBetweenAllUnionConstructors.isPossiblyDartCollection,
        name: parameter.name,
        decorators: parameter.decorators,
        defaultValueSource: parameter.defaultValueSource,
        doc: parameter.doc,
        hasJsonKey: false,
        isSynthetic: true,
      );

      if (isSynthetic) result.readableProperties.add(commonProperty);

      // For {int a, int b, int c} | {int a, int? b, double c}, allows:
      // copyWith({int a, int b})
      // - int? b is not allowed because `null` is not compatible with the
      //   first union case.
      // - num c is not allowed because num is not assignable int/double
      if (!didNonNullDowncast) {
        final copyWithType = didNullDowncast
            ? nonNullableCommonType
            : commonTypeBetweenAllUnionConstructors;

        result.cloneableProperties.add(
          Property(
            isFinal: isFinal,
            type: resolveFullTypeStringFrom(
              library,
              copyWithType,
            ),
            isSynthetic: true,
            isNullable: copyWithType.isNullable,
            isDartList: copyWithType.isDartCoreList,
            isDartMap: copyWithType.isDartCoreMap,
            isDartSet: copyWithType.isDartCoreSet,
            isPossiblyDartCollection: copyWithType.isPossiblyDartCollection,
            name: parameter.name,
            decorators: parameter.decorators,
            defaultValueSource: parameter.defaultValueSource,
            doc: parameter.doc,
            hasJsonKey: false,
          ),
        );
      }
    }

    return result;
  }

  static void _assertValidFieldUsage(
    FieldElement field, {
    required bool shouldUseExtends,
  }) {
    if (field.isStatic) return;

    if (field.setter != null) {
      throw InvalidGenerationSourceError(
        'Classes decorated with @freezed cannot have mutable properties',
        element: field,
      );
    }

    // The field is a "Type get name => "
    if (!shouldUseExtends &&
        field.getter != null &&
        !field.getter!.isAbstract &&
        !field.getter!.isSynthetic) {
      throw InvalidGenerationSourceError(
        'Getters require a MyClass._() constructor',
        element: field,
      );
    }

    // The field is a "final name = "
    if (!shouldUseExtends && field.isFinal && field.hasInitializer) {
      throw InvalidGenerationSourceError(
        'Final variables require a MyClass._() constructor',
        element: field,
      );
    }
  }

  String get escapedName {
    var generics =
        genericsParameterTemplate.typeParameters.map((e) => '\$$e').join(', ');
    if (generics.isNotEmpty) {
      generics = '<$generics>';
    }

    final escapedElementName = name.replaceAll(r'$', r'\$');

    return '$escapedElementName$generics';
  }
}

class PropertyList {
  /// Properties that have a getter in the abstract class
  final List<Property> readableProperties = [];

  /// Properties that are visible on `copyWith`
  final List<Property> cloneableProperties = [];
}

class Library {
  Library({
    required this.hasJson,
    required this.hasDiagnostics,
  });

  final bool hasJson;
  final bool hasDiagnostics;

  static Library from(List<CompilationUnit> units) {
    return Library(
      hasJson: units.any(
        (unit) => unit.declaredElement!.library.importsJsonSerializable,
      ),
      hasDiagnostics: units.any(
        (unit) => unit.declaredElement!.library.importsDiagnosticable,
      ),
    );
  }
}

class ClassConfig {
  ClassConfig({
    required this.equal,
    required this.asString,
    required this.fromJson,
    required this.toJson,
    required this.asUnmodifiableCollections,
    required this.genericArgumentFactories,
    required this.annotation,
  });

  static ClassConfig from(
    DartObject annotation,
    ClassDeclaration declaration,
    Freezed globalConfigs, {
    required Library library,
  }) {
    final resolvedAnnotation = parseAnnotation(annotation, globalConfigs);

    late final needsJsonSerializable =
        declaration.needsJsonSerializable(library);

    return ClassConfig(
      equal: resolvedAnnotation.equal ?? !declaration.hasCustomEquals,
      asString:
          resolvedAnnotation.toStringOverride ?? !declaration.hasCustomToString,
      fromJson: resolvedAnnotation.fromJson ?? needsJsonSerializable,
      toJson: resolvedAnnotation.toJson ?? needsJsonSerializable,
      asUnmodifiableCollections:
          resolvedAnnotation.makeCollectionsUnmodifiable!,
      genericArgumentFactories: resolvedAnnotation.genericArgumentFactories,
      annotation: resolvedAnnotation,
    );
  }

  static Freezed parseAnnotation(
    DartObject annotation,
    Freezed globalConfigs,
  ) {
    return Freezed(
      copyWith: annotation.decodeField(
        'copyWith',
        decode: (obj) => obj.toBoolValue(),
        orElse: () => globalConfigs.copyWith,
      ),
      makeCollectionsUnmodifiable: annotation.decodeField(
        'makeCollectionsUnmodifiable',
        decode: (obj) => obj.toBoolValue(),
        orElse: () => globalConfigs.makeCollectionsUnmodifiable,
      ),
      equal: annotation.decodeField(
        'equal',
        decode: (obj) => obj.toBoolValue(),
        orElse: () => globalConfigs.equal,
      ),
      fallbackUnion: annotation.decodeField(
        'fallbackUnion',
        decode: (obj) => obj.toStringValue(),
        orElse: () => globalConfigs.fallbackUnion,
      ),
      fromJson: annotation.decodeField(
        'fromJson',
        decode: (obj) => obj.toBoolValue(),
        orElse: () => globalConfigs.fromJson,
      ),
      addImplicitFinal: annotation.getField('addImplicitFinal')!.toBoolValue()!,
      toJson: annotation.decodeField(
        'toJson',
        decode: (obj) => obj.toBoolValue(),
        orElse: () => globalConfigs.toJson,
      ),
      genericArgumentFactories: annotation.decodeField(
        'genericArgumentFactories',
        decode: (obj) => obj.toBoolValue()!,
        orElse: () => globalConfigs.genericArgumentFactories,
      ),
      toStringOverride: annotation.decodeField(
        'toStringOverride',
        decode: (obj) => obj.toBoolValue(),
        orElse: () => globalConfigs.toStringOverride,
      ),
      unionKey: annotation
          .decodeField(
            'unionKey',
            decode: (obj) => obj.toStringValue(),
            orElse: () => globalConfigs.unionKey,
          )
          ?.replaceAll("'", r"\'")
          .replaceAll(r'$', r'\$'),
      unionValueCase: annotation.decodeField(
        'unionValueCase',
        decode: (obj) {
          final enumIndex = obj.getField('index')?.toIntValue();
          if (enumIndex == null) return null;
          return FreezedUnionCase.values[enumIndex];
        },
        orElse: () => globalConfigs.unionValueCase,
      ),
    );
  }

  final bool equal;
  final bool asString;
  final bool fromJson;
  final bool toJson;
  final bool asUnmodifiableCollections;
  final bool genericArgumentFactories;
  final Freezed annotation;
}

extension ClassDeclarationX on ClassDeclaration {
  /// Pick either Class(), Class._() or the first constructor found, in that order.
  ConstructorDeclaration? get copyWithTarget {
    return constructors.fold<ConstructorDeclaration?>(null, (acc, ctor) {
          if (ctor.name == null) return ctor;
          if (ctor.name!.lexeme == '_') return acc ?? ctor;
          return acc;
        }) ??
        constructors.firstOrNull;
  }

  Iterable<ConstructorDeclaration> get constructors {
    return members.whereType<ConstructorDeclaration>();
  }

  Iterable<(FieldDeclaration, VariableDeclaration)> get properties {
    return members
        .whereType<FieldDeclaration>()
        .where((e) => !e.isStatic)
        .expand(
          (e) => e.fields.variables.map((f) => (e, f)),
        );
  }

  bool needsJsonSerializable(Library library) {
    if (!library.hasJson) return false;

    for (final constructor in constructors) {
      if (constructor.factoryKeyword != null &&
          constructor.name?.lexeme == 'fromJson') {
        return constructor.body is ExpressionFunctionBody;
      }
    }

    return false;
  }
}

extension on LibraryElement {
  bool get importsJsonSerializable {
    return findAllAvailableTopLevelElements().any((element) {
      return element.name == 'JsonSerializable' &&
          (element.library?.isFromPackage('json_annotation') ?? false);
    });
  }

  bool get importsDiagnosticable {
    return findAllAvailableTopLevelElements().any((element) {
      return element.name == 'DiagnosticableTreeMixin' &&
          (element.library?.isFromPackage('flutter') ?? false);
    });
  }
}

extension on DartObject {
  T decodeField<T>(
    String fieldName, {
    required T Function(DartObject obj) decode,
    required T Function() orElse,
  }) {
    final field = getField(fieldName);
    if (field == null || field.isNull) return orElse();
    return decode(field);
  }
}
