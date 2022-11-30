import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_types.freezed.dart';

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
