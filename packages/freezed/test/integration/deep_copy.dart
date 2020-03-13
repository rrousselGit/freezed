import 'package:freezed_annotation/freezed_annotation.dart';

part 'deep_copy.freezed.dart';

@freezed
abstract class Company with _$Company {
  factory Company({String name, Director director}) = _Company;
}

@freezed
abstract class Director with _$Director {
  factory Director({String name, Assistant assistant}) = _Director;
}

@freezed
abstract class Assistant with _$Assistant {
  factory Assistant({String name, int age}) = _Assistant;
}
