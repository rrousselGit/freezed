import 'dart:async';

import 'package:build/build.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'src/freezed_generator.dart';

/// Builds generators for `build_runner` to run
Builder freezed(BuilderOptions options) {
  return PartBuilder(
    [
      runZonedGuarded(
        () => FreezedGenerator(Freezed.fromJson(options.config)),
        (err, stack) {
          print('Error $err\n$stack');
        },
      )!,
    ],
    '.freezed.dart',
    header: '''
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
    ''',
    options: options,
  );
}
