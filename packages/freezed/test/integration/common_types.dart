import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_types.freezed.dart';

@freezed
class CommonSuperSubtype with _$CommonSuperSubtype {
  const factory CommonSuperSubtype(
    String a,
    int b,
    double c,
  ) = CommonSuperSubtype0;

  const factory CommonSuperSubtype.named(
    String? a,
    double b,
    num c,
  ) = CommonSuperSubtype1;
}

class CommonInterface {
  const CommonInterface();
}

class CommonInterfaceA implements CommonInterface {
  const CommonInterfaceA();
}

class CommonInterfaceB implements CommonInterfaceA {
  const CommonInterfaceB();
}

class CommonInterfaceC implements CommonInterface {
  const CommonInterfaceC();
}

@freezed
class CommonInterfaceSupertype with _$CommonInterfaceSupertype {
  const factory CommonInterfaceSupertype(
    CommonInterfaceA param,
  ) = CommonInterfaceSupertype0;

  const factory CommonInterfaceSupertype.one(
    CommonInterfaceB param,
  ) = CommonInterfaceSupertype1;

  const factory CommonInterfaceSupertype.two(
    CommonInterfaceC param,
  ) = CommonInterfaceSupertype2;
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
