import 'package:freezed_annotation/freezed_annotation.dart';

part 'sealed_generic.freezed.dart';

@freezed
sealed class SealedGeneric<T> with _$SealedGeneric<T> {
  const factory SealedGeneric.first(T data) = SealedGenericFirst<T>;
  const factory SealedGeneric.second(T data) = SealedGenericSecond<T>;
}
