import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/error/error.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

void main() {
  group('marks generated classes as final and sealed', () {
    group('single constructor', () {
      test(
          'causes pattern_never_matches_value_type warning when trying to match on pattern that can never match',
          () async {
        final main = await resolveSources(
          {
            'freezed|test/integration/main.dart': r'''
library main;
import 'finalized.dart';

void main() {
  switch (FinalizedFoo()) {
    case FinalizedBar():
      break;

    case FinalizedFoo():
      break;
  }
}
''',
          },
          (r) => r.findLibraryByName('main'),
        );

        final errorResult = await main!.session
            .getErrors('/freezed/test/integration/main.dart') as ErrorsResult;

        expect(errorResult.errors, hasLength(1));

        final [error] = errorResult.errors;

        expect(error.errorCode.errorSeverity, ErrorSeverity.WARNING);
        expect(error.errorCode.name, 'PATTERN_NEVER_MATCHES_VALUE_TYPE');
      });
    });

    group('multiple constructors', () {
      test(
          'causes pattern_never_matches_value_type warning when trying to match on pattern that can never match',
          () async {
        final main = await resolveSources(
          {
            'freezed|test/integration/main.dart': r'''
library main;
import 'finalized.dart';

void main() {
  switch (FinalizedMultiple.b()) {
    case FinalizedBar():
      break;

    case FinalizedMultipleA():
      break;

    case FinalizedMultipleB():
      break;

    case FinalizedMultipleC():
      break;
  }
}
''',
          },
          (r) => r.findLibraryByName('main'),
        );

        final errorResult = await main!.session
            .getErrors('/freezed/test/integration/main.dart') as ErrorsResult;

        expect(errorResult.errors, hasLength(1));

        final [error] = errorResult.errors;

        expect(error.errorCode.errorSeverity, ErrorSeverity.WARNING);
        expect(error.errorCode.name, 'PATTERN_NEVER_MATCHES_VALUE_TYPE');
      });
    });
  });
}
