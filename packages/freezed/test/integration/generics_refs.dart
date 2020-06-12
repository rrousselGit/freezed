import 'package:freezed_annotation/freezed_annotation.dart';

part 'generics_refs.freezed.dart';

@freezed
abstract class FApp with _$FApp {
  factory FApp({Header head, List<Page> pages}) = _FApp;
}

@freezed
abstract class WidgetType with _$WidgetType {
  const factory WidgetType.page({Body body, Header header}) = Page;
  const factory WidgetType.body() = Body;
  const factory WidgetType.header({String title}) = Header;
}
