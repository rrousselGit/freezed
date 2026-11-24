import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'diagnostics.freezed.dart';

@freezed
abstract class DiagnosticsExample with _$DiagnosticsExample {
  const factory DiagnosticsExample({int? value}) = _DiagnosticsExample;
}

@freezed
abstract class DiagnosticsDollar with _$DiagnosticsDollar {
  const factory DiagnosticsDollar({required String $id, required String id}) =
      _DiagnosticsDollar;
}
