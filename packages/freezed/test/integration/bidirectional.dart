import 'package:freezed_annotation/freezed_annotation.dart';

part 'bidirectional.freezed.dart';

@freezed
class Person with _$Person {
  factory Person({
    String? name,
    int? age,
    Appointment? appointment,
  }) = _Person;
}

@freezed
class Appointment with _$Appointment {
  factory Appointment({
    String? title,
    DateTime? date,
    Person? creator,
  }) = _Appointment;
}
