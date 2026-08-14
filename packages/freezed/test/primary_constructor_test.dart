import 'package:test/test.dart';

import 'integration/primary_constructor.dart';

void main() {
  group('Primary Constructor support', () {
    test(
      'standard primary constructor compiles and has copyWith / equality / toString',
      () {
        final a = Example(42, another: 10);
        expect(a.field, 42);
        expect(a.another, 10);

        final b = a.copyWith(field: 100);
        expect(b.field, 100);
        expect(b.another, 10);

        expect(a, isNot(equals(b)));
        expect(a, equals(Example(42, another: 10)));
        expect(a.toString(), 'Example(field: 42, another: 10)');
      },
    );

    test(
      'private primary constructor with body factory redirects compiles and works',
      () {
        final a = ExampleWithPrivate(10, another: 20);
        expect(a.field, 10);
        expect(a.another, 20);
        expect(a.getter, 20);

        final b = a.copyWith(another: null);
        expect(b.field, 10);
        expect(b.another, isNull);

        expect(a, isNot(equals(b)));
        expect(a, equals(ExampleWithPrivate(10, another: 20)));
        expect(a.toString(), 'ExampleWithPrivate(field: 10, another: 20)');
      },
    );
  });
}
