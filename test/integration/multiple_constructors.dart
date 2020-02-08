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

@immutable
abstract class Complex with _$Complex {
  const factory Complex(String a) = Complex0;
  const factory Complex.first(String a, {bool b, double d}) = Complex1;
  const factory Complex.second(String a, [int c, double d]) = Complex2;
}

@immutable
abstract class NoDefault with _$NoDefault {
  const factory NoDefault.first(String a) = NoDefault1;
  const factory NoDefault.second(String a) = NoDefault2;
}
