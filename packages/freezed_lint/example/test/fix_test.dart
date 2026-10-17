// Golden tests for the quick-fixes of freezed_lint.
//
// For every file in `lib/`, each fix is applied at every offset overlapping
// a diagnostic of its rule. The resulting code is compared with
// `<file>.<fix id>-<line>.fix.dart` goldens.
//
// To update the goldens, run:
//
// ```sh
// goldens=true dart test
// ```
//
// Adapted from riverpod_lint_flutter_test.

import 'dart:async';
import 'dart:io';

import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analysis_server_plugin/registry.dart';
import 'package:analysis_server_plugin/src/correction/fix_generators.dart';
import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer/src/lint/config.dart';
import 'package:analyzer/src/lint/linter_visitor.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';
import 'package:collection/collection.dart';
import 'package:dart_style/dart_style.dart';
import 'package:freezed_lint/main.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'context.dart';
import 'encoders.dart';
import 'string.dart';

Future<void> main() async {
  final registry = _PluginRegistry();
  plugin.register(registry);

  final filesToAnalyze = _findFilesToAnalyze();

  final collection = AnalysisContextCollection(
    includedPaths: filesToAnalyze.map((e) => e.absolute.path).toList(),
  );

  for (final file in filesToAnalyze) {
    group(p.basename(file.path), () {
      late final ResolvedUnitResult unit;
      late final ResolvedLibraryResult library;
      late final List<int> uniqueOffsets;

      setUpAll(() async {
        final context = collection.contextFor(file.absolute.path);
        final session = context.currentSession;

        unit =
            await session.getResolvedUnit(file.absolute.path)
                as ResolvedUnitResult;
        library =
            await session.getResolvedLibrary(file.absolute.path)
                as ResolvedLibraryResult;

        final visitor = _VisitAllNodes((node) => range.node(node));
        unit.unit.accept(visitor);

        final tokensRanges = <SourceRange>[];
        for (
          Token? token = unit.unit.beginToken;
          token != null && token != unit.unit.endToken;
          token = token.next
        ) {
          tokensRanges.add(range.token(token));
        }

        uniqueOffsets =
            visitor._result
                .followedBy(tokensRanges)
                .map((e) => e.offset)
                .toSet()
                .toList()
              ..sort();
      });

      for (final fix in registry.fixes) {
        final producerId = fix
            .generator(context: StubCorrectionProducerContext.instance)
            .fixKind!
            .id;

        test('fix $producerId', () async {
          final rule = registry.rules.singleWhere(
            (e) => e.diagnosticCodes.contains(fix.code),
          );
          final diagnostics = _runRules(
            unit: unit,
            library: library,
            rules: [rule],
          );
          final offsets = uniqueOffsets.where(
            (offset) => diagnostics.any(
              (e) =>
                  range.startOffsetLength(e.offset, e.length).contains(offset),
            ),
          );

          final uniqueSourceOutputs =
              <({String header, String editedSource}), List<int>>{};

          for (final offset in offsets) {
            final changeBuilder = ChangeBuilder(session: unit.session);
            final context = CorrectionProducerContext.createResolved(
              libraryResult: library,
              unitResult: unit,
              selectionOffset: offset,
            );
            final producer = fix.generator(context: context);
            await producer.compute(changeBuilder);

            if (changeBuilder.sourceChange.edits.isEmpty) continue;

            final edit = changeBuilder.sourceChange.edits.single;
            final fixedDiagnostics = diagnostics.where(
              (e) =>
                  range.startOffsetLength(e.offset, e.length).contains(offset),
            );
            final editedSource = SourceEdit.applySequence(
              unit.content,
              [
                ...edit.edits,
                ..._removeIgnores(unit, fixedDiagnostics),
              ].sorted((a, b) => b.offset - a.offset),
            );

            final header = encodePrioritizedSourceChanges(
              unmodifiedSource: unit.content,
              editedSource: editedSource,
              unmodifiedLineInfo: unit.lineInfo,
              editedLineInfo: LineInfo.fromContent(editedSource),
            );

            (uniqueSourceOutputs[(
                      header: header,
                      editedSource: editedSource,
                    )] ??=
                    [])
                .add(offset);
          }

          await _expectGoldensMatchProducers(
            uniqueSourceOutputs,
            file,
            producerId: producerId,
          );
        });
      }
    });
  }
}

/// Removes the `// ignore:` comments of [diagnostics], as the fix makes
/// them unnecessary.
Iterable<SourceEdit> _removeIgnores(
  ResolvedUnitResult unit,
  Iterable<Diagnostic> diagnostics,
) sync* {
  final edits = <int, SourceEdit>{};

  for (final diagnostic in diagnostics) {
    final line = unit.lineInfo.getLocation(diagnostic.offset).lineNumber - 1;
    if (line == 0) continue;

    final start = unit.lineInfo.getOffsetOfLine(line - 1);
    final end = unit.lineInfo.getOffsetOfLine(line);
    final match = RegExp(
      r'^(\s*// ignore:)(.*)\n$',
    ).firstMatch(unit.content.substring(start, end));
    if (match == null) continue;

    final codes = match[2]!.split(',').map((e) => e.trim()).toList();
    if (!codes.remove(
      'freezed_lint/${diagnostic.diagnosticCode.lowerCaseName}',
    )) {
      continue;
    }

    edits[start] = SourceEdit(
      start,
      end - start,
      codes.isEmpty ? '' : '${match[1]} ${codes.join(', ')}\n',
    );
  }

  yield* edits.values;
}

List<Diagnostic> _runRules({
  required ResolvedUnitResult unit,
  required ResolvedLibraryResult library,
  required Iterable<AbstractAnalysisRule> rules,
}) {
  final diagnosticsListener = RecordingDiagnosticListener();

  final registry = RuleVisitorRegistryImpl(enableTiming: false);
  final context = Context.fromResolvedUnitResult(
    unit,
    library,
    diagnosticsListener,
  );

  for (final rule in rules) {
    rule.reporter = DiagnosticReporter(
      diagnosticsListener,
      unit.libraryFragment.source,
    );
    rule.registerNodeProcessors(registry, context);
  }

  unit.unit.accept(
    AnalysisRuleVisitor(registry, shouldPropagateExceptions: true),
  );

  return diagnosticsListener.diagnostics;
}

extension on File {
  File goldenFile({required String id, required String lineLabel}) {
    final baseName = p.basenameWithoutExtension(path);

    return File(p.join(parent.path, '$baseName.$id-$lineLabel.fix.dart'));
  }

  Iterable<File> goldensForFile({required String id}) {
    final prefix = '${p.basenameWithoutExtension(path)}.$id-';

    return parent.listSync().whereType<File>().where(
      (e) =>
          p.basename(e.path).startsWith(prefix) && e.path.endsWith('.fix.dart'),
    );
  }
}

final _goldenWrite = bool.parse(Platform.environment['goldens'] ?? 'false');

Future<void> _expectGoldensMatchProducers(
  Map<({String header, String editedSource}), List<int>> uniqueSourceOutputs,
  File file, {
  required String producerId,
}) async {
  final sourceContent = file.readAsStringSync();

  final actualFiles = uniqueSourceOutputs.entries.map((entry) {
    final goldenFile = file.goldenFile(
      id: producerId,
      lineLabel: _goldenLineLabel(
        sourceContent: sourceContent,
        offsets: entry.value,
      ),
    );

    return (
      goldenFile,
      _encodeProducerOutput(
        sourceFile: file,
        source: entry.key,
        goldenFile: goldenFile,
        producerId: producerId,
        offsets: entry.value,
      ),
    );
  }).toList();

  if (_goldenWrite) {
    for (final golden in file.goldensForFile(id: producerId)) {
      golden.deleteSync();
    }
    for (final (goldenFile, content) in actualFiles) {
      goldenFile.writeAsStringSync(content);
    }
    return;
  }

  final buffer = StringBuffer();

  for (final golden in file.goldensForFile(id: producerId)) {
    if (!actualFiles.any((e) => e.$1.path == golden.path)) {
      buffer.writeln('Missing golden: ${golden.path}');
    }
  }

  for (final (goldenFile, actual) in actualFiles) {
    final expected = goldenFile.existsSync()
        ? goldenFile.readAsStringSync()
        : null;
    if (actual != expected) buffer.writeln('Mismatch: $actual');
  }

  if (buffer.isNotEmpty) throw TestFailure(buffer.toString());
}

String _encodeProducerOutput({
  required File sourceFile,
  required File goldenFile,
  required ({String header, String editedSource}) source,
  required String producerId,
  required List<int> offsets,
}) {
  final buffer = StringBuffer();
  buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
  // Fixes may leave fake generated code unused. Lints are still reported.
  buffer.writeln('// ignore_for_file: type=warning');
  buffer.write(
    _renderOffsetsWithContext(
      kind: producerId,
      offsets: offsets,
      sourceContent: sourceFile.readAsStringSync(),
    ),
  );

  if (source.header.isNotEmpty) {
    buffer.write(source.header.indentWith('// '));
  }

  buffer.write(
    source.editedSource.replaceAll(
      "part '${p.basenameWithoutExtension(sourceFile.path)}",
      "part '${p.basenameWithoutExtension(goldenFile.path)}",
    ),
  );

  try {
    return DartFormatter(
      languageVersion: DartFormatter.latestLanguageVersion,
    ).format(buffer.toString());
  } catch (err, stack) {
    Zone.current.handleUncaughtError(err, stack);
    return buffer.toString();
  }
}

String _goldenLineLabel({
  required String sourceContent,
  required Iterable<int> offsets,
}) {
  final lineInfo = LineInfo.fromContent(sourceContent);
  final lineNumbers = offsets.map(
    (offset) => lineInfo.getLocation(offset).lineNumber,
  );

  return (lineNumbers.minOrNull ?? 0).toString();
}

String _renderOffsetsWithContext({
  required String kind,
  required List<int> offsets,
  required String sourceContent,
}) {
  if (offsets.isEmpty || sourceContent.isEmpty) return '';

  final lineInfo = LineInfo.fromContent(sourceContent);
  final lines = sourceContent.split('\n');

  String lineAt(int index) {
    if (index < 0 || index >= lines.length) return '';
    return lines[index];
  }

  final lineToColumns = <int, List<int>>{};
  for (final offset in offsets) {
    final location = lineInfo.getLocation(offset);
    (lineToColumns[location.lineNumber - 1] ??= []).add(
      location.columnNumber - 1,
    );
  }

  // Display each marked line along with its non-empty neighbors,
  // merging overlapping blocks.
  final displayedBlocks = <({int start, int end})>[];
  for (final lineIndex in lineToColumns.keys.sorted((a, b) => a - b)) {
    if (lineAt(lineIndex).isEmpty) continue;

    final start = lineAt(lineIndex - 1).isNotEmpty ? lineIndex - 1 : lineIndex;
    final end = lineAt(lineIndex + 1).isNotEmpty ? lineIndex + 1 : lineIndex;

    final last = displayedBlocks.lastOrNull;
    if (last != null && start <= last.end + 1) {
      displayedBlocks.last = (start: last.start, end: end);
    } else {
      displayedBlocks.add((start: start, end: end));
    }
  }

  final buffer = StringBuffer();
  buffer.writeln('// Offsets for "$kind":');

  for (final (blockIndex, block) in displayedBlocks.indexed) {
    if (blockIndex > 0) buffer.writeln('//');

    for (var index = block.start; index <= block.end; index++) {
      final line = lineAt(index);
      if (line.isEmpty) continue;

      final columns = lineToColumns[index]?.toSet().sorted((a, b) => a - b);
      if (columns == null) {
        buffer.writeln('// ${index + 1}: $line');
        continue;
      }

      final marked = StringBuffer();
      var lastPos = 0;
      for (final column in columns) {
        marked.write(line.substring(lastPos, column));
        marked.write('<>');
        lastPos = column;
      }
      marked.write(line.substring(lastPos));
      buffer.writeln('// ${index + 1}: $marked');
    }
  }

  return buffer.toString();
}

List<File> _findFilesToAnalyze() {
  return Directory('lib')
      .listSync(recursive: true)
      .whereType<File>()
      .where(
        (e) =>
            e.path.endsWith('.dart') &&
            !e.path.endsWith('.freezed.dart') &&
            !e.path.endsWith('.fix.dart'),
      )
      .sortedBy((e) => e.path);
}

class _VisitAllNodes<AccumulatedT> extends GeneralizingAstVisitor<void> {
  _VisitAllNodes(this.cb);
  final AccumulatedT Function(AstNode node) cb;

  final _result = <AccumulatedT>[];

  @override
  void visitNode(AstNode node) {
    _result.add(cb(node));
    super.visitNode(node);
  }
}

class _PluginRegistry extends PluginRegistry {
  final List<({Object code, ProducerGenerator generator})> fixes = [];
  final List<AbstractAnalysisRule> rules = [];

  @override
  void registerAssist(ProducerGenerator generator) {}

  @override
  void registerFixForRule(Object code, ProducerGenerator generator) {
    fixes.add((code: code, generator: generator));
  }

  @override
  void registerLintRule(AbstractAnalysisRule rule) => rules.add(rule);

  @override
  void registerWarningRule(AbstractAnalysisRule rule) => rules.add(rule);

  @override
  Iterable<AbstractAnalysisRule> enabled(Map<String, RuleConfig> ruleConfigs) {
    return rules;
  }
}
