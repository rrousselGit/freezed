import 'package:freezed/src/freezed_generator.dart';
import 'package:freezed/src/templates/prototypes.dart';
import 'package:test/test.dart';

void main() {
  test('getter parser', () {
    expect(parseLateGetterSource(' => 42;'), '42');
    expect(
      parseLateGetterSource('''=> values.where((value) {
        if (value > 0)
          return true;
        else
          return false;
      });
}'''),
      '''values.where((value) {
        if (value > 0)
          return true;
        else
          return false;
      })''',
    );
  });
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
    expect(
      redirectedConstructorNameRegexp.firstMatch('''SecondState({
    String dateTime,
    String uuid,
  }) = A;''').group(1),
      'A',
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

    expect(
      redirectedConstructorNameRegexp
          .firstMatch('''Document.parse(VisionText visionText) {
    final personMatch = RegExp(
      r'^Dear\s+.+?\s+(\w+)\s+(\w+)',
      caseSensitive: false,
      multiLine: true,
    ).firstMatch(visionText.text);

    DocumentPerson person;
    if (personMatch != null) {
      person = DocumentPerson(
        firstName: personMatch.group(1),
        lastName: personMatch.group(2),
      );
    }

    return Document(person: person);
  }'''),
      isNull,
    );
  });
}
