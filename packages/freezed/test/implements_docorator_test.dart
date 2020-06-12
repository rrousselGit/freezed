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
      expect(
        const SimpleImplements.city('Morning', 140000),
        isA<GeographicArea>(),
      );
    });
  });
  group('CustomMethod', () {
    test('fromString', () {
      expect(
        const CustomMethodImplements.street('Sarah'),
        isA<AdministrativeArea<House>>(),
      );
    });
    test('fromType', () {
      expect(
        const CustomMethodImplements.city('Morning', 140000),
        isA<GeographicArea>(),
      );
    });
  });
}
