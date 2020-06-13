import 'package:test/test.dart';

import 'integration/implements_decorator.dart';

void main() {
  group('Simple', () {
    test('fromString', () {
      expect(
        const SimpleImplements.street('Sarah'),
        isA<AdministrativeArea<House>>(),
      );
    });
    test('fromType', () {
      var object = const SimpleImplements.city('Morning', 140000);
      expect(object, isA<House>());

      object = const SimpleImplements.country('Morning', 140000);
      expect(object, isA<House>());
      expect(object, isA<GeographicArea>());
    });
  });
  group('CustomMethod', () {
    test('fromString', () {
      const object = CustomMethodImplements.street('Sarah');
      expect(object, isA<Shop>());
    });
    test('mixedFromStringWithFromType', () {
      const object = CustomMethodImplements.street('Sarah');
      expect(object, isA<Shop>());
      expect(object, isA<AdministrativeArea<House>>());
    });
    test('mixedWithAndImplements', () {
      const object = CustomMethodImplements.city('Morning', 140000);
      expect(object, isA<House>());
      expect(object, isA<GeographicArea>());
    });
  });
  group('Generic type', () {
    test('fromString', () {
      expect(
        const GenericImplements<int>.street('Sarah', 5),
        isA<AdministrativeArea<int>>(),
      );
      expect(
        const GenericImplements<String>.street('Sarah', '5'),
        isA<AdministrativeArea<String>>(),
      );
    });
    test('fromType', () {
      const object = GenericImplements<int>.city('Morning', 140000);
      expect(object, isA<House>());
      expect(object, isA<GeographicArea>());
    });
  });
}
