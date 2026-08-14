import 'package:freezed_annotation/freezed_annotation.dart';

part 'primary_constructor.freezed.dart';

@freezed
class Example(@override final int field, {@override final int another = 0})
    with _$Example {}

@freezed
abstract class ExampleWithPrivate._() with _$ExampleWithPrivate {
  factory ExampleWithPrivate(int field, {int? another}) = _ExampleWithPrivate;

  int get getter => field * 2;
}
