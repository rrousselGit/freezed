import 'package:freezed_annotation/freezed_annotation.dart';

import 'single_class_constructor.dart';

part 'multiple_constructors.freezed.dart';

@freezed
class FunctionParameter with _$FunctionParameter {
  factory FunctionParameter(
    int? Function(int?, {required int a, int b})? simpleNamed,
    int? Function(int?, [int b])? simplePositional,
    T? Function<T extends num>(T?)? generic,
    // Contains generated types from a different library
    List<ImplementsAliasFirst> Function(ImplementsAliasFirst a)?
        externalGenerated,
    // Contains generated  types from the same library
    List<ImplementsAliasFirst> Function(ImplementsAliasFirst a)? generated,
  ) = _FunctionParameter;

  factory FunctionParameter.second(
    int? simpleNamed(int? a, {required int b, int c})?,
    int? simplePositional(int? a, [int b]),
    T? generic<T extends num>(T? a)?,
    // Eternal genereration
    List<ImplementsAliasFirst> externalGenerated(ImplementsAliasFirst a)?,
    List<Something> generated(Something a)?,
  ) = _FunctionParameter2;
}

@unfreezed
class UnfreezedImmutableUnion with _$UnfreezedImmutableUnion {
  factory UnfreezedImmutableUnion(final String a) =
      DirectUnfreezedImmutableUnion;
  factory UnfreezedImmutableUnion.named(String a) =
      DirectUnfreezedImmutableUnionNamed;
}

@unfreezed
class UnfreezedImmutableUnion2 with _$UnfreezedImmutableUnion2 {
  factory UnfreezedImmutableUnion2(String a) = DirectUnfreezedImmutableUnion2;
  factory UnfreezedImmutableUnion2.named(final String a) =
      DirectUnfreezedImmutableUnionNamed2;
}

@unfreezed
class MutableUnion with _$MutableUnion {
  factory MutableUnion(String a, int b) = MutableUnion0;
  factory MutableUnion.named(String a, int c) = MutableUnion1;
}

@freezed
class DefaultValueNamedConstructor with _$DefaultValueNamedConstructor {
  factory DefaultValueNamedConstructor.a([@Default(42) int value]) =
      _ADefaultValueNamedConstructor;
  factory DefaultValueNamedConstructor.b([@Default(42) int value]) =
      _BDefaultValueNamedConstructor;
}

@freezed
class NamedDefaultValueNamedConstructor
    with _$NamedDefaultValueNamedConstructor {
  factory NamedDefaultValueNamedConstructor.a({@Default(42) int value}) =
      _BNamedDefaultValueNamedConstructor;

  factory NamedDefaultValueNamedConstructor.b({@Default(42) int value}) =
      _ANamedDefaultValueNamedConstructor;
}

@freezed
class NoCommonParam with _$NoCommonParam {
  const factory NoCommonParam(String a, {int? b}) = NoCommonParam0;
  const factory NoCommonParam.named(double c, [Object? d]) = NoCommonParam1;
}

// Regression test for https://github.com/rrousselGit/freezed/issues/358
@freezed
class Regression358 with _$Regression358 {
  const factory Regression358({
    required int number,
  }) = _Regression358;

  factory Regression358.withSpecificColor({int count = 2}) =>
      Regression358(number: count);
}

@freezed
class SharedParam with _$SharedParam {
  const factory SharedParam(String a, int b) = SharedParam0;
  const factory SharedParam.named(String a, int c) = SharedParam1;
}

@freezed
class Complex with _$Complex {
  @Assert("a != ''", '"Hello"')
  const factory Complex(
    /// Hello
    String a,
  ) = Complex0;

  @Assert("a == ''")
  @Assert('b == true', 'b must be true')
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
class SwitchTest with _$SwitchTest {
  const factory SwitchTest(String a) = SwitchTest0;
  const factory SwitchTest.first(String a, {bool? b, double? d}) = SwitchTest1;
  const factory SwitchTest.second(String a, [int? c, double? d]) = SwitchTest2;
}

@freezed
class NoDefault with _$NoDefault {
  const factory NoDefault.first(String a) = NoDefault1;
  const factory NoDefault.second(String a) = NoDefault2;
}

@freezed
class NameConflict with _$NameConflict {
  factory NameConflict.something(Error error) = Something;
  factory NameConflict.error(Error error) = SomeError;
}

@freezed
class Recursive with _$Recursive {
  factory Recursive() = RecursiveImpl;
  factory Recursive.next(RecursiveImpl value) = _RecursiveNext;
}

@freezed
class RecursiveWith$Dollar with _$RecursiveWith$Dollar {
  factory RecursiveWith$Dollar() = RecursiveWith$DollarImpl;
  factory RecursiveWith$Dollar.next(RecursiveWith$DollarImpl value) =
      _RecursiveWith$DollarNext;
}

@freezed
class RequiredParams with _$RequiredParams {
  const factory RequiredParams({required String a}) = RequiredParams0;
  const factory RequiredParams.second({required String a}) = RequiredParams1;
}

@Freezed(
  // We're relying twice on the generated freezed types, which isn't supported.
  // This breaks copyWith as it thinks both union cases have `children` as type `List<dynamic>`
  copyWith: false,
)
class NestedList with _$NestedList {
  factory NestedList.shallow(List<LeafNestedListItem> children) =
      ShallowNestedList;
  factory NestedList.deep(List<InnerNestedListItem> children) = DeepNestedList;
}

@freezed
class NestedListItem with _$NestedListItem {
  factory NestedListItem.leaf() = LeafNestedListItem;
  factory NestedListItem.inner(List<LeafNestedListItem> children) =
      InnerNestedListItem;
}

@Freezed(
  // We're relying twice on the generated freezed types, which isn't supported.
  // This breaks copyWith as it thinks both union cases have `children` as type `List<dynamic>`
  copyWith: false,
)
@freezed
class NestedMap with _$NestedMap {
  factory NestedMap.shallow(Map<String, LeafNestedMapItem> children) =
      ShallowNestedMap;
  factory NestedMap.deep(Map<String, InnerNestedMapItem> children) =
      DeepNestedMap;
}

@freezed
class NestedMapItem with _$NestedMapItem {
  factory NestedMapItem.leaf() = LeafNestedMapItem;
  factory NestedMapItem.inner(Map<String, LeafNestedMapItem> children) =
      InnerNestedMapItem;
}
