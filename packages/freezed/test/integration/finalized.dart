import 'package:freezed_annotation/freezed_annotation.dart';

part 'finalized.freezed.dart';

@Freezed(makeGeneratedClassesFinal: true)
sealed class SealedWithFinalFoo with _$SealedWithFinalFoo {
  factory SealedWithFinalFoo() = _SealedWithFinalFoo;
}

@Freezed(makeGeneratedClassesFinal: true)
sealed class SealedWithFinalBar with _$SealedWithFinalBar {
  factory SealedWithFinalBar() = _SealedWithFinalBar;
}

@Freezed(makeGeneratedClassesFinal: true)
sealed class SealedWithFinalAbc with _$SealedWithFinalAbc {
  factory SealedWithFinalAbc.a() = SealedWithFinalAbcA;
  factory SealedWithFinalAbc.b() = SealedWithFinalAbcB;
  factory SealedWithFinalAbc.c() = SealedWithFinalAbcC;
}

@Freezed(makeGeneratedClassesFinal: true)
abstract class AbstractWithFinalFoo with _$AbstractWithFinalFoo {
  factory AbstractWithFinalFoo() = _AbstractWithFinalFoo;
}

@Freezed(makeGeneratedClassesFinal: true)
abstract class AbstractWithFinalBar with _$AbstractWithFinalBar {
  factory AbstractWithFinalBar() = _AbstractWithFinalBar;
}

@Freezed(makeGeneratedClassesFinal: true)
abstract class AbstractWithFinalAbc with _$AbstractWithFinalAbc {
  factory AbstractWithFinalAbc.a() = AbstractWithFinalAbcA;
  factory AbstractWithFinalAbc.b() = AbstractWithFinalAbcB;
  factory AbstractWithFinalAbc.c() = AbstractWithFinalAbcC;
}

sealed class SuperFoo {
  const SuperFoo();
}

final class CustomFoo extends SuperFoo {}

@Freezed(makeGeneratedClassesFinal: true)
sealed class SealedWithFinalSuperFoo extends SuperFoo
    with _$SealedWithFinalSuperFoo {
  const SealedWithFinalSuperFoo._() : super();

  factory SealedWithFinalSuperFoo() = _SealedWithFinalSuperFoo;
}

@Freezed(makeGeneratedClassesFinal: true)
abstract class AbstractWithFinalSuperFoo extends SuperFoo
    with _$AbstractWithFinalSuperFoo {
  const AbstractWithFinalSuperFoo._() : super();

  factory AbstractWithFinalSuperFoo() = _AbstractWithFinalSuperFoo;
}

class SubFoo extends AbstractWithFinalSuperFoo {
  SubFoo() : super._();
}
