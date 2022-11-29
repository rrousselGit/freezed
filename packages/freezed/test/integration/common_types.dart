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
class CommonTypeNested with _$CommonTypeNested {
  const factory CommonTypeNested.one({required int a}) = CommonTypeNestedOne;
  const factory CommonTypeNested.two({required num a}) = CommonTypeNestedTwo;
}

@freezed
class CommonTypeNestedContainer with _$CommonTypeNestedContainer {
  const factory CommonTypeNestedContainer({
    required CommonTypeNested internal,
  }) = _CommonTypeNestedContainer;
}

@unfreezed
class CommonUnfreezed with _$CommonUnfreezed {
  factory CommonUnfreezed.one({required int a, required double b}) =
      CommonUnfreezedOne;
  factory CommonUnfreezed.two({required num a, required double b}) =
      CommonUnfreezedTwo;
}
