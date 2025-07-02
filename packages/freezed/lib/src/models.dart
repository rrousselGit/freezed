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
import 'package:freezed/src/freezed_generator.dart';
import 'package:freezed/src/parse_generator.dart';
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
    return const TypeChecker.fromRuntime(
      JsonSerializable,
    ).hasAnnotationOf(this, throwOnUnresolved: false);
  }
}

extension on ConstructorElement {
  bool isFallbackUnion(String? fallbackConstructorName) {
    final constructorName = isDefaultConstructor(this) ? 'default' : name;
    return constructorName == fallbackConstructorName;
  }

  String unionValue(FreezedUnionCase? unionCase) {
    final annotation = const TypeChecker.fromRuntime(
      FreezedUnionValue,
    ).firstAnnotationOf(this, throwOnUnresolved: false);
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
    ConstructorDeclaration constructorNode,
    Freezed globalConfigs,
  ) sync* {
    for (final parameterNode in constructorNode.parameters.parameters) {
      final type = parseTypeSource(parameterNode);

      final parameter = parameterNode.declaredElement!;

      final parameterType = parameter.type;
      if (parameterType is! InterfaceType) continue;
      final typeElement = parameterType.element;
      if (typeElement is! ClassElement) continue;

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
        type: type,
        nullable: parameter.type.isNullable,
        typeName: typeElement.name,
        genericParameters: GenericsParameterTemplate(
          (parameter.type as InterfaceType).typeArguments
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
    required this.isSynthetic,
  });

  static void _assertValidNormalConstructorUsage(
    ClassDeclaration declaration,
    ConstructorDeclaration constructor,
  ) {
    final freezedCtors = declaration.constructors.where(
      (e) => e.factoryKeyword != null && e.redirectedConstructor != null,
    );

    if (constructor.factoryKeyword == null &&
        !constructor.isManualCtor &&
        freezedCtors.isNotEmpty) {
      throw InvalidGenerationSourceError(
        'Classes decorated with @freezed can only have a single non-factory constructor.',
        element: constructor.declaredElement,
      );
    }

    if (constructor.isManualCtor) {
      for (final param in constructor.parameters.parameters) {
        if (param.isPositional) {
          for (final ctor in freezedCtors) {
            final hasMatchingParam = ctor.parameters.parameters.any(
              (e) => e.name?.lexeme == param.name?.lexeme,
            );
            if (hasMatchingParam) continue;

            throw InvalidGenerationSourceError('''
A non-factory constructor specified a positional parameter named ${param.name},
but at least one constructor does not have a matching parameter.

When specifying fields in non-factory constructor then specifying factory constructors, either:
- the parameter should be named
- or all constructors in the class should specify that parameter.
''', element: constructor.declaredElement);
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
    required List<CompilationUnit> unitsExcludingGeneratedFiles,
  }) {
    final result = <ConstructorDetails>[];

    final manualConstructor = declaration.manualConstructor;

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

      final excludedProperties =
          manualConstructor?.parameters.parameters
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

      final isEjected = unitsExcludingGeneratedFiles.any(
        (e) => e.declarations
            .whereType<ClassDeclaration>()
            .map((e) => e.name.lexeme)
            .contains(redirectedName),
      );

      result.add(
        ConstructorDetails(
          asserts: AssertAnnotation.parseAll(constructor).toList(),
          isSynthetic: !isEjected,
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

                final isFreezedAnnotation =
                    elementSourceUri != null &&
                    elementSourceUri.scheme == 'package' &&
                    elementSourceUri.pathSegments.isNotEmpty &&
                    elementSourceUri.pathSegments.first == 'freezed_annotation';

                return !isFreezedAnnotation;
              })
              .map((e) => e.toSource())
              .toList(),
          withDecorators: WithAnnotation.parseAll(
            constructor.declaredElement!,
          ).toSet().toList(),
          implementsDecorators: ImplementsAnnotation.parseAll(
            constructor.declaredElement!,
          ).toSet().toList(),
          isDefault: isDefaultConstructor(constructor.declaredElement!),
          hasJsonSerializable: constructor.declaredElement!.hasJsonSerializable,
          isFallback: constructor.declaredElement!.isFallbackUnion(
            configs.annotation.fallbackUnion,
          ),
          deepCloneableProperties: DeepCloneableProperty.parseAll(
            constructor,
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
  final bool isSynthetic;

  String get callbackName => constructorNameToCallbackName(name);
}

@freezed
class MapConfig with _$MapConfig {
  factory MapConfig({
    required bool map,
    required bool mapOrNull,
    required bool maybeMap,
  }) = _MapConfig;
}

@freezed
class WhenConfig with _$WhenConfig {
  factory WhenConfig({
    required bool when,
    required bool whenOrNull,
    required bool maybeWhen,
  }) = _WhenConfig;
}

@freezed
class Data with _$Data {
  @Assert('constructors.isNotEmpty')
  factory Data({
    required String name,
    required String unionKey,
    required bool generateCopyWith,
    required bool generateEqual,
    required bool generateToString,
    required MapConfig map,
    required WhenConfig when,
    required bool generateFromJson,
    required bool generateToJson,
    required bool makeCollectionsImmutable,
    required List<String> concretePropertiesName,
    required List<ConstructorDetails> constructors,
    required GenericsDefinitionTemplate genericsDefinitionTemplate,
    required GenericsParameterTemplate genericsParameterTemplate,
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

  bool get hasSuperEqual => _node.hasSuperEqual;
  bool get hasSuperHashCode => _node.hasSuperHashCode;

  String get escapedName {
    var generics = genericsParameterTemplate.typeParameters
        .map((e) => '\$$e')
        .join(', ');
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
  Library({required this.hasJson, required this.hasDiagnostics});

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

    late final needsJsonSerializable = declaration.needsJsonSerializable(
      library,
    );

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

  static Freezed parseAnnotation(DartObject annotation, Freezed globalConfigs) {
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

extension on ConstructorDeclaration {
  bool get isManualCtor => name?.lexeme == '_' && factoryKeyword == null;
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

  ConstructorDeclaration? get manualConstructor {
    return constructors.where((e) => e.isManualCtor).firstOrNull;
  }

  Iterable<ConstructorDeclaration> get constructors {
    return members.whereType<ConstructorDeclaration>();
  }

  Iterable<(FieldDeclaration, VariableDeclaration)> get properties {
    return members
        .whereType<FieldDeclaration>()
        .where((e) => !e.isStatic)
        .expand((e) => e.fields.variables.map((f) => (e, f)));
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
