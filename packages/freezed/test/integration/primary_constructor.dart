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

@freezed
class Child(final int value) with _$Child {}

@freezed
// ignore: avoid_unused_constructor_parameters
class Holder(Child child) with _$Holder {}

@freezed
class PrimaryWithGetter(final String name) with _$PrimaryWithGetter {
  int get nameLength => name.length;
}

abstract class ParentBase {
  const ParentBase(this.parentField);
  final int parentField;
}

@freezed
class SubclassWithSuper(super.parentField, final String subField)
    extends ParentBase
    with _$SubclassWithSuper {}

@freezed
sealed class const PrimaryUnion._() with _$PrimaryUnion {
  const factory PrimaryUnion.first(int common, String firstValue) =
      PrimaryUnionFirst;
  const factory PrimaryUnion.second(int common, int secondValue) =
      PrimaryUnionSecond;
}

@freezed
sealed class const PatternWithDefault() with _$PatternWithDefault {}

@freezed
class NullableThis(this.value) with _$NullableThis {
  final int? value;
}

class NullableParent {
  NullableParent(this.value);
  final int? value;
}

@freezed
class NullableSuper(super.value) extends NullableParent with _$NullableSuper {}

@freezed
// ignore: avoid_unused_constructor_parameters
class OptionalPositionalGap([int ignored = 0, final int value = 1])
    with _$OptionalPositionalGap {}

@freezed
class PrimaryNested(final Child child, {final Child? optionalChild})
    with _$PrimaryNested {}

@freezed
sealed class const PrimaryFieldsUnion._(final int common)
    with _$PrimaryFieldsUnion {
  const factory PrimaryFieldsUnion.first(int common, String value) =
      PrimaryFieldsUnionFirst;
  const factory PrimaryFieldsUnion.second(int common, int value) =
      PrimaryFieldsUnionSecond;

  int get doubled => common * 2;
}

class UnstoredParent {
  // ignore: avoid_unused_constructor_parameters
  UnstoredParent({int ignored = 0});
}

@freezed
class OptionalUnstoredSuper(final int value, {super.ignored})
    extends UnstoredParent
    with _$OptionalUnstoredSuper {}

@freezed
// ignore: avoid_unused_constructor_parameters
class NullablePositionalGap([int? ignored, final String value = 'default'])
    with _$NullablePositionalGap {}

class PositionalDefaultParent {
  PositionalDefaultParent([int ignored = 7]) : received = ignored;

  final int received;
}

@freezed
class InheritedPositionalDefault([super.ignored, final int value = 1])
    extends PositionalDefaultParent
    with _$InheritedPositionalDefault {}

@freezed
class OverriddenPositionalDefault([super.ignored = 9, final int value = 1])
    extends PositionalDefaultParent
    with _$OverriddenPositionalDefault {}
