import 'dart:async';
import 'dart:io' show Directory, File;

import 'package:freezed/src/freezed_generator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:source_gen_test/source_gen_test.dart';
import 'package:test/test.dart';

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

  test('generated files do not contain default source_gen header', () {
    // Read generated files from the integration folder.
    final generatedFiles = Directory('test/integration')
        .listSync(recursive: true)
        .whereType<File>()
        .where((e) => e.path.endsWith('.freezed.dart'))
        .toList();

    // Ensure we have files to test
    expect(
      generatedFiles,
      isNotEmpty,
      reason: 'Expected to find .freezed.dart files in test/integration',
    );

    for (final file in generatedFiles) {
      final content = file.readAsStringSync();

      // Verify the custom header is present
      expect(content, contains('// coverage:ignore-file'));
      expect(
        content.substring(
          0,
          '// GENERATED CODE - DO NOT MODIFY BY HAND'.length + 1,
        ),
        startsWith('// GENERATED CODE - DO NOT MODIFY BY HAND'),
        reason: 'Start with GENERATED for Github Linguist',
      );
      expect(content, contains('// ignore_for_file: type=lint'));

      // Verify the default source_gen header is NOT present
      expect(
        content,
        isNot(contains('// dart format width')),
        reason:
            'File ${file.path} should not contain default source_gen header',
      );
    }
  });
}
