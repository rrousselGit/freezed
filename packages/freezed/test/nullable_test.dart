// ignore_for_file: unused_result

import 'package:test/test.dart';

import 'common.dart';
import 'integration/nullable.dart';

final throwsAssertionError = throwsA(isA<AssertionError>());

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

  test('NullableRequiredPositional', () {
    NullableRequiredPositional(42).copyWith(a: 42);
    NullableRequiredPositional(null).copyWith(a: null);
  });

  test('Positional', () {
    Positional(42).copyWith(a: 42);
    Positional(null).copyWith(a: null);
  });

  test('Named', () {
    Named(a: 42).copyWith(a: 42);
    Named(a: null).copyWith(a: null);
  });

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

  test('NullableRequiredNamed', () {
    NullableRequiredNamed(a: 42).copyWith(a: 42);
    NullableRequiredNamed(a: null).copyWith(a: null);
  });
}
