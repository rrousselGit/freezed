import 'dart:async';

import 'package:freezed/src/freezed_generator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:source_gen_test/source_gen_test.dart';

Future<void> main() async {
  final reader = await initializeLibraryReaderForDirectory(
    'test',
    'source_gen_src.dart',
  );

  initializeBuildLogTracking();

  testAnnotatedElements<Freezed>(
    reader,
    FreezedGenerator(Freezed.fromJson(<Object?, Object?>{}), format: false),
  );
}
