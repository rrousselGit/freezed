import 'package:freezed_annotation/freezed_annotation.dart';
import 'b.dart';

part 'a.freezed.dart';

@freezed
abstract class Regression399A with _$Regression399A {
  const factory Regression399A({required Regression399B? b}) = _Regression399A;
}

@freezed
abstract class GenericRegression399A<T> with _$GenericRegression399A<T> {
  const factory GenericRegression399A({required GenericRegression399B<T>? b}) =
      _GenericRegression399A<T>;
}
