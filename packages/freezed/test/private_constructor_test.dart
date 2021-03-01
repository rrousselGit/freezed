import 'package:test/test.dart';

import 'integration/private_constructor.dart';

void main() {
  test("mixin's default methods throw", () {
    final c = PrivateConstructor.illegal();
    expect(c, isA<PrivateConstructor>());
    expect(() => c.map((value) => null, union1: (_) => null),
        throwsUnsupportedError);
    expect(() => c.maybeMap((value) => null, orElse: () {}),
        throwsUnsupportedError);
    expect(() => c.when((value) => null, union1: (_, __) => null),
        throwsUnsupportedError);
    expect(() => c.maybeWhen((value) => null, orElse: () => null),
        throwsUnsupportedError);
    expect(() => c..name, throwsUnsupportedError);
  });
}
