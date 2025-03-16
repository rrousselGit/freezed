import 'package:freezed_annotation/freezed_annotation.dart';

part 'finalized.freezed.dart';

@Freezed(classModifiers: [FreezedClassModifier.Final])
abstract class SealedWithFinalFoo with _$SealedWithFinalFoo {
  factory SealedWithFinalFoo() = _SealedWithFinalFoo;
}

@Freezed(classModifiers: [FreezedClassModifier.Final])
sealed class SealedWithFinalBar with _$SealedWithFinalBar {
  factory SealedWithFinalBar() = _SealedWithFinalBar;
}

@Freezed(classModifiers: [FreezedClassModifier.Final])
sealed class SealedWithFinalAbc with _$SealedWithFinalAbc {
  factory SealedWithFinalAbc.a() = SealedWithFinalAbcA;
  factory SealedWithFinalAbc.b() = SealedWithFinalAbcB;
  factory SealedWithFinalAbc.c() = SealedWithFinalAbcC;
}

@Freezed(classModifiers: [FreezedClassModifier.Final])
abstract class AbstractWithFinalFoo with _$AbstractWithFinalFoo {
  factory AbstractWithFinalFoo() = _AbstractWithFinalFoo;
}

@Freezed(classModifiers: [FreezedClassModifier.Final])
abstract class AbstractWithFinalBar with _$AbstractWithFinalBar {
  factory AbstractWithFinalBar() = _AbstractWithFinalBar;
}

@Freezed(classModifiers: [FreezedClassModifier.Final])
abstract class AbstractWithFinalAbc with _$AbstractWithFinalAbc {
  factory AbstractWithFinalAbc.a() = AbstractWithFinalAbcA;
  factory AbstractWithFinalAbc.b() = AbstractWithFinalAbcB;
  factory AbstractWithFinalAbc.c() = AbstractWithFinalAbcC;
}

sealed class SuperFoo {
  const SuperFoo();
}

final class CustomFoo extends SuperFoo {}

@Freezed(classModifiers: [FreezedClassModifier.Final])
sealed class SealedWithFinalSuperFoo extends SuperFoo
    with _$SealedWithFinalSuperFoo {
  const SealedWithFinalSuperFoo._() : super();

  factory SealedWithFinalSuperFoo() = _SealedWithFinalSuperFoo;
}

@Freezed(classModifiers: [FreezedClassModifier.Final])
abstract class AbstractWithFinalSuperFoo extends SuperFoo
    with _$AbstractWithFinalSuperFoo {
  const AbstractWithFinalSuperFoo._() : super();

  factory AbstractWithFinalSuperFoo() = _AbstractWithFinalSuperFoo;
}

class SubFoo extends AbstractWithFinalSuperFoo {
  SubFoo() : super._();
}
