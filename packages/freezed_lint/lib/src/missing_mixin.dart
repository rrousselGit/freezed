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
import 'package:freezed_lint/src/tools/freezed_annotation_checker.dart';

class MissingMixin extends AnalysisRule {
  MissingMixin()
    : super(
        name: 'freezed_missing_mixin',
        description: 'Freezed classes should mixin their generated mixin.',
      );

  static const code = LintCode(
    'freezed_missing_mixin',
    'Freezed class should mixin with {0}',
    severity: DiagnosticSeverity.INFO,
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

    final name = '_\$${element.name}';
    final mixins = node.withClause?.mixinTypes ?? const [];
    if (mixins.any((m) => name == m.name.lexeme)) return;

    rule.reportAtToken(node.namePart.typeName, arguments: [name]);
  }
}

class AddMixinFreezedClassFix extends ResolvedCorrectionProducer {
  AddMixinFreezedClassFix({required super.context});

  static const _kind = FixKind(
    'freezed_add_mixin',
    DartFixKindPriority.standard,
    'Add mixin {0}',
  );

  String _mixinName = '';

  @override
  CorrectionApplicability get applicability =>
      CorrectionApplicability.singleLocation;

  @override
  FixKind get fixKind => _kind;

  @override
  List<String> get fixArguments => [_mixinName];

  @override
  Future<void> compute(ChangeBuilder builder) async {
    final classNode = node.thisOrAncestorOfType<ClassDeclaration>();
    final element = classNode?.declaredFragment?.element;
    if (classNode == null || element == null) return;

    _mixinName = '_\$${element.displayName}';

    await builder.addDartFileEdit(file, (builder) {
      final withClause = classNode.withClause;
      if (withClause != null) {
        builder.addSimpleInsertion(withClause.end, ', $_mixinName');
      } else {
        final offset = (classNode.extendsClause ?? classNode.namePart).end;
        builder.addSimpleInsertion(offset, ' with $_mixinName');
      }
    });
  }
}
