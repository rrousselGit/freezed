import 'package:freezed_annotation/freezed_annotation.dart';

part 'generic.freezed.dart';

class Model<T> {
  Model(this.value);
  final T value;
}

@freezed
class AnyGeneric<T> with _$AnyGeneric<T> {
  factory AnyGeneric(T value) = _AnyGeneric<T>;
}

@freezed
class NullableGeneric<T extends Object?> with _$NullableGeneric<T> {
  factory NullableGeneric(T value) = _NullableGeneric<T>;
}

@freezed
class NonNullableGeneric<T extends Object> with _$NonNullableGeneric<T> {
  factory NonNullableGeneric(T value) = _NonNullableGeneric<T>;
}

@freezed
class Generic<T extends Model<dynamic>> with _$Generic<T> {
  factory Generic(T model) = _Generic<T>;
}

@freezed
class MultiGeneric<A, T extends Model<A>> with _$MultiGeneric<A, T> {
  factory MultiGeneric(T model) = _MultiGeneric<A, T>;
}

@freezed
class MultipleConstructors<A, B> with _$MultipleConstructors<A, B> {
  factory MultipleConstructors(bool flag) = Default<A, B>;
  factory MultipleConstructors.first(A a) = First<A, B>;
  factory MultipleConstructors.second(B b) = Second<A, B>;
}

@freezed
class Union<T> with _$Union<T> {
  const factory Union(T value) = Data<T>;
  const factory Union.loading() = Loading<T>;
  const factory Union.error([String? message]) = ErrorDetails<T>;
}

@freezed
class ComplexParameters<T> with _$ComplexParameters<T> {
  const factory ComplexParameters(List<T> value) = _ComplexParameters<T>;
}

@freezed
class Inner<I> with _$Inner<I> {
  const factory Inner({
    I? data,
  }) = _Inner<I>;
}

@freezed
class Outer with _$Outer {
  const factory Outer({
    Inner<int>? innerData,
  }) = _Outer;
}
