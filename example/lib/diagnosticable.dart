import 'package:flutter/foundation.dart';

part 'diagnosticable.g.dart';

@immutable
abstract class Example<T> with _$Example<T> {
  factory Example(int a, String b) = _Example<T>;
  factory Example.named(T c) = _Example2<T>;
}
