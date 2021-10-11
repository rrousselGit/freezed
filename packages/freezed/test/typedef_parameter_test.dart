import 'package:analyzer/dart/analysis/results.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

void main() {
  test('has no issue', () async {
    final main = await resolveSources(
      {
        'freezed|test/integration/typedef_parameter.dart': useAssetReader,
      },
          (r) => r.libraries.firstWhere(
              (element) => element.source.toString().contains('typedef_parameter')),
    );

    final errorResult = await main.session
        .getErrors('/freezed/test/integration/typedef_parameter_test.freezed.dart')
    as ErrorsResult;

    expect(errorResult.errors, isEmpty);
  });
}