import 'package:freezed_annotation/freezed_annotation.dart';

import 'deep_copy.dart';

part 'deep_copy2.freezed.dart';

@freezed
class Country with _$Country {
  factory Country({
    String? name,
    Company? company,
    Director? president,
  }) = _Country;
}
