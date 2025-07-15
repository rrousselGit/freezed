import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart' show ErrorReporter;
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:freezed_lint/src/tools/freezed_annotation_checker.dart';

class MissingMixin extends DartLintRule {
  MissingMixin() : super(code: _code);

  static const _code = LintCode(
    name: 'freezed_missing_mixin',
    problemMessage: 'Freezed class should mixin with {0}',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration((node) {
      final element = node.declaredElement;
      if (element == null) return;

      final annotation = freezedAnnotationChecker.hasAnnotationOfExact(element);
      if (!annotation) return;

      final name = element.name.startsWith('_')
          ? '_\$${element.name.substring(1)}'
          : '_\$${element.name}';
      final withClause = node.withClause;
      if (withClause == null) {
        reporter.atElement(element, _code, arguments: [name]);
        return;
      }

      final mixins = withClause.mixinTypes;
      if (mixins.any((m) => name == m.name2.lexeme)) return;
      reporter.atElement(element, _code, arguments: [name]);
    });
  }

  @override
  List<Fix> getFixes() => [_AddMixinFreezedClassFix()];
}

class _AddMixinFreezedClassFix extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    AnalysisError analysisError,
    List<AnalysisError> others,
  ) {
    context.registry.addClassDeclaration((node) {
      if (!analysisError.sourceRange.intersects(node.sourceRange)) return;
      reporter.createChangeBuilder(
        message: 'Add mixin _\$${node.name}',
        priority: 1,
      )..addDartFileEdit((builder) {
          final element = node.declaredElement;
          if (element == null) return;

          final name = element.displayName;
          final offset = node.leftBracket.offset - 1;
          if (node.withClause != null) {
            builder.addSimpleInsertion(offset, ', _\$$name');
          } else {
            builder.addSimpleInsertion(offset, ' with _\$$name');
          }
        });
    });
  }
}
