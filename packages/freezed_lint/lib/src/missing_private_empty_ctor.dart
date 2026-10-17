import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analysis_server_plugin/edit/dart/dart_fix_kind_priority.dart';
import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';
import 'package:freezed_lint/src/tools/element_extensions.dart';
import 'package:freezed_lint/src/tools/freezed_annotation_checker.dart';

class MissingPrivateEmptyCtor extends AnalysisRule {
  MissingPrivateEmptyCtor()
    : super(
        name: 'freezed_missing_private_empty_constructor',
        description:
            'Freezed classes containing methods, fields or '
            'accessors require a private empty constructor.',
      );

  static const code = LintCode(
    'freezed_missing_private_empty_constructor',
    'Private empty constructor required',
    correctionMessage:
        'Freezed classes containing methods, fields or accessors, '
        'requires a {0}',
    severity: DiagnosticSeverity.ERROR,
  );

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    registry.addClassDeclaration(this, _Visitor(this));
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  _Visitor(this.rule);

  final AnalysisRule rule;

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    final element = node.declaredFragment?.element;
    if (element == null) return;
    if (!element.hasFreezedAnnotation) return;

    final methods = element.methods.where((method) => !method.isStatic);
    final fields = element.fields.where((field) => !field.isStatic);

    final accessors = [
      ...element.getters,
      ...element.setters,
    ].where((accessor) => !accessor.isStatic);
    if (methods.isEmpty && fields.isEmpty && accessors.isEmpty) return;

    final ctors = element.constructors.where(
      (ctor) =>
          ctor.isPrivate && ctor.formalParameters.isEmpty && ctor.name == '_',
    );
    if (ctors.isNotEmpty) return;

    final constToken = element.constToken() ?? '';
    final name = '$constToken${element.displayName}._();';
    rule.reportAtToken(node.namePart.typeName, arguments: [name]);
  }
}

class AddPrivateEmptyCtorFix extends ResolvedCorrectionProducer {
  AddPrivateEmptyCtorFix({required super.context});

  static const _kind = FixKind(
    'freezed_add_private_empty_constructor',
    DartFixKindPriority.standard + 1,
    'Add {0}',
  );

  String _ctor = '';

  @override
  CorrectionApplicability get applicability =>
      CorrectionApplicability.singleLocation;

  @override
  FixKind get fixKind => _kind;

  @override
  List<String> get fixArguments => [_ctor];

  @override
  Future<void> compute(ChangeBuilder builder) async {
    final classNode = node.thisOrAncestorOfType<ClassDeclaration>();
    final element = classNode?.declaredFragment?.element;
    final body = classNode?.body;
    if (element == null || body is! BlockClassBody) return;

    final constToken = element.constToken() ?? '';
    _ctor = '$constToken${element.displayName}._();';

    await builder.addDartFileEdit(file, (builder) {
      final nextLine = unitResult.lineInfo.getOffsetOfLineAfter(
        body.leftBracket.offset,
      );
      builder.addSimpleInsertion(nextLine, '  $_ctor\n');
    });
  }
}
