import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test/test.dart';

import 'integration/concrete.dart';
import 'integration/deep_copy.dart';
import 'integration/multiple_constructors.dart';

void main() {
  test('redirectedClassName', () {
    expect(
      const Complex(''),
      isA<$DebugFreezed>().having(
        (s) => s.$debugRedirectedClassName,
        '\$debugRedirectedClassName',
        'Complex0',
      ),
    );
    expect(
      const Complex.first(''),
      isA<$DebugFreezed>().having(
        (s) => s.$debugRedirectedClassName,
        '\$debugRedirectedClassName',
        'Complex1',
      ),
    );
    expect(
      const Complex.second(''),
      isA<$DebugFreezed>().having(
        (s) => s.$debugRedirectedClassName,
        '\$debugRedirectedClassName',
        'Complex2',
      ),
    );

    expect(
      const Const(42),
      isA<$DebugFreezed>().having(
        (s) => s.$debugRedirectedClassName,
        '\$debugRedirectedClassName',
        '_Const',
      ),
    );
  });
  test('debugToMap', () {
    final company = Company(
      name: 'Art',
      director: Director(
        name: 'Mona',
        assistant: Assistant(name: 'Lisa'),
      ),
    );

    expect(
      company,
      isA<$DebugFreezed>().having(
        (s) => s.$debugToMap(),
        '\$debugToMap',
        <String, Object>{
          'name': 'Art',
          'director': company.director,
        },
      ),
    );

    expect(
      company.director,
      isA<$DebugFreezed>().having(
        (s) => s.$debugToMap(),
        '\$debugToMap',
        <String, Object>{
          'name': 'Mona',
          'assistant': company.director.assistant,
        },
      ),
    );

    expect(
      company.director.assistant,
      isA<$DebugFreezed>().having(
        (s) => s.$debugToMap(),
        '\$debugToMap',
        <String, Object>{
          'name': 'Lisa',
          'age': null,
        },
      ),
    );
  });
}
