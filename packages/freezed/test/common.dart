import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:analyzer/error/error.dart';
import 'package:build_test/build_test.dart';
import 'package:matcher/matcher.dart';
import 'package:test/test.dart';
// ignore: deprecated_member_use
export 'package:analyzer/analyzer.dart' show HintCode;

final throwsCompileError = throwsA(isA<CompileError>());

/// Compiled with no error nor warnings
final succeed = completion(const <ErrorCode>[]);

Future<List<ErrorCode>> compile(String src) async {
  final main = await resolveSources({
    'freezed|test/integration/main.dart': '''
library main;

$src
    ''',
  }, (r) => r.findLibraryByName('main'));

  final errorResult =
      await main.session.getErrors('/freezed/test/integration/main.dart');
  final criticalErrors = errorResult.errors
      .where((element) => element.severity == Severity.error)
      .toList();

  if (criticalErrors.isNotEmpty) {
    throw CompileError(criticalErrors);
  }

  return errorResult.errors.map((e) => e.errorCode).toList();
}

class CompileError extends Error {
  CompileError(this.errors);
  final List<AnalysisError> errors;

  @override
  String toString() {
    return 'CompileError: \n${errors.join('\n')}';
  }
}
