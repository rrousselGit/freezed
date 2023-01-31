import 'package:freezed_annotation/freezed_annotation.dart';

part 'missing_private_empty_ctor.freezed.dart';

@freezed
// expect_lint: freezed_missing_private_empty_constructor
class RequiresPrivateCtor with _$RequiresPrivateCtor {
  // const RequiresPrivateCtor._();
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

@freezed
// expect_lint: freezed_missing_private_empty_constructor
class HasAccessor with _$HasAccessor {
  // const HasAccessor._();
  const factory HasAccessor(int id) = _HasAccessor;

  String get idString => id.toString();
}

abstract class IdClass {
  int get id;
}

mixin IdMixin {
  int get id;
}

@freezed
class WithIdMixin with _$WithIdMixin, IdMixin {
  // const WithIdMixin._();
  const factory WithIdMixin(int id) = _WithIdMixin;
}

@freezed
// expect_lint: freezed_missing_private_empty_constructor
class ExtendsIdClass extends IdClass with _$ExtendsIdClass {
  // ExtendsIdClass._();
  const factory ExtendsIdClass(int id) = _ExtendsIdClass;

  @override
  int get id => id;
}
