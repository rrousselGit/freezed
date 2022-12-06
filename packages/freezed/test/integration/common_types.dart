import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_types.freezed.dart';

@freezed
class UnionDeepCopy with _$UnionDeepCopy {
  factory UnionDeepCopy.first(CommonSuperSubtype value) = _UnionWrapperFirst;
  factory UnionDeepCopy.second(CommonSuperSubtype? value) = _UnionWrapperSecond;
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
