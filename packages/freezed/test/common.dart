import 'dart:io';
import 'dart:isolate';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:analyzer/error/error.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

final throwsCompileError = throwsA(isA<CompileError>());

Future<void> compile(String src) async {
  final main = await resolveSources(
    {
      'freezed|test/integration/main.dart':
          '''
library main;

$src
    ''',
    },
    (r) => r.findLibraryByName('main'),
    readAllSourcesFromFilesystem: true,
  );

  final errorResult = await main!.session.getErrors(
    '/freezed/test/integration/main.dart',
  ) as ErrorsResult;
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

/// Whether the resolved `analyzer` reports failed member lookups with the
/// `undefined_*_read`/`undefined_*_write` diagnostics introduced in 14.6.0,
/// which replaced `undefined_getter`, `assignment_to_final_no_setter`, etc.
///
/// CI runs against both the latest and the minimum supported analyzer, so
/// tests asserting on those codes must pick the name matching the version.
final bool usesSplitUndefinedMemberCodes = () {
  final analyzerLib = Isolate.resolvePackageUriSync(
    Uri.parse('package:analyzer/'),
  );
  if (analyzerLib == null) return true;

  final pubspec = File.fromUri(analyzerLib.resolve('../pubspec.yaml'));
  final match = RegExp(
    r'^version:\s*(\d+)\.(\d+)',
    multiLine: true,
  ).firstMatch(pubspec.readAsStringSync());
  if (match == null) return true;

  final major = int.parse(match.group(1)!);
  final minor = int.parse(match.group(2)!);
  return major > 14 || (major == 14 && minor >= 6);
}();

/// The diagnostic code for reading an undefined instance member.
String get undefinedGetterCode => usesSplitUndefinedMemberCodes
    ? 'undefined_instance_member_read'
    : 'undefined_getter';

/// The diagnostic code for writing to an instance member that has no setter.
String get noSetterCode => usesSplitUndefinedMemberCodes
    ? 'undefined_instance_member_write'
    : 'assignment_to_final_no_setter';
