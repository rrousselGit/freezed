import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

@freezed
class Either<First, Second> with _$Either<First, Second> {
  factory Either.first(First value) = _EitherFirst;
  factory Either.second(Second value) = _EitherSecond;

  factory Either.fromJson(
    Map<String, Object?> json,
    // fromJson must include one function per generic type.
    // This function takes an Object and should convert the object into a valid value.
    First Function(Object?) fromJsonFirst,
    Second Function(Object?) fromJsonSecond,
  ) =>
      _$EitherFromJson(json, fromJsonFirst, fromJsonSecond);

  // Map<String, dynamic> toJson(
  //   Object Function(First) toJsonFirst,
  //   Object Function(Second) toJsonSecond,
  // );
}

@freezed
class Another with _$Another {
  factory Another(Either<int, String> value) = _Another;

  factory Another.fromJson(Map<String, Object?> json) =>
      _$AnotherFromJson(json);
}
