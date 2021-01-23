import 'package:freezed_annotation/freezed_annotation.dart';

part 'multiple_constructors.freezed.dart';

@freezed
abstract class NoCommonParam with _$NoCommonParam {
  const factory NoCommonParam(String a, {int? b}) = NoCommonParam0;
  const factory NoCommonParam.named(double c, [Object? d]) = NoCommonParam1;
}

@freezed
abstract class SharedParam with _$SharedParam {
  const factory SharedParam(String a, int b) = SharedParam0;
  const factory SharedParam.named(String a, int c) = SharedParam1;
}

@freezed
abstract class Complex with _$Complex {
  @Assert("a != ''", '"Hello"')
  const factory Complex(
    /// Hello
    String a,
  ) = Complex0;

  @Assert("a == ''")
  @Assert('b', 'b must be true')
  const factory Complex.first(
    /// World
    String a, {

    /// B
    bool? b,
    double? d,
  }) = Complex1;

  const factory Complex.second(
    String a, [

    /// C
    int? c,
    double? d,
  ]) = Complex2;
}

@freezed
abstract class SwitchTest with _$SwitchTest {
  const factory SwitchTest(String a) = SwitchTest0;
  const factory SwitchTest.first(String a, {bool? b, double? d}) = SwitchTest1;
  const factory SwitchTest.second(String a, [int? c, double? d]) = SwitchTest2;
}

@freezed
abstract class NoDefault with _$NoDefault {
  const factory NoDefault.first(String a) = NoDefault1;
  const factory NoDefault.second(String a) = NoDefault2;
}

@freezed
abstract class NameConflict with _$NameConflict {
  factory NameConflict.something(Error error) = Something;
  factory NameConflict.error(Error error) = SomeError;
}

@freezed
abstract class Recursive with _$Recursive {
  factory Recursive() = RecursiveImpl;
  factory Recursive.next(RecursiveImpl value) = _RecursiveNext;
}

@freezed
abstract class RequiredParams with _$RequiredParams {
  const factory RequiredParams({required String a}) = RequiredParams0;
  const factory RequiredParams.second({required String a}) = RequiredParams1;
}

@freezed
abstract class NestedList with _$NestedList {
  factory NestedList.shallow(List<LeafNestedListItem> children) =
      ShallowNestedList;
  factory NestedList.deep(List<InnerNestedListItem> children) = DeepNestedList;
}

@freezed
abstract class NestedListItem with _$NestedListItem {
  factory NestedListItem.leaf() = LeafNestedListItem;
  factory NestedListItem.inner(List<LeafNestedListItem> children) =
      InnerNestedListItem;
}

@freezed
abstract class NestedMap with _$NestedMap {
  factory NestedMap.shallow(Map<String, LeafNestedMapItem> children) =
      ShallowNestedMap;
  factory NestedMap.deep(Map<String, InnerNestedMapItem> children) =
      DeepNestedMap;
}

@freezed
abstract class NestedMapItem with _$NestedMapItem {
  factory NestedMapItem.leaf() = LeafNestedMapItem;
  factory NestedMapItem.inner(Map<String, LeafNestedMapItem> children) =
      InnerNestedMapItem;
}
