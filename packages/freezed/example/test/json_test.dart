import 'package:example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Union toJson', () {
    expect(
      const Union(42).toJson(),
      <String, dynamic>{
        'custom-key': 'default',
        'value': 42,
      },
    );

    expect(
      const Union.loading().toJson(),
      <String, dynamic>{'custom-key': 'loading'},
    );
  });

  test('Union fromJson', () {
    expect(
      Union.fromJson(<String, dynamic>{
        'custom-key': 'default',
        'value': 42,
      }),
      const Union(42),
    );

    expect(
      Union.fromJson(<String, dynamic>{'custom-key': 'loading'}),
      const Union.loading(),
    );
  });
}
