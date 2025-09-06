import 'dart:async';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';

typedef AnnotationMeta = ({Declaration declaration, DartObject annotation});

abstract class ParserGenerator<AnnotationT>
    extends GeneratorForAnnotation<AnnotationT> {
  @override
  FutureOr<String> generate(
    LibraryReader oldLibrary,
    BuildStep buildStep,
  ) async {
    if (oldLibrary.classes.isEmpty) return '';

    final units = await Stream.fromFutures(
      oldLibrary.element.fragments.map(
        (e) => buildStep.resolver.astNodeFor(e, resolve: true),
      ),
    ).cast<CompilationUnit>().toList();

    final values = StringBuffer();
    final datas = <AnnotationMeta>[];

    for (final unit in units) {
      for (var declaration in unit.declarations) {
        final declaredFragment = declaration.declaredFragment;
        if (declaredFragment == null) continue;

        final annotation = typeChecker.firstAnnotationOf(
          declaredFragment.element,
          throwOnUnresolved: false,
        );
        if (annotation == null) continue;

        datas.add((annotation: annotation, declaration: declaration));
      }
    }

    for (final value in generateAll(units, datas)) {
      values.writeln(value);
    }

    return values.toString();
  }

  Iterable<Object?> generateAll(
    List<CompilationUnit> units,
    List<AnnotationMeta> annotatedElements,
  ) sync* {}

  @override
  Stream<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async* {
    // implemented for source_gen_test – otherwise unused

    final annotation = typeChecker.firstAnnotationOf(
      element,
      throwOnUnresolved: false,
    );
    if (annotation == null) return;

    final unit = await element.session!.getResolvedUnit(
      element.firstFragment.libraryFragment!.source.fullName,
    );
    unit as ResolvedUnitResult;
    final Object? ast = unit.unit.declarations.firstWhereOrNull(
      (declaration) =>
          declaration.declaredFragment?.element.name == element.name!,
    );
    if (ast == null) {
      throw InvalidGenerationSourceError('Ast not found', element: element);
    }
    if (ast is! Declaration) {
      throw InvalidGenerationSourceError(
        'Ast is not a Declaration',
        element: element,
      );
    }

    final datas = <AnnotationMeta>[(declaration: ast, annotation: annotation)];
    for (final value in generateAll([unit.unit], datas)) {
      yield value.toString();
    }
  }
}
