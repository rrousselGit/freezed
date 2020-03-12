// ignore_for_file: prefer_const_constructors, omit_local_variable_types
import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'common.dart';
import 'integration/deep_copy.dart';

void main() {
  // TODO: no common property
  // TODO: nullable
  // TODO: type safe
  // TODO: from subclass offers unommon properties
  // TODO: subclass is type safe
  // TODO: generic
  test('VeryDeep', () {
    final veryDeep = VeryDeep(Deep(Simple(42, '42'), 42), 42);

    expect(
      veryDeep.copyWith(first: Deep(Simple(21, '21'), 21)),
      VeryDeep(Deep(Simple(21, '21'), 21), 42),
    );

    expect(
      veryDeep.copyWith.first(first: Simple(21, '21'), second: 21),
      VeryDeep(Deep(Simple(21, '21'), 21), 42),
    );

    expect(
      veryDeep.copyWith.first.first(first: 21, second: '21'),
      VeryDeep(Deep(Simple(21, '21'), 42), 42),
    );
  });

  test('Deep', () {
    final deep = Deep(Simple(42, '42'), 42);

    expect(
      deep.copyWith(first: Simple(21, '21')),
      Deep(Simple(21, '21'), 21),
    );

    expect(
      deep.copyWith.first(first: 21, second: '21'),
      Deep(Simple(21, '21'), 21),
    );
  });

test('Company', () {
  final company = Company(
    name: 'Google',
    director: Director(
      name: 'Larry Page',
      assistant: Assistant(name: 'John Smith', age: 42),
    ),
  );

  expect(
    company.copyWith(name: 'Kin and Carta'),
    Company(name: 'Kin and Carta', director: company.director),
  );

  expect(
    company.copyWith.director(name: 'Sundar Pichai'),
    Company(
      name: 'Google',
      director: Director(
        name: 'Sundar Pichai',
        assistant: company.director.assistant,
      ),
    ),
  );

  expect(
    company.copyWith.director.assistant(name: 'John Doe'),
    Company(
      name: 'Google',
      director: Director(
        name: 'Sundar Pichai',
        assistant: Assistant(
          name: 'John Doe',
          age: 42,
        ),
      ),
    ),
  );
});

  // test('simple', () {
  //   final simple = Simple(42, '42');

  //   expect(
  //     simple.copyWith.first(21),
  //     Simple(21, '42'),
  //   );
  //   expect(
  //     simple.copyWith.second('21'),
  //     Simple(42, '21'),
  //   );
  // });
  // test('simple with null', () {
  //   final simple = Simple(null, null);

  //   expect(
  //     simple.copyWith.first(21),
  //     Simple(21, null),
  //   );
  //   expect(
  //     simple.copyWith.second('21'),
  //     Simple(null, '21'),
  //   );
  // });
}
