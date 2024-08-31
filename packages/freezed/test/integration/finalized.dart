import 'package:freezed_annotation/freezed_annotation.dart';

part 'finalized.freezed.dart';

@freezed
sealed class FinalizedFoo with _$FinalizedFoo {
  factory FinalizedFoo() = _FinalizedFoo;
}

@freezed
sealed class FinalizedBar with _$FinalizedBar {
  factory FinalizedBar() = _FinalizedBar;
}

@freezed
sealed class FinalizedMultiple with _$FinalizedMultiple {
  factory FinalizedMultiple.a() = FinalizedMultipleA;
  factory FinalizedMultiple.b() = FinalizedMultipleB;
  factory FinalizedMultiple.c() = FinalizedMultipleC;
}
