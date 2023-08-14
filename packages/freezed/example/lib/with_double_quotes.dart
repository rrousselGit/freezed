import 'package:freezed_annotation/freezed_annotation.dart';

part 'with_double_quotes.freezed.dart';

@freezed
class WithDoubleQuotes with _$WithDoubleQuotes {
  @Assert('false', "This assertion isn't really useful!")
  const factory WithDoubleQuotes() = _WithDoubleQuotes;
}
