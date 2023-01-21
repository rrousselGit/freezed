import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:freezed_lint/src/tools/freezed_annotation_checker.dart';

class MissingMixin extends DartLintRule {
  MissingMixin() : super(code: _code);

  static const _code = LintCode(
    name: 'freezed_missing_mixin',
    problemMessage: 'Freezed class should mixin with _\$<className>',
    errorSeverity: ErrorSeverity.WARNING,
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
      if (element.mixins.isNotEmpty) return;
      reporter.reportErrorForElement(code, element);
    });
  }

  @override
  List<Fix> getFixes() => [_AddMixinFreezedCLassFix()];
}

class _AddMixinFreezedCLassFix extends DartFix {
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
      final changeBuilder = reporter.createChangeBuilder(
        message: 'Add mixin _\$${node.name}',
        priority: 1,
      );
      changeBuilder.addDartFileEdit((builder) {
        final element = node.declaredElement;
        if (element != null) {
          final name = element.displayName;
          builder.addSimpleInsertion(
            element.nameOffset + element.nameLength,
            ' with _\$$name',
          );
        }
      });
    });
  }
}
