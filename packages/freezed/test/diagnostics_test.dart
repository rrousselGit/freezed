import 'dart:io';

import 'package:test/test.dart';

void main() {
  // `package:flutter/foundation.dart` cannot be loaded by `dart test`, so the
  // generated `debugFillProperties` is checked as source instead of being run.
  test('debugFillProperties escapes `\$` in field names', () {
    final generated = File('test/integration/diagnostics.freezed.dart')
        .readAsStringSync();

    expect(generated, contains(r"DiagnosticsProperty('\$id',"));
    expect(generated, isNot(contains(r"DiagnosticsProperty('$id',")));
  });
}
