// ignore_for_file: redirect_to_non_class
import 'package:meta/meta.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldGenerate('\n')
@immutable
class Unrelated {}

@ShouldGenerate('\n')
@immutable
class NonFreezedClass {
  final int regularField;

  const NonFreezedClass(this.regularField);

  factory NonFreezedClass.someFactory(int x) => NonFreezedClass(x);
}
