import 'package:analyzer/dart/analysis/results.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'common.dart';
import 'integration/generics_refs.dart';

void main() {
  test('has no issue', () async {
    final main = await resolveSources(
      {'freezed|test/integration/generics_refs.dart': useAssetReader},
      (r) => r.libraries.firstWhere(
        (element) => element.source.toString().contains('generics_refs'),
      ),
    );

    final errorResult =
        await main.session.getErrors(
              '/freezed/test/integration/generics_refs.freezed.dart',
            )
            as ErrorsResult;

    expect(errorResult.errors, isEmpty);
  });

  test('handles lists', () async {
    final page = const Page();

    expect(PageList([page]).pages, [page]);

    await expectLater(
      compile(r'''
import 'generics_refs.dart';

void main() {
  const page = Page();
  PageList([page]);
}
'''),
      completes,
    );

    await expectLater(
      compile(r'''
import 'generics_refs.dart';

void main() {
  PageList([42]);
}
'''),
      throwsCompileError,
    );
  });

  test('handles maps', () async {
    final page = const Page();

    expect(PageMap({'foo': page}).pages, {'foo': page});

    await expectLater(
      compile(r'''
import 'generics_refs.dart';

void main() {
  const page = Page();
  PageMap({'foo': page});
}
'''),
      completes,
    );

    await expectLater(
      compile(r'''
import 'generics_refs.dart';

void main() {
  PageMap({'foo': 42});
}
'''),
      throwsCompileError,
    );
  });
}
