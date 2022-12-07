import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_types.freezed.dart';

@freezed
class Union with _$Union {
  factory Union.foo({int? arg}) = _UnionFoo;
  factory Union.bar({required int arg}) = _UnionBar;
}

@freezed
class Union2 with _$Union2 {
  factory Union2.foo({required int arg}) = _Union2Foo;
  factory Union2.bar({double? arg}) = _Union2Bar;
}

@freezed
class Union3 with _$Union3 {
  factory Union3.bar({double? arg}) = _Union3Bar;
  factory Union3.foo({required int arg}) = _Union3Foo;
}

@freezed
class Union4 with _$Union4 {
  factory Union4.eventOne({
    required int count,
    required String? id,
    required String? name,
  }) = Union4One;

  factory Union4.eventTwo({
    required int? count,
    required String id,
    required String name,
  }) = Union4Two;
}

@freezed
class Union5 with _$Union5 {
  factory Union5.first(int value) = _Union5First;
  factory Union5.second(double? value) = _Union5Second;
  factory Union5.third(String value) = _Union5Third;
}

@freezed
class UnionDeepCopy with _$UnionDeepCopy {
  factory UnionDeepCopy.first(CommonSuperSubtype value42) = _UnionWrapperFirst;
  factory UnionDeepCopy.second(CommonSuperSubtype? value42) =
      _UnionWrapperSecond;
}

@freezed
class Check with _$Check {
  factory Check.first({required dynamic value}) = _CheckFirst; // NOT OK
  factory Check.second({required int value}) = _CheckSecond; // OK
  factory Check.third({required double value}) = _CheckThird; // OK
  factory Check.fourth({required dynamic value}) = _CheckFourth; // OK
}

@freezed
class CommonSuperSubtype with _$CommonSuperSubtype {
  const factory CommonSuperSubtype({
    required int nullabilityDifference,
    required int typeDifference,
    String? unknown,
  }) = CommonSuperSubtype0;

  const factory CommonSuperSubtype.named({
    required int? nullabilityDifference,
    required double typeDifference,
  }) = CommonSuperSubtype1;
}

@freezed
class DeepCopySharedProperties with _$DeepCopySharedProperties {
  const factory DeepCopySharedProperties(CommonSuperSubtype value) =
      _DeepCopySharedProperties;
}

@unfreezed
class CommonUnfreezed with _$CommonUnfreezed {
  factory CommonUnfreezed.one({required int a, required double b}) =
      CommonUnfreezedOne;
  factory CommonUnfreezed.two({required num a, required double b}) =
      CommonUnfreezedTwo;
}

// Checking that the constructor order does not matter
@unfreezed
class CommonUnfreezed2 with _$CommonUnfreezed2 {
  factory CommonUnfreezed2.two({required num a, required double b}) =
      CommonUnfreezedTwo2;
  factory CommonUnfreezed2.one({required int a, required double b}) =
      CommonUnfreezedOne2;
}
