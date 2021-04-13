import 'package:generic_argument_factory_integration/models.dart';
import 'package:test/test.dart';

void main() {
  test('toJson', () {
    expect(
      Either<int, String>.first(42).toJson(
        (value) => value,
        (value) => value,
      ),
      {
        'type': 'first',
        'value': 42,
      },
    );

    expect(
      Either<int, String>.second('hello world').toJson(
        (value) => value,
        (value) => value,
      ),
      {
        'type': 'first',
        'value': 'hello world',
      },
    );
  });

  test('fromJson', () {
    expect(
      Either<int, String>.fromJson(
        {'type': 'first', 'value': 42},
        (Object? value) => value as int,
        (Object? value) => value.toString(),
      ),
      Either<int, String>.first(42),
    );

    expect(
      Either<int, String>.fromJson(
        {'type': 'second', 'value': 'hello world'},
        (Object? value) => value as int,
        (Object? value) => value.toString(),
      ),
      Either<int, String>.second('hello world'),
    );
  });
}
