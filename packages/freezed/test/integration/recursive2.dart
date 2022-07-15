import 'package:freezed_annotation/freezed_annotation.dart';
import 'recursive.dart';
export 'recursive.dart';

part 'recursive2.freezed.dart';

@freezed
class B with _$B {
  factory B({A? parent}) = _B;
}
