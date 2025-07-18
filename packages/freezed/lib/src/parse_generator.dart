import 'dart:async';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer_buffer/analyzer_buffer.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:path/path.dart' as path;
import 'package:source_gen/source_gen.dart';

typedef AnnotationMeta = ({Declaration declaration, DartObject annotation});

abstract class Template {
  factory Template(String content) = _TemplateImpl;
  void generate(AnalyzerBuffer buffer);
}

class _TemplateImpl implements Template {
  const _TemplateImpl(this.content);
  final String content;

  @override
  void generate(AnalyzerBuffer buffer) => buffer.write(content);
}

abstract class ParserGenerator<AnnotationT>
    extends GeneratorForAnnotation<AnnotationT> {
  @override
  FutureOr<String> generate(
    LibraryReader oldLibrary,
    BuildStep buildStep,
  ) async {
    if (oldLibrary.classes.isEmpty) return '';

    final units = await Stream.fromFutures(
      oldLibrary.element.units.map(
        (e) => buildStep.resolver.astNodeFor(e, resolve: true),
      ),
    ).cast<CompilationUnit>().toList();

    final datas = <AnnotationMeta>[];

    for (final unit in units) {
      for (var declaration in unit.declarations) {
        final declaredElement = declaration.declaredElement;
        if (declaredElement == null) continue;

        final annotation = typeChecker.firstAnnotationOf(
          declaredElement,
          throwOnUnresolved: false,
        );
        if (annotation == null) continue;

        datas.add((annotation: annotation, declaration: declaration));
      }
    }

    final buffer = AnalyzerBuffer.fromLibrary(
      oldLibrary.element,
      sourcePath: path.join(
        path.dirname(buildStep.inputId.path),
        '${path.basenameWithoutExtension(buildStep.inputId.path)}.freezed.dart',
      ),
    );
    for (final value in generateAll(units, datas)) {
      value.generate(buffer);
      if (!buffer.isEmpty) {
        buffer.write('\n');
      }
    }

    return buffer.toString();
  }

  Iterable<Template> generateAll(
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
      element.source!.fullName,
    );
    unit as ResolvedUnitResult;
    final Object? ast = unit.unit.declarations.firstWhereOrNull(
      (declaration) => declaration.declaredElement?.name == element.name!,
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

    final buffer = AnalyzerBuffer.fromLibrary(
      unit.libraryElement,
      sourcePath: path.join(
        path.dirname(buildStep.inputId.path),
        '${path.basenameWithoutExtension(buildStep.inputId.path)}.freezed.dart',
      ),
    );

    final datas = <AnnotationMeta>[(declaration: ast, annotation: annotation)];
    for (final value in generateAll([unit.unit], datas)) {
      value.generate(buffer);
    }

    yield buffer.toString();
  }
}
