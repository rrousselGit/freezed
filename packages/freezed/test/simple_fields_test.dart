import 'package:test/test.dart';

import 'integration/simple_fields.dart';

void main() {
  group('Simple', () {
    test('toString', () {
      final value = Simple(foo: 42, bar: '42');

      expect(value.toString(), 'Simple#${value.hashCode}(foo: 42, bar: 42)');
    });

    test('copyWith', () {
      final value = Simple(foo: 42, bar: '42');

      expect(value.copyWith(foo: 21), Simple(foo: 21, bar: '42'));
      expect(value.copyWith(bar: '21'), Simple(foo: 42, bar: '21'));
    });

    test('==', () {
      final value = Simple(foo: 42, bar: '42');

      expect(value, Simple(foo: 42, bar: '42'));
      expect(value, isNot(Simple(foo: 21, bar: '42')));
      expect(value, isNot(Simple(foo: 42, bar: '21')));
    });
  });

  test('Named', () {
    Named.custom(foo: 42);
  });
}
