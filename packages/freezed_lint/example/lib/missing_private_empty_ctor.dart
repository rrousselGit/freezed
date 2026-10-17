import 'package:freezed_annotation/freezed_annotation.dart';

part 'missing_private_empty_ctor.freezed.dart';

@freezed
abstract class HasPrivateCtor with _$HasPrivateCtor {
  const HasPrivateCtor._();

  const factory HasPrivateCtor() = _HasPrivateCtor;

  void method() {
    print('hello world');
  }
}

@freezed
abstract class WithStaticElements with _$WithStaticElements {
  static String field = 'field';

  static String get accessor => 'accessor';

  static String method() => 'method';

  const factory WithStaticElements() = _WithStaticElements;
}
