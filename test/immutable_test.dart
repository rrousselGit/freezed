import 'dart:async';

import 'package:source_gen_test/source_gen_test.dart';

import 'package:immutable/immutable.dart';

Future<void> main() async {
  final reader = await initializeLibraryReaderForDirectory(
      'test/src', 'test_src.dart');

  initializeBuildLogTracking();
  testAnnotatedElements<Immutable>(reader, ImmutableGenerator());
}
