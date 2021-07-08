// @dart=2.9

import 'package:example/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

void main() {
  test('Union toJson', () {
    expect(
      const Union(42).toJson(),
      <String, dynamic>{
        'custom-key': 'Default',
        'value': 42,
      },
    );

    expect(
      const Union.loading().toJson(),
      <String, dynamic>{'custom-key': 'Loading'},
    );
  });

  test('Union fromJson', () {
    expect(
      Union.fromJson(<String, dynamic>{
        'custom-key': 'Default',
        'value': 42,
      }),
      const Union(42),
    );

    expect(
      Union.fromJson(<String, dynamic>{'custom-key': 'Loading'}),
      const Union.loading(),
    );
  });

  test('Union fromJson with invalid union type value', () {
    final json = <String, dynamic>{'custom-key': 'InvalidValue'};
    void deserialize() => Union.fromJson(json);
    expect(deserialize, throwsA(isA<CheckedFromJsonException>()));
    try {
      deserialize();
    } on CheckedFromJsonException catch (e) {
      expect(e.key, 'custom-key');
      expect(e.map, json);
      expect(e.className, 'Union');
    }
  });
}
