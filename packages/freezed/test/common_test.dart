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
  test('functions as parameters', () {
    expect(
      getRedirectedConstructorName('MyClass(void cb(void cb2())) = \nhello;'),
      'hello',
    );
  });
  test('concrete name parser', () {
    expect(
      getRedirectedConstructorName('MyClass() = \nhello;'),
      'hello',
    );
    expect(
      getRedirectedConstructorName('MyClass() = hello;'),
      'hello',
    );
    expect(
      getRedirectedConstructorName('MyClass() =hello;'),
      'hello',
    );
    expect(
      getRedirectedConstructorName('MyClass() =\thello;'),
      'hello',
    );
    expect(
      getRedirectedConstructorName('''SecondState({
    String dateTime,
    String uuid,
  }) = A;'''),
      'A',
    );
  });
  test('generic ctor', () {
    expect(
      getRedirectedConstructorName('MyClass() =\thello<A, B>;'),
      'hello',
    );
    expect(
      getRedirectedConstructorName('MyClass() =\thello<A>;'),
      'hello',
    );
    expect(
      getRedirectedConstructorName(
          'ComplexParameters(List<T> value) = _ComplexParameters<T>;'),
      '_ComplexParameters',
    );
    expect(
      getRedirectedConstructorName(
          'PositionalMixedParam(String a, [int b]) = WhateverPositionalMixedParam;'),
      'WhateverPositionalMixedParam',
    );
  });
  test('factory ctor', () {
    expect(
      getRedirectedConstructorName(
          '''factory SleekButtonThemeData.fromTheme(ThemeData theme) {
    final textStyle = theme.textTheme.button;
    var iconTheme = theme.iconTheme ??
        IconThemeData(
          opacity: 1.0,
        );
    if (iconTheme.size == null) {
      iconTheme = iconTheme.copyWith(
        size: textStyle.fontSize * 1.5,
      );
    }
    return SleekButtonThemeData(
      fill: theme.accentColor,
      textStyle: textStyle,
      iconTheme: iconTheme,
      cornerRadius: 4.0,
      borderWidth: 1.0,
      padding: textStyle.fontSize * 1.3,
    );
  }'''),
      isNull,
    );

    expect(
      getRedirectedConstructorName(
          "factory Example.fixed() => Example('a', b: 42);"),
      isNull,
    );
    expect(
      getRedirectedConstructorName("""
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
      getRedirectedConstructorName('''Document.parse(VisionText visionText) {
    final personMatch = RegExp(
      r'^Dear\s+.+?\s+(\w+)\s+(\w+)',
      caseSensitive: false,
      multiLine: true,
    ).firstMatch(visionText.text);

    DocumentPerson person;
    if (personMatch != null) {
      person = DocumentPerson(
        firstName: personMatch,
        lastName: personMatch.group(2),
      );
    }

    return Document(person: person);
  }'''),
      isNull,
    );
  });
}
