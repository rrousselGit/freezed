// NOTE: this does not _directly_ uses Freezed.
// To start the generator, first copy this file to /packages/_internal/models.dart
// Then run the generator for _internal, and copy the generated sources here.

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/src/dart/ast/ast.dart';
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
    required this.impliedProperties,
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
    ConstructorDeclaration constructor, {
    required String className,
  }) {
    if (constructor.factoryKeyword == null && constructor.name?.lexeme != '_') {
      throw InvalidGenerationSourceError(
        'Classes decorated with @freezed can only have a single non-factory'
        ', named MyClass._()',
        element: constructor.declaredElement,
      );
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
        _assertValidNormalConstructorUsage(
          constructor,
          className: declaration.name.lexeme,
        );
        continue;
      }

      final redirectedName =
          constructor.redirectedConstructor?.type.name2.lexeme;

      if (redirectedName == null) {
        _assertValidNormalConstructorUsage(
          constructor,
          className: declaration.name.lexeme,
        );
        continue;
      }

      _assertValidFreezedConstructorUsage(
        constructor,
        className: declaration.name.lexeme,
      );

      final allProperties = [
        for (final parameter in constructor.parameters.parameters)
          Property.fromFormalParameter(
            parameter,
            addImplicitFinal: configs.annotation.addImplicitFinal,
          ),
      ];

      final excludedProperties = manualConstructor?.parameters.parameters
              .map((e) => e.declaredElement!.name)
              .toSet() ??
          <String>{};

      final impliedProperties = allProperties
          .where((e) => !excludedProperties.contains(e.name))
          .toList();

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
          impliedProperties: impliedProperties,
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
            constructor.parameters,
            addImplicitFinal: configs.annotation.addImplicitFinal,
          ),
          redirectedName: redirectedName,
        ),
      );
    }

    if (result.isEmpty) {
      throw InvalidGenerationSourceError(
        'Marked ${declaration.name} with @freezed, but freezed has nothing to generate',
        element: declaration.declaredElement,
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
  final List<Property> impliedProperties;
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

class Class {
  Class({
    required this.name,
    required this.options,
    required this.concretePropertiesName,
    required this.constructors,
    required this.genericsDefinitionTemplate,
    required this.genericsParameterTemplate,
    required this.shouldUseExtends,
  }) : assert(constructors.isNotEmpty);

  final String name;
  final ClassConfig options;
  final List<String> concretePropertiesName;
  final List<ConstructorDetails> constructors;
  final GenericsDefinitionTemplate genericsDefinitionTemplate;
  final GenericsParameterTemplate genericsParameterTemplate;
  final bool shouldUseExtends;

  static Class from(
    ClassDeclaration declaration,
    ClassConfig configs, {
    required Freezed globalConfigs,
  }) {
    final shouldUseExtends = declaration.constructors.any((ctor) {
      return ctor.name?.lexeme == '_' && ctor.factoryKeyword == null;
    });

    for (final field in declaration.declaredElement!.fields) {
      _assertValidFieldUsage(field, shouldUseExtends: shouldUseExtends);
    }

    final constructors = ConstructorDetails.parseAll(
      declaration,
      configs,
      globalConfigs: globalConfigs,
    );

    return Class(
      name: declaration.name.lexeme,
      shouldUseExtends: shouldUseExtends,
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
  Iterable<ConstructorDeclaration> get constructors {
    return members.whereType<ConstructorDeclaration>();
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
