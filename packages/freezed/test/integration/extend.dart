import 'package:freezed_annotation/freezed_annotation.dart';

part 'extend.freezed.dart';

class Base {
  const Base.named(this.value);
  final int value;
}

@freezed
abstract class Subclass extends Base with _$Subclass {
  const Subclass._(super.value) : super.named();
  const factory Subclass(int value) = _Subclass;
}
