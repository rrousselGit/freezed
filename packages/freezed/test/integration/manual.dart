import 'package:freezed_annotation/freezed_annotation.dart';

part 'manual.freezed.dart';

@freezed
class ManualWithBothDefault with _$ManualWithBothDefault {
  ManualWithBothDefault(int this.a) : b = null;
  ManualWithBothDefault._(String this.b) : a = null;

  final int? a;
  final String? b;
}

@freezed
class ManualWithPrivateDefault with _$ManualWithPrivateDefault {
  ManualWithPrivateDefault._(int this.a) : b = null;
  ManualWithPrivateDefault.b(String this.b) : a = null;

  final int? a;
  final String? b;
}

@freezed
class ManualWithDefault with _$ManualWithDefault {
  ManualWithDefault(int this.a) : b = null;
  ManualWithDefault.b(String this.b) : a = null;

  final int? a;
  final String? b;
}

@freezed
class ManualWithoutDefault with _$ManualWithoutDefault {
  ManualWithoutDefault.a(int this.a) : b = null;
  ManualWithoutDefault.b(String this.b) : a = null;

  final int? a;
  final String? b;
}
