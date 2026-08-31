import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/error/error.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

void main() {
  group('marks generated classes as final', () {
    group('sealed with single constructor', () {
      test(
        'causes pattern_never_matches_value_type warning when trying to match on pattern that can never match',
        () async {
          final main = await resolveSources(
            {
              'freezed|test/integration/main.dart': r'''
library main;
import 'finalized.dart';

void main() {
  switch (SealedWithFinalFoo()) {
    case SealedWithFinalBar():
      break;

    case SealedWithFinalFoo():
      break;
  }
}
''',
            },
            (r) => r.findLibraryByName('main'),
            readAllSourcesFromFilesystem: true,
          );

          final errorResult =
              await main!.session.getErrors(
                    '/freezed/test/integration/main.dart',
                  )
                  as ErrorsResult;

          expect(errorResult.errors, hasLength(1));

          final [error] = errorResult.errors;

          expect(error.errorCode.errorSeverity, ErrorSeverity.WARNING);
          expect(error.errorCode.name, 'PATTERN_NEVER_MATCHES_VALUE_TYPE');
        },
      );
    });

    group('sealed with single constructor and superclass', () {
      test(
        'causes pattern_never_matches_value_type warning when trying to match on pattern that can never match',
        () async {
          final main = await resolveSources(
            {
              'freezed|test/integration/main.dart': r'''
library main;
import 'finalized.dart';

void main() {
  final SuperFoo foo = CustomFoo();

  switch (foo) {
    case SealedWithFinalSuperFoo():
      break;

    case AbstractWithFinalSuperFoo():
      break;

    case CustomFoo():
      break;

    case SealedWithFinalBar():
      break;
  }
}
''',
            },
            (r) => r.findLibraryByName('main'),
            readAllSourcesFromFilesystem: true,
          );

          final errorResult =
              await main!.session.getErrors(
                    '/freezed/test/integration/main.dart',
                  )
                  as ErrorsResult;

          expect(errorResult.errors, hasLength(1));

          final [error] = errorResult.errors;

          expect(error.errorCode.errorSeverity, ErrorSeverity.WARNING);
          expect(error.errorCode.name, 'PATTERN_NEVER_MATCHES_VALUE_TYPE');
        },
      );
    });

    group('sealed with multiple constructors', () {
      test(
        'causes pattern_never_matches_value_type warning when trying to match on pattern that can never match',
        () async {
          final main = await resolveSources(
            {
              'freezed|test/integration/main.dart': r'''
library main;
import 'finalized.dart';

void main() {
  switch (SealedWithFinalAbc.b()) {
    case SealedWithFinalBar():
      break;

    case SealedWithFinalAbcA():
      break;

    case SealedWithFinalAbcB():
      break;

    case SealedWithFinalAbcC():
      break;
  }
}
''',
            },
            (r) => r.findLibraryByName('main'),
            readAllSourcesFromFilesystem: true,
          );

          final errorResult =
              await main!.session.getErrors(
                    '/freezed/test/integration/main.dart',
                  )
                  as ErrorsResult;

          expect(errorResult.errors, hasLength(1));

          final [error] = errorResult.errors;

          expect(error.errorCode.errorSeverity, ErrorSeverity.WARNING);
          expect(error.errorCode.name, 'PATTERN_NEVER_MATCHES_VALUE_TYPE');
        },
      );
    });

    group('abstract with single constructor', () {
      test(
        'doesnt cause pattern_never_matches_value_type warning when trying to match on pattern that can never match',
        () async {
          final main = await resolveSources(
            {
              'freezed|test/integration/main.dart': r'''
library main;
import 'finalized.dart';

void main() {
  switch (AbstractWithFinalFoo()) {
    case AbstractWithFinalBar():
      break;

    case AbstractWithFinalFoo():
      break;
  }
}
''',
            },
            (r) => r.findLibraryByName('main'),
            readAllSourcesFromFilesystem: true,
          );

          final errorResult =
              await main!.session.getErrors(
                    '/freezed/test/integration/main.dart',
                  )
                  as ErrorsResult;

          expect(errorResult.errors, isEmpty);
        },
      );
    });

    group('abstract with multiple constructors', () {
      test(
        'does not cause pattern_never_matches_value_type warning when trying to match on pattern that can never match',
        () async {
          final main = await resolveSources(
            {
              'freezed|test/integration/main.dart': r'''
library main;
import 'finalized.dart';

void main() {
  switch (AbstractWithFinalAbc.b()) {
    case AbstractWithFinalBar():
      break;

    case AbstractWithFinalAbcA():
      break;

    case AbstractWithFinalAbcB():
      break;

    case AbstractWithFinalAbcC():
      break;
  }
}
''',
            },
            (r) => r.findLibraryByName('main'),
            readAllSourcesFromFilesystem: true,
          );

          final errorResult =
              await main!.session.getErrors(
                    '/freezed/test/integration/main.dart',
                  )
                  as ErrorsResult;

          expect(errorResult.errors, isEmpty);
        },
      );
    });
  });
}
