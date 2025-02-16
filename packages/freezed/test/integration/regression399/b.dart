import 'package:freezed_annotation/freezed_annotation.dart';

part 'b.freezed.dart';

@freezed
abstract class Regression399B with _$Regression399B {
  const factory Regression399B() = Regression399BImpl;
}

@freezed
abstract class GenericRegression399B<T> with _$GenericRegression399B<T> {
  const factory GenericRegression399B() = GenericRegression399BImpl<T>;
}
