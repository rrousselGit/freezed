import 'package:freezed_annotation/freezed_annotation.dart';

part 'concrete.freezed.dart';

@freezed
abstract class EmptyExtends extends Empty with _$EmptyExtends {
  factory EmptyExtends(int value) = _EmptyExtends;
}

abstract class Empty {
  const Empty();
}

@freezed
abstract class Concrete extends A with _$Concrete {
  Concrete._();
  factory Concrete(int value) = _Concrete;
}

abstract class A {
  int get value;
  int method() {
    return 42;
  }
}

@freezed
abstract class EmptyConcrete extends Empty with _$EmptyConcrete {
  EmptyConcrete._();
  factory EmptyConcrete() = _EmptyConcrete;
}

@freezed
abstract class ConstConcrete extends Empty with _$ConstConcrete {
  const ConstConcrete._();
  const factory ConstConcrete() = _ConstConcrete;
}

@freezed
abstract class MixedIn with _$MixedIn, Mixin {
  MixedIn._();
  factory MixedIn() = _MixedIn;
}

mixin Mixin {
  int method() => 42;
}
