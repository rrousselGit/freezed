import 'package:freezed_annotation/freezed_annotation.dart';

part 'sealed_non_generic.freezed.dart';

@freezed
sealed class SealedNonGeneric with _$SealedNonGeneric {
  const factory SealedNonGeneric.first(String data) = SealedNonGenericFirst;
  const factory SealedNonGeneric.second(String data) = SealedNonGenericSecond;
}
