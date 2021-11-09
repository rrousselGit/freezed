import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:analyzer/error/error.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

final throwsCompileError = throwsA(isA<CompileError>());

Future<void> compile(String src) async {
  final main = await resolveSources({
    'freezed|test/integration/main.dart': '''
library main;

$src
    ''',
  }, (r) => r.findLibraryByName('main'));

  final errorResult = await main!.session
      .getErrors('/freezed/test/integration/main.dart') as ErrorsResult;
  final criticalErrors = errorResult.errors
      .where((element) => element.severity == Severity.error)
      .toList();

  if (criticalErrors.isNotEmpty) {
    throw CompileError(criticalErrors);
  }
}

class CompileError extends Error {
  CompileError(this.errors);
  final List<AnalysisError> errors;

  @override
  String toString() {
    return 'CompileError: \n${errors.join('\n')}';
  }
}
