import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/freezed_generator.dart';

/// Builds generators for `build_runner` to run
Builder freezed(BuilderOptions options) {
  return PartBuilder(
    [FreezedGenerator()],
    '.freezed.dart',
    header: '// ignore_for_file: deprecated_member_use_from_same_package',
  );
}
