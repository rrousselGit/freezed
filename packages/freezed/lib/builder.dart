import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart' show DartFormatter;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pub_semver/pub_semver.dart' show Version;
import 'package:source_gen/source_gen.dart';

import 'src/freezed_generator.dart';

/// Builds generators for `build_runner` to run
Builder freezed(BuilderOptions options) {
  return PartBuilder(
    [
      FreezedGenerator(
        Freezed.fromJson(options.config),
        format: options.config['format'] as bool? ?? false,
      ),
    ],
    '.freezed.dart',
    formatOutput: _defaultFormatOutput,
    header: '''
// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning
    ''',
    options: options,
  );
}

String _defaultFormatOutput(String code, Version version) =>
    DartFormatter(languageVersion: version).format(code);
