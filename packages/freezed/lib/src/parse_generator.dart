import 'dart:async';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';

abstract class ParserGenerator<GlobalData, Data, Annotation>
    extends GeneratorForAnnotation<Annotation> {
  @override
  FutureOr<String> generate(
    LibraryReader oldLibrary,
    BuildStep buildStep,
  ) async {
    final classesForUniqueSource = <Uri, ClassElement>{
      for (final clazz in oldLibrary.classes) clazz.source.uri: clazz
    };
    if (classesForUniqueSource.isEmpty) return '';

    final units = await Stream.fromFutures(
      classesForUniqueSource.values.map(
        (e) => buildStep.resolver.astNodeFor(e, resolve: true),
      ),
    )
        .where((e) => e != null)
        .map((e) => e!.root)
        .cast<CompilationUnit>()
        .toList();

    final values = StringBuffer();
    final globalData = parseGlobalData(units);
    var hasGeneratedGlobalCode = false;

    for (final unit in units) {
      for (var declaration in unit.declarations) {
        final declaredElement = declaration.declaredElement;
        if (declaredElement == null) continue;

        final annotation = typeChecker.firstAnnotationOf(
          declaredElement,
          throwOnUnresolved: false,
        );

        if (annotation == null) continue;

        if (!hasGeneratedGlobalCode) {
          hasGeneratedGlobalCode = true;
          for (final value in generateForAll(globalData)) {
            values.writeln(value);
          }
        }

        final data = await parseDeclaration(
          buildStep,
          globalData,
          declaration,
          annotation,
        );
        if (data == null) continue;

        for (final value in generateForData(globalData, data)) {
          values.writeln(value);
        }
      }
    }

    return values.toString();
  }

  Iterable<Object> generateForAll(GlobalData globalData) sync* {}

  GlobalData parseGlobalData(List<CompilationUnit> unit);

  FutureOr<Data> parseDeclaration(
    BuildStep buildStep,
    GlobalData globalData,
    Declaration declaration,
    DartObject annotation,
  );

  Iterable<Object> generateForData(GlobalData globalData, Data data);

  @override
  Stream<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async* {
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

    // implemented for source_gen_test – otherwise unused
    final globalData = parseGlobalData([unit.unit]);
    final data = parseDeclaration(buildStep, globalData, ast, annotation);

    if (data == null) return;

    for (final value in generateForData(globalData, await data)) {
      yield value.toString();
    }
  }
}
