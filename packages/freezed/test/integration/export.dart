import 'export_freezed_annotation.dart';

part 'export.freezed.dart';

part 'export.g.dart';

@freezed
abstract class Export with _$Export {
  const factory Export(int a) = _Export;

  factory Export.fromJson(Map<String, dynamic> json) => _$ExportFromJson(json);
}
