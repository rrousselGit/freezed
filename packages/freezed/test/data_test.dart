import 'package:test/test.dart';

import 'common.dart';
import 'integration/data.dart';

void main() {
  test('Can mutate non-final parameters', () {
    final data = Data(0, 1);

    expect(data.b, 1);
    expect(data.a, 0);

    data.a = 42;

    expect(data.a, 42);
  });

  test('Final parameters generate immutable properties', () async {
    await expectLater(
      compile(r'''
import 'data.dart';

void main() {
  final value = Data(0, 1);
}
'''),
      completes,
    );

    await expectLater(
      compile(r'''
import 'data.dart';

void main() {
  final value = Data(0, 1);
  value.b = 42;
}
'''),
      throwsCompileError,
    );
  });
}
