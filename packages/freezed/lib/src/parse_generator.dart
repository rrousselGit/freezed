import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

abstract class ParserGenerator<GlobalData, Data, Annotation>
    extends GeneratorForAnnotation<Annotation> {
  @override
  FutureOr<String> generate(
    LibraryReader oldLibrary,
    BuildStep buildStep,
  ) async {
    final assetId =
        await buildStep.resolver.assetIdForElement(oldLibrary.element);
    if (await buildStep.resolver.isLibrary(assetId).then((value) => !value)) {
      return '';
    }

    final library = await buildStep.resolver.libraryFor(assetId);

    final values = StringBuffer();

    final globalData = parseGlobalData(library);

    var hasGeneratedGlobalCode = false;

    for (var element
        in library.topLevelElements.where(typeChecker.hasAnnotationOf)) {
      if (!hasGeneratedGlobalCode) {
        hasGeneratedGlobalCode = true;
        for (final value
            in generateForAll(globalData).map((e) => e.toString())) {
          values.writeln(value);
        }
      }

      final data = await parseElement(buildStep, globalData, element);
      if (data == null) continue;
      for (final value
          in generateForData(globalData, data).map((e) => e.toString())) {
        values.writeln(value);
      }
    }

    return values.toString();
  }

  Iterable<Object> generateForAll(GlobalData globalData) sync* {}

  GlobalData parseGlobalData(LibraryElement library);

  FutureOr<Data> parseElement(
    BuildStep buildStep,
    GlobalData globalData,
    Element element,
  );

  Iterable<Object> generateForData(GlobalData globalData, Data data);

  @override
  Stream<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async* {
    // implemented for source_gen_test – otherwise unused
    final globalData = parseGlobalData(element.library!);
    final data = parseElement(buildStep, globalData, element);

    if (data == null) return;

    for (final value in generateForData(globalData, await data)) {
      yield value.toString();
    }
  }
}
