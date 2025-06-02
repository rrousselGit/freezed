import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart' show ErrorReporter;
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:freezed_lint/src/tools/element_extensions.dart';
import 'package:freezed_lint/src/tools/freezed_annotation_checker.dart';

class MissingPrivateEmptyCtor extends DartLintRule {
  MissingPrivateEmptyCtor() : super(code: _code);

  static const _code = LintCode(
    name: 'freezed_missing_private_empty_constructor',
    problemMessage: 'Private empty constructor required',
    correctionMessage:
        'Freezed classes containing methods, fields or accessors,'
        'requires a {0}',
    errorSeverity: ErrorSeverity.ERROR,
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

      final methods = element.methods.where((method) => !method.isStatic);
      final fields = element.fields.where((field) => !field.isStatic);
      final accessors =
          element.accessors.where((accessor) => !accessor.isStatic);
      if (methods.isEmpty && fields.isEmpty && accessors.isEmpty) return;

      final ctors = element.constructors.where((ctor) =>
          ctor.isPrivate && ctor.parameters.isEmpty && ctor.name == '_');
      if (ctors.isNotEmpty) return;

      final constToken = element.constToken();
      final name = '$constToken${element.displayName}._();';
      reporter.atElement(element, _code, arguments: [name]);
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
      final element = node.declaredElement;
      if (element == null) return;
      final name = element.displayName;
      final constToken = element.constToken();
      reporter.createChangeBuilder(
        message: 'Add $constToken$name._();',
        priority: 2,
      )..addDartFileEdit((builder) {
          final nextLine =
              resolver.lineInfo.getOffsetOfLineAfter(node.leftBracket.offset);
          builder.addSimpleInsertion(
            nextLine,
            '  $constToken$name._();\n',
          );
        });
    });
  }
}
