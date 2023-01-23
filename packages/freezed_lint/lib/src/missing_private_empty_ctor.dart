import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:freezed_lint/src/tools/freezed_annotation_checker.dart';

class MissingPrivateEmptyCtor extends DartLintRule {
  MissingPrivateEmptyCtor() : super(code: _code);

  static const _code = LintCode(
    name: 'freezed_missing_private_empty_constructor',
    problemMessage: 'Private empty constructor required',
    correctionMessage: 'Freezed classes containing methods, fields or accessors,\nrequire a const <className>._()',
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
      final methods = element.methods;
      final fields = element.fields;
      final accessors = element.accessors;
      if (methods.isEmpty && fields.isEmpty && accessors.isEmpty) return;
      final ctors = element.constructors.where((ctor) {
        return ctor.isConst &&
            ctor.isPrivate &&
            ctor.parameters.isEmpty &&
            ctor.name == '_';
      });
      if (ctors.isNotEmpty) return;
      reporter.reportErrorForElement(code, element);
    });
  }

  @override
  List<Fix> getFixes() => [_AddPrivateEmptyCtorFix()];
}

class _AddPrivateEmptyCtorFix extends DartFix {
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
        message: 'Add const ${node.name}._();',
        priority: 2,
      );
      changeBuilder.addDartFileEdit((builder) {
        final element = node.declaredElement;
        if (element == null) return;
        final name = element.displayName;
        final nextLine =
            resolver.lineInfo.getOffsetOfLineAfter(element.nameOffset);
        builder.addSimpleInsertion(
          nextLine,
          '  const ${name}._();\n',
        );
      });
    });
  }
}
