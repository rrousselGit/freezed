import 'package:meta/meta.dart';

part 'single_class_constructor.g.dart';

@immutable
abstract class MyClass with _$MyClass {
  const factory MyClass({
    String a,
    int b,
  }) = WhateverIWant;
}
