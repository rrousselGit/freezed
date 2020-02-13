import 'package:freezed/src/templates/prototypes.dart';
import 'package:test/test.dart';

void main() {
  test('concrete name parser', () {
    expect(
      redirectedConstructorNameRegexp
          .firstMatch('MyClass() = \nhello;')
          .group(1),
      'hello',
    );
    expect(
      redirectedConstructorNameRegexp.firstMatch('MyClass() = hello;').group(1),
      'hello',
    );
    expect(
      redirectedConstructorNameRegexp.firstMatch('MyClass() =hello;').group(1),
      'hello',
    );
    expect(
      redirectedConstructorNameRegexp
          .firstMatch('MyClass() =\thello;')
          .group(1),
      'hello',
    );
  });
  test('generic ctor', () {
    expect(
      redirectedConstructorNameRegexp
          .firstMatch('MyClass() =\thello<A, B>;')
          .group(1),
      'hello',
    );
    expect(
      redirectedConstructorNameRegexp
          .firstMatch('MyClass() =\thello<A>;')
          .group(1),
      'hello',
    );
    expect(
      redirectedConstructorNameRegexp
          .firstMatch(
              'ComplexParameters(List<T> value) = _ComplexParameters<T>;')
          .group(1),
      '_ComplexParameters',
    );
    expect(
      redirectedConstructorNameRegexp
          .firstMatch(
              'PositionalMixedParam(String a, [int b]) = WhateverPositionalMixedParam;')
          .group(1),
      'WhateverPositionalMixedParam',
    );
  });
  test('factory ctor', () {
    expect(
      redirectedConstructorNameRegexp
          .firstMatch("factory Example.fixed() => Example('a', b: 42);"),
      isNull,
    );
    expect(
      redirectedConstructorNameRegexp.firstMatch("""
factory Example.fixed() {
    return const Example('a', b: 42);
  }
}

@freezed
abstract class NoConst with _\$NoConst {
  const factory NoConst() = NoConstImpl;
}"""),
      isNull,
    );
  });
}
