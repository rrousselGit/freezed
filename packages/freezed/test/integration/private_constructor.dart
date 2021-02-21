import 'package:freezed_annotation/freezed_annotation.dart';

part 'private_constructor.freezed.dart';

@freezed
class PrivateConstructor with _$PrivateConstructor {
  const factory PrivateConstructor(String name) = _PrivateConstructor;
  factory PrivateConstructor.union1(String name, int count) = Union1;
  const PrivateConstructor._();

  factory PrivateConstructor.illegal() => const PrivateConstructor._();
}
