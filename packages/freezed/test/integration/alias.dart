import 'export_empty.dart' as concrete;
import 'export_freezed_annotation.dart';
import 'generic.dart' show Model;

part 'alias.freezed.dart';

@freezed
class Alias with _$Alias {
  @With(concrete.Mixin)
  @Implements(concrete.Empty)
  factory Alias([
    @Default(concrete.Empty()) concrete.Empty value,
    int? a,
    Model<int>? b,
  ]) = _Alias;
}
