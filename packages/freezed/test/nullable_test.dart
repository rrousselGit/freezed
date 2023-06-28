import 'package:test/test.dart';

import 'common.dart';
import 'integration/nullable.dart';

void main() {
  test('RequiredPositional', () async {
    await expectLater(compile(r'''
import 'nullable.dart';

void main() {
  RequiredPositional(42).copyWith(a: 42);
}
'''), completes);

    await expectLater(compile(r'''
import 'nullable.dart';

void main() {
  RequiredPositional(null);
}
'''), throwsCompileError);

    await expectLater(compile(r'''
import 'nullable.dart';

void main() {
  RequiredPositional(42).copyWith(a: null);
}
'''), throwsCompileError);
  });

  test('DefaultPositional', () async {
    await expectLater(compile(r'''
import 'nullable.dart';

void main() {
  DefaultPositional(42).copyWith(a: 42);
  DefaultPositional().copyWith(a: 42);
}
'''), completes);

    await expectLater(compile(r'''
import 'nullable.dart';

void main() {
  DefaultPositional(null);
}
'''), throwsCompileError);

    await expectLater(compile(r'''
import 'nullable.dart';

void main() {
  DefaultPositional().copyWith(a: null);
}
'''), throwsCompileError);
  });

  test('DefaultNamed', () async {
    await expectLater(compile(r'''
import 'nullable.dart';

void main() {
    DefaultNamed(a: 42).copyWith(a: 42);
    DefaultNamed().copyWith(a: 42);
}
'''), completes);

    await expectLater(compile(r'''
import 'nullable.dart';

void main() {
    DefaultNamed(a: null);
}
'''), throwsCompileError);

    await expectLater(compile(r'''
import 'nullable.dart';

void main() {
    DefaultNamed().copyWith(a: null);
}
'''), throwsCompileError);
  });

  // test('NullableRequiredPositional', () {
  //   // ignore: unused_result
  //   NullableRequiredPositional(42).copyWith(a: 42);
  //   // ignore: unused_result
  //   NullableRequiredPositional(null).copyWith(a: null);
  // });

  // test('Positional', () {
  //   // ignore: unused_result
  //   Positional(42).copyWith(a: 42);
  //   // ignore: unused_result
  //   Positional(null).copyWith(a: null);
  // });

  // test('Named', () {
  //   // ignore: unused_result
  //   Named(a: 42).copyWith(a: 42);
  //   // ignore: unused_result
  //   Named(a: null).copyWith(a: null);
  // });

  test('RequiredNamed', () async {
    await expectLater(compile(r'''
import 'nullable.dart';

void main() {
  RequiredNamed(a: 42).copyWith(a: 42);
}
'''), completes);

    await expectLater(compile(r'''
import 'nullable.dart';

void main() {
  RequiredNamed(a: null);
}

'''), throwsCompileError);

    await expectLater(compile(r'''
import 'nullable.dart';

void main() {
  RequiredNamed();
}

'''), throwsCompileError);

    await expectLater(compile(r'''
import 'nullable.dart';

void main() {
  RequiredNamed(a: 42).copyWith(a: null);
}
'''), throwsCompileError);
  });

  // test('NullableRequiredNamed', () {
  //   // ignore: unused_result
  //   NullableRequiredNamed(a: 42).copyWith(a: 42);
  //   // ignore: unused_result
  //   NullableRequiredNamed(a: null).copyWith(a: null);
  // });
}
