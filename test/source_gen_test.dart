import 'dart:async';

import 'package:freezed/src/generator.dart';
import 'package:meta/meta.dart';
import 'package:source_gen_test/source_gen_test.dart';

Future<void> main() async {
  final reader = await initializeLibraryReaderForDirectory('test/integration', 'source_gen_src.dart');

  initializeBuildLogTracking();
  testAnnotatedElements<Immutable>(reader, FreezedGenerator());
}
