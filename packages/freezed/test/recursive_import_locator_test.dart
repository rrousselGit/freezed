import 'package:test/test.dart';

import 'integration/export.dart';

void main() {
  test('recursive export of json_annotation works', () {
    expect(
      Export.fromJson(<String, dynamic>{
        'a': 42,
      }),
      const Export(42),
    );
  });
}
