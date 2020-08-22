import 'package:test/test.dart';

import 'integration/nullable.dart';

final throwsAssertionError = throwsA(isA<AssertionError>());

void main() {
  test('RequiredPositional', () {
    RequiredPositional(42).copyWith(a: 42);
    expect(() => RequiredPositional(null), throwsAssertionError);
    expect(
        () => RequiredPositional(42).copyWith(a: null), throwsAssertionError);
  });

  test('DefaultPositional', () {
    DefaultPositional(42);
    DefaultPositional();
    expect(() => DefaultPositional(null), throwsAssertionError);
    expect(() => DefaultPositional(42).copyWith(a: null), throwsAssertionError);
  });

  test('DefaultNamed', () {
    DefaultNamed(a: 42);
    DefaultNamed();
    expect(() => DefaultNamed(a: null), throwsAssertionError);
    expect(() => DefaultNamed().copyWith(a: null), throwsAssertionError);
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

  test('RequiredNamed', () {
    RequiredNamed(a: 42).copyWith(a: 42);
    expect(() => RequiredNamed(a: null), throwsAssertionError);
    expect(() => RequiredNamed(a: 42).copyWith(a: null), throwsAssertionError);
  });

  test('NullableRequiredNamed', () {
    NullableRequiredNamed(a: 42).copyWith(a: 42);
    NullableRequiredNamed(a: null).copyWith(a: null);
  });
}
