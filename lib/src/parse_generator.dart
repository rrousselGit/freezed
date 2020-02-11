import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

abstract class ParsserGenerator<T extends Element, GlobalData, Data> extends Generator {
  Iterable<T> libraryToElements(LibraryReader library);

  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    final values = StringBuffer();

    final globalData = parseGlobalData(library);

    for (var element in libraryToElements(library)) {
      final data = parseElement(globalData, element);
      if (data == null) continue;

      for (final value in generateForData(globalData, data).map((e) => e.toString())) {
        assert(value == null || (value.length == value.trim().length));
        values.writeln(value);
      }
    }

    return values.toString();
  }

  GlobalData parseGlobalData(LibraryReader library);

  Data parseElement(GlobalData globalData, T element);

  Iterable<Object> generateForData(GlobalData globalData, Data data);
}
