import 'package:freezed_annotation/freezed_annotation.dart';

part 'primary_constructor.freezed.dart';

@freezed
class Example(final int field, {final int another = 0}) with _$Example {}

@freezed
abstract class ExampleWithPrivate._() with _$ExampleWithPrivate {
  factory ExampleWithPrivate(int field, {int? another}) = _ExampleWithPrivate;

  int get getter => field * 2;
}

@freezed
class Generic<T>(final List<T> field, {final Set<T> another = const {}})
    with _$Generic<T> {}

@freezed
// ignore: avoid_unused_constructor_parameters, that's the point of the test
class ExampleWithoutVarOrFinal(int field, {int another = 0})
    with _$ExampleWithoutVarOrFinal {}

@unfreezed
class ExampleWithVar(var int field, {var int another = 0})
    with _$ExampleWithVar {}

@freezed
class ExampleWithThis(this.field, {this.another = 0}) with _$ExampleWithThis {
  final int field;
  final int another;
}
