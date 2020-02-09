// ignore_for_file: prefer_const_constructors, omit_local_variable_types
// ignore_for_file: prefer_const_constructors, omit_local_variable_types
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';
import 'package:matcher/matcher.dart';

import 'common.dart';
import 'integration/json.dart';

Future<void> main() async {
  test('has no issue', () async {
    final main = await resolveSources(
      {
        'freezed|test/integration/json.dart': useAssetReader,
      },
      (r) => r.libraries.firstWhere((element) => element.source.toString().contains('json')),
    );

    var errorResult = await main.session.getErrors('/freezed/test/integration/json.freezed.dart');
    expect(errorResult.errors, isEmpty);
  });

  test('toJson', () {
    var value = Json();

    expect(
      value.toJson().entries,
      unorderedEquals(<String, dynamic>{}.entries),
    );
  });
}
