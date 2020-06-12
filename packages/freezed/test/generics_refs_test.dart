import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'integration/generics_refs.dart';

void main() {
  test('has no issue', () async {
    final main = await resolveSources(
      {
        'freezed|test/integration/generics_refs.dart': useAssetReader,
      },
      (r) => r.libraries.firstWhere(
          (element) => element.source.toString().contains('generics_refs')),
    );

    final errorResult = await main.session
        .getErrors('/freezed/test/integration/generics_refs.freezed.dart');

    expect(errorResult.errors, isEmpty);
  });

  test('correct generic type generated for constructor and copyWith', () {
    final header = const Header(title: 'test');
    final page = const Page();
    expect(header is Header, true);
    var fapp = FApp(head: header, pages: []);
    expect(
      fapp.pages is List<Page>,
      true,
    );

    fapp = fapp.copyWith(pages: [page]);
    expect(
      fapp.pages is List<Page>,
      true,
    );
  });
}
