import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

part 'implements_decorator.freezed.dart';

@freezed
abstract class SimpleImplements with _$SimpleImplements {
  const factory SimpleImplements.person(String name, int age) = SimplePerson;

  @Implements.fromString('AdministrativeArea<House>')
  const factory SimpleImplements.street(String name) = SimpleStreet;

  @Implements(GeographicArea)
  const factory SimpleImplements.city(String name, int population) = SimpleCity;
}

@freezed
abstract class CustomMethodImplements implements _$CustomMethodImplements {
  const CustomMethodImplements._();

  const factory CustomMethodImplements.person(String name, int age) =
      PersonCustomMethod;

  @Implements.fromString('AdministrativeArea<House>')
  const factory CustomMethodImplements.street(String name) = StreetCustomMethod;

  @Implements(GeographicArea)
  const factory CustomMethodImplements.city(String name, int population) =
      CityCustomMethod;

  void function() {}
}

class GeographicArea {}

class AdministrativeArea<T> {}

class House {}
