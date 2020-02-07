// ignore_for_file: mixin_of_non_class, redirect_to_non_class, undefined_class
import 'package:meta/meta.dart';

part 'single_class_constructor.g.dart';

@immutable
abstract class MyClass with _$MyClass {
  const factory MyClass({String a, int b}) = WhateverIWant;
}

@immutable
abstract class MixedParam with _$MixedParam {
  const factory MixedParam(String a, {int b}) = WhateverMixedParam;
}

@immutable
abstract class PositionalMixedParam with _$PositionalMixedParam {
  const factory PositionalMixedParam(String a, [int b]) = WhateverPositionalMixedParam;
}

@immutable
abstract class Required with _$Required {
  const factory Required({@required String a}) = WhateverRequired;
}

@immutable
abstract class Empty with _$Empty {
  const factory Empty() = WhateverEmpty;
}

@immutable
abstract class Empty2 with _$Empty2 {
  const factory Empty2() = WhateverEmpty2;
}

@immutable
abstract class SingleNamedCtor with _$SingleNamedCtor {
  const factory SingleNamedCtor.named(int a) = WhateverSingleNamedCtor;
}
