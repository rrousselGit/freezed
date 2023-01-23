import 'package:freezed_annotation/freezed_annotation.dart';

part 'missing_private_empty_ctor.freezed.dart';

@freezed
// expect_lint: freezed_missing_private_empty_constructor
class RequiresPrivateCtor with _$RequiresPrivateCtor {
  const factory RequiresPrivateCtor() = _RequiresPrivateCtor;

  void method() {
    print('hello world');
  }
}

@freezed
class HasPrivateCtor with _$HasPrivateCtor {
  const HasPrivateCtor._();
  const factory HasPrivateCtor() = _HasPrivateCtor;


  void method() {
    print('hello world');
  }
}