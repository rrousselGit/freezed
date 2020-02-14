import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

part 'single_class_constructor.freezed.dart';

@freezed
abstract class MyClass with _$MyClass {
  const factory MyClass({String a, int b}) = WhateverIWant;
}

@freezed
abstract class MixedParam with _$MixedParam {
  const factory MixedParam(String a, {int b}) = WhateverMixedParam;
}

@freezed
abstract class PositionalMixedParam with _$PositionalMixedParam {
  const factory PositionalMixedParam(String a, [int b]) =
      WhateverPositionalMixedParam;
}

@freezed
abstract class Required with _$Required {
  const factory Required({@required String a}) = WhateverRequired;
}

@freezed
abstract class Empty with _$Empty {
  const factory Empty() = WhateverEmpty;
}

@freezed
abstract class Empty2 with _$Empty2 {
  const factory Empty2() = WhateverEmpty2;
}

@freezed
abstract class SingleNamedCtor with _$SingleNamedCtor {
  const factory SingleNamedCtor.named(int a) = WhateverSingleNamedCtor;
}

@freezed
abstract class Generic<T> with _$Generic<T> {
  const factory Generic(T value) = A<T>;
}

@freezed
abstract class Example with _$Example {
  const factory Example(String a, {int b}) = Example0;

  factory Example.fixed() {
    return const Example('a', b: 42);
  }
}

@freezed
abstract class NoConst with _$NoConst {
  factory NoConst() = NoConstImpl;
}

// Regression test for https://github.com/rrousselGit/freezed/issues/40
@freezed
abstract class SecondState with _$SecondState {
  const factory SecondState({
    String dateTime,
    String uuid,
  }) = _SecondState;
}
