import 'package:freezed_annotation/freezed_annotation.dart';
import 'recursive2.dart';
export 'recursive2.dart';

part 'recursive.freezed.dart';

@freezed
class A with _$A {
  factory A({B? parent}) = _A;
}
