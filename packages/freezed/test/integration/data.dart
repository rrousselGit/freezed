import 'package:freezed_annotation/freezed_annotation.dart';

part 'data.freezed.dart';

@unfreezed
abstract class Data with _$Data {
  factory Data(int a, final int b) = _Data;
}
