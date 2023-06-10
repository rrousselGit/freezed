import 'package:freezed_annotation/freezed_annotation.dart';

part 'equal.freezed.dart';

@freezed
class Simple with _$Simple {
  factory Simple(int value) = _Simple;
}
