import 'package:meta/meta.dart';

part 'example.g.dart';

@immutable
abstract class MyClass with _MyClassBase {
  const factory MyClass({
    String a,
    int b,
  }) = _MyClass;
}
