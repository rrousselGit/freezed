import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';

import 'package:freezed_lint/src/missing_mixin.dart';
import 'package:freezed_lint/src/missing_private_empty_ctor.dart';

/// This is the entrypoint of our plugin.
/// The analysis server looks for a top-level `plugin` variable in
/// `lib/main.dart`.
final plugin = FreezedLintPlugin();

/// The plugin registering all the rules and fixes defined by freezed_lint.
class FreezedLintPlugin extends Plugin {
  @override
  String get name => 'freezed_lint';

  @override
  void register(PluginRegistry registry) {
    registry
      ..registerWarningRule(MissingMixin())
      ..registerFixForRule(MissingMixin.code, AddMixinFreezedClassFix.new)
      ..registerWarningRule(MissingPrivateEmptyCtor())
      ..registerFixForRule(
        MissingPrivateEmptyCtor.code,
        AddPrivateEmptyCtorFix.new,
      );
  }
}
