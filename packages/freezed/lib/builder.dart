import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/freezed_generator.dart';

/// Builds generators for `build_runner` to run
Builder freezed(BuilderOptions options) {
  final coverage = options.config['no-coverage'] as bool ?? false;

  return PartBuilder(
    [FreezedGenerator(options.config)],
    '.freezed.dart',
    header: '// GENERATED CODE - DO NOT MODIFY BY HAND\n'
        '// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies\n'
        '${coverage ? '// coverage:ignore-file\n' : ''}',
  );
}
