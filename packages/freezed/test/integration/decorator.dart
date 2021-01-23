import 'package:freezed_annotation/freezed_annotation.dart';

part 'decorator.freezed.dart';

@freezed
abstract class Decorator with _$Decorator {
  factory Decorator({
    @deprecated @_WeirdDecorator('a', b: 0.42) String? a,
  }) = Decorator0;
}

class _WeirdDecorator {
  const _WeirdDecorator(
    this.a, {
    this.b,
  });

  final String a;
  final double? b;
}
