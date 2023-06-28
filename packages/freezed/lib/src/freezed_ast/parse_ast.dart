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
  Iterable<CompilationUnit> units,
) {
  final annotatedClasses = units
      .expand((e) => e.declarations)
      .whereType<ClassDeclaration>()
      .map(_findAnnotatedClasses)
      .whereNotNull()
      .toList();

  return [
    for (final annotatedClass in annotatedClasses)
      _parseAnnotatedClass(annotatedClass),
  ];

  // TODO assert that the freezed mixin is used on the class
  // TODO assert that unions are sealed classes.
  // TODO throw if "const" is used on mutable classes
}

FreezedClassDefinition _parseAnnotatedClass(
  _AnnotatedClass annotatedClass,
) {
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
    annotation: _parseAnnotation(annotatedClass.annotation),
    children: children,
  );
}

FreezedAnnotation _parseAnnotation(DartObject annotation) {
  // TODO
  return FreezedAnnotation();
}
