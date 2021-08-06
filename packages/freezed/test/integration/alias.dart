import 'concrete.dart' as concrete;
import 'export_freezed_annotation.dart';

part 'alias.freezed.dart';

@freezed
class Alias with _$Alias {
  @With(concrete.Mixin)
  @Implements(concrete.Empty)
  factory Alias([@Default(concrete.Empty()) concrete.Empty value]) = _Alias;
}
