import 'package:test/test.dart';

import 'integration/private_constructor.dart';

void main() {
  test("mixin's default methods throw", () {
    final c = PrivateConstructor.illegal();
    expect(c, isA<PrivateConstructor>());

    expect(() => c..name, throwsUnsupportedError);
  });
}
