import 'package:freezed_annotation/freezed_annotation.dart';

part 'generics_refs.freezed.dart';

@freezed
class PageList with _$PageList {
  factory PageList(List<Page> pages) = _PageList;
}

@freezed
class PageMap with _$PageMap {
  factory PageMap(Map<String, Page> pages) = _PageMap;
}

@freezed
class WidgetType with _$WidgetType {
  const factory WidgetType.page() = Page;
}
