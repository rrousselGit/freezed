import 'package:test/test.dart';

import 'common.dart';

void main() {
  group('compile utility', () {
    test('compiles', () async {
      await expectLater(compile(r'''
import 'single_class_constructor.dart';

void main() {
  final test = MyClass(a: 'a', b: 42);
}
'''), completes);
    });
    test('does not compile', () async {
      await expectLater(compile(r'''
import 'single_class_constructor.dart';

void main() {
  final test = 
}
'''), throwsCompileError);
    });
  });
}
