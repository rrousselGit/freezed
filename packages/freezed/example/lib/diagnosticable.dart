import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'diagnosticable.freezed.dart';

@freezed
abstract class Example<T> with _$Example<T> {
  Example._();
  factory Example(int a, String b) = _Example<T>;
  factory Example.named(T c) = _Example2<T>;

  late final theAnswer = 42;
}

@freezed
abstract class ConcreteExample<T> with _$ConcreteExample<T> {
  ConcreteExample._();
  factory ConcreteExample() = _ConcreteExample<T>;
}
