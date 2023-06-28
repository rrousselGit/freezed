import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:collection/collection.dart';
import 'package:freezed/src/freezed_ast/ast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:source_gen/source_gen.dart';

typedef _AnnotatedClass = ({DartObject annotation, ClassDeclaration node});

_AnnotatedClass? _findAnnotatedClasses(
  ClassDeclaration node,
) {
  final element = node.declaredElement;
  if (element == null) return null;

  final annotation =
      const TypeChecker.fromRuntime(Freezed).firstAnnotationOfExact(element);
  if (annotation == null) return null;

  return (annotation: annotation, node: node);
}

List<FreezedClassDefinition> parseFreezedAst(
  Iterable<CompilationUnit> units, {
  required Freezed buildYamlConfigs,
}) {
  final annotatedClasses = units
      .expand((e) => e.declarations)
      .whereType<ClassDeclaration>()
      .map(_findAnnotatedClasses)
      .whereNotNull()
      .toList();

  return [
    for (final annotatedClass in annotatedClasses)
      _parseAnnotatedClass(
        annotatedClass,
        buildYamlConfigs: buildYamlConfigs,
      ),
  ];

  // TODO assert that the freezed mixin is used on the class
  // TODO assert that unions are sealed classes.
  // TODO throw if "const" is used on mutable classes
}

FreezedClassDefinition _parseAnnotatedClass(
  _AnnotatedClass annotatedClass, {
  required Freezed buildYamlConfigs,
}) {
  final children = annotatedClass.node.members
      .whereType<ConstructorDeclaration>()
      .map(
        (constructor) => switch (constructor) {
          ConstructorDeclaration(:final redirectedConstructor?) =>
            FreezedConstructorIdentifier(
              redirectedConstructor,
              constructor,
              annotatedClass.node,
            ),
          _ => null,
        },
      )
      .whereNotNull()
      .toList();

  return FreezedClassDefinition(
    annotatedClass.node,
    annotation: _parseAnnotation(
      annotatedClass.annotation,
      buildYamlConfigs: buildYamlConfigs,
    ),
    children: children,
  );
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

Freezed _parseAnnotation(
  DartObject annotation, {
  required Freezed buildYamlConfigs,
}) {
  return Freezed(
    copyWith: annotation.decodeField(
      'copyWith',
      decode: (obj) => obj.toBoolValue(),
      orElse: () => buildYamlConfigs.copyWith,
    ),
    makeCollectionsUnmodifiable: annotation.decodeField(
      'makeCollectionsUnmodifiable',
      decode: (obj) => obj.toBoolValue(),
      orElse: () => buildYamlConfigs.makeCollectionsUnmodifiable,
    ),
    equal: annotation.decodeField(
      'equal',
      decode: (obj) => obj.toBoolValue(),
      orElse: () => buildYamlConfigs.equal,
    ),
    fallbackUnion: annotation.decodeField(
      'fallbackUnion',
      decode: (obj) => obj.toStringValue(),
      orElse: () => buildYamlConfigs.fallbackUnion,
    ),
    fromJson: annotation.decodeField(
      'fromJson',
      decode: (obj) => obj.toBoolValue(),
      orElse: () => buildYamlConfigs.fromJson,
    ),
    addImplicitFinal: annotation.getField('addImplicitFinal')!.toBoolValue()!,
    map: annotation.decodeField(
      'map',
      decode: (obj) {
        return FreezedMapOptions(
          map: obj.decodeField(
            'map',
            decode: (obj) => obj.toBoolValue(),
            orElse: () => buildYamlConfigs.map?.map,
          ),
          maybeMap: obj.decodeField(
            'maybeMap',
            decode: (obj) => obj.toBoolValue(),
            orElse: () => buildYamlConfigs.map?.maybeMap,
          ),
          mapOrNull: obj.decodeField(
            'mapOrNull',
            decode: (obj) => obj.toBoolValue(),
            orElse: () => buildYamlConfigs.map?.mapOrNull,
          ),
        );
      },
      orElse: () => buildYamlConfigs.map,
    ),
    toJson: annotation.decodeField(
      'toJson',
      decode: (obj) => obj.toBoolValue(),
      orElse: () => buildYamlConfigs.toJson,
    ),
    genericArgumentFactories: annotation.decodeField(
      'genericArgumentFactories',
      decode: (obj) => obj.toBoolValue()!,
      orElse: () => buildYamlConfigs.genericArgumentFactories,
    ),
    toStringOverride: annotation.decodeField(
      'toStringOverride',
      decode: (obj) => obj.toBoolValue(),
      orElse: () => buildYamlConfigs.toStringOverride,
    ),
    unionKey: annotation
        .decodeField(
          'unionKey',
          decode: (obj) => obj.toStringValue(),
          orElse: () => buildYamlConfigs.unionKey,
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
      orElse: () => buildYamlConfigs.unionValueCase,
    ),
    when: annotation.decodeField(
      'when',
      decode: (obj) {
        return FreezedWhenOptions(
          when: obj.decodeField(
            'when',
            decode: (obj) => obj.toBoolValue(),
            orElse: () => buildYamlConfigs.when?.when,
          ),
          maybeWhen: obj.decodeField(
            'maybeWhen',
            decode: (obj) => obj.toBoolValue(),
            orElse: () => buildYamlConfigs.when?.maybeWhen,
          ),
          whenOrNull: obj.decodeField(
            'whenOrNull',
            decode: (obj) => obj.toBoolValue(),
            orElse: () => buildYamlConfigs.when?.whenOrNull,
          ),
        );
      },
      orElse: () => buildYamlConfigs.when,
    ),
  );
}
