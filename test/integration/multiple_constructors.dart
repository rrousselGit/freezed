import 'package:meta/meta.dart';

part 'multiple_constructors.g.dart';

@immutable
abstract class NoCommonParam with _$NoCommonParam {
  const factory NoCommonParam(String a, {int b}) = NoCommonParam0;
  const factory NoCommonParam.named(double c, [Object d]) = NoCommonParam1;
}

@immutable
abstract class SharedParam with _$SharedParam {
  const factory SharedParam(String a, int b) = SharedParam0;
  const factory SharedParam.named(String a, int c) = SharedParam1;
}
