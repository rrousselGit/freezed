import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:analyzer/error/listener.dart' show DiagnosticReporter;
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:freezed_lint/src/tools/freezed_annotation_checker.dart';

class MissingMixin extends DartLintRule {
  MissingMixin() : super(code: _code);

  static const _code = LintCode(
    name: 'freezed_missing_mixin',
    problemMessage: 'Freezed class should mixin {0}',
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration((node) {
      final element = node.declaredFragment?.element;
      if (element == null) return;

      final annotation = freezedAnnotationChecker.hasAnnotationOfExact(element);
      if (!annotation) return;

      final name = '_\$${element.name}';
      final withClause = node.withClause;
      if (withClause == null) {
        reporter.atElement2(element, _code, arguments: [name]);
        return;
      }

      final mixins = withClause.mixinTypes;
      if (mixins.any((m) => name == m.name.lexeme)) return;
      reporter.atElement2(element, _code, arguments: [name]);
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
    Diagnostic analysisError,
    List<Diagnostic> others,
  ) {
    context.registry.addClassDeclaration((node) {
      if (!analysisError.sourceRange.intersects(node.sourceRange)) return;
      reporter.createChangeBuilder(
        message: 'Add mixin _\$${node.name}',
        priority: 1,
      )..addDartFileEdit((builder) {
          final element = node.declaredFragment?.element;
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
