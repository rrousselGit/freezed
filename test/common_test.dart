import 'package:freezed/src/templates/prototypes.dart';
import 'package:test/test.dart';

void main() {
  test('concrete name parser', () {
    expect(
      redirectedConstructorName.stringMatch('MyClass() = \nhello;'),
      'hello;',
    );
    expect(
      redirectedConstructorName.stringMatch('MyClass() = hello;'),
      'hello;',
    );
    expect(
      redirectedConstructorName.stringMatch('MyClass() =hello;'),
      'hello;',
    );
    expect(
      redirectedConstructorName.stringMatch('MyClass() =\thello;'),
      'hello;',
    );
  });
}
