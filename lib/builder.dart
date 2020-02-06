import 'package:build/build.dart';
import 'package:immutable/src/generator.dart';
import 'package:source_gen/source_gen.dart';

/// Builds generators for `build_runner` to run
Builder immutable(BuilderOptions options) {
  return SharedPartBuilder([ImmutableGenerator()], 'immutable');
}
