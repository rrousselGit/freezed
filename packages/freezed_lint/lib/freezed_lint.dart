import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'package:freezed_lint/src/missing_mixin.dart';

/// This is the entrypoint of our plugin.
/// All plugins must specify a `createPlugin` function in their `lib/<package_name>.dart` file
PluginBase createPlugin() => _FreezedLint();

/// The class listing all the [LintRule]s and [Assist]s defined by our plugin.
class _FreezedLint extends PluginBase {
  @override
  List<LintRule> getLintRules(configs) => [
        MissingMixin(),
      ];

  @override
  List<Assist> getAssists() => [];
}
