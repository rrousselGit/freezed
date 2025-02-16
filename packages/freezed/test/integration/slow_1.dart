import 'package:freezed_annotation/freezed_annotation.dart';

import './slow_2.dart';
import 'slow_3.dart';

part 'slow_1.freezed.dart';

@freezed
abstract class Root with _$Root {
  const factory Root.a(A a) = _A;
  const factory Root.b(B b) = _B;
  const factory Root.c(A a) = _C;
  const factory Root.d(B b) = _D;
  const factory Root.e(A a) = _E;
  const factory Root.f(A a) = _F;
  const factory Root.g(B b) = _G;
  const factory Root.h(A a) = _H;
  const factory Root.i(B b) = _I;
  const factory Root.j(A a) = _J;
  const factory Root.k(B b) = _K;
  const factory Root.l(A a) = _L;
  const factory Root.m(B b) = _M;
}
