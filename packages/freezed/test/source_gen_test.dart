// @dart=2.9

import 'dart:async';

import 'package:freezed/src/freezed_generator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:source_gen_test/source_gen_test.dart';
import 'package:test/test.dart';

Future<void> main() async {
  final reader =
      await initializeLibraryReaderForDirectory('test', 'source_gen_src.dart');

  initializeBuildLogTracking();

  group('source_gen_src', () {
    testAnnotatedElements<Freezed>(reader, FreezedGenerator({}));
    // TODO(rrousselGit) unskip source_gen_test after figuring out why they throw an InconsistentAnalysisException on the CI
  }, skip: true);
}
