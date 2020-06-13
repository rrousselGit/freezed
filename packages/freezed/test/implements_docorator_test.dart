import 'package:test/test.dart';

import 'integration/implements_decorator.dart';

void main() {
  group('Simple', () {
    test('fromString', () {
      final house = House();

      expect(
        const SimpleImplements.street('Sarah'),
        isA<AdministrativeArea<House>>()
            .having((s) => s.method(house), 'method(house)', house),
      );
    });
    test('fromType', () {
      var object = const SimpleImplements.city('Morning', 140000);
      expect(object, isA<House>());

      object = const SimpleImplements.country('Morning', 140000);
      expect(object, isA<House>());
      expect(object,
          isA<GeographicArea>().having((s) => s.name, 'name', 'Morning'));
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
      expect(object,
          isA<GeographicArea>().having((s) => s.name, 'name', 'Morning'));
    });
    test(
        'redirected class can be assigned to the interfaces/mixins without cast',
        () {
      const city = CityCustomMethod('name', 42);

      // ignore: unused_local_variable
      House house = city;
      Named named = city;
      expect(named.name, 'name');
      GeographicArea area = city;
      expect(area.name, 'name');
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
      expect(object,
          isA<GeographicArea>().having((s) => s.name, 'name', 'Morning'));
    });
  });
}
