import 'package:test/test.dart';

import 'integration/deep_copy.dart';

void main() {
  // TODO: no common property
  // TODO: nullable
  // TODO: from subclass offers unommon properties
  // TODO: property type safe
  // TODO: subclass is type safe too
  // TODO: generic
  // TODO: copyWith is identical to itself if don't have descendants
  // TODO: union copy
  // TODO: VeryDeep.first is generic
  // TODO: _VeryDeep and _Deep
  // TODO: private class have private copyWith
  // TODO: named parameters

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
      company.copyWith
          .director(assistant: Assistant(name: 'John Doe', age: 21)),
      Company(
        name: 'Google',
        director: Director(
          name: 'Larry Page',
          assistant: Assistant(name: 'John Doe', age: 21),
        ),
      ),
    );

    expect(
      company.copyWith.director.assistant(name: 'John Doe'),
      Company(
        name: 'Google',
        director: Director(
          name: 'Larry Page',
          assistant: Assistant(
            name: 'John Doe',
            age: 42,
          ),
        ),
      ),
    );
  });
}
