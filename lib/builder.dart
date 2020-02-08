import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/generator.dart';

/// Builds generators for `build_runner` to run
Builder freezed(BuilderOptions options) {
  return SharedPartBuilder([FreezedGenerator()], 'freezed');
}
