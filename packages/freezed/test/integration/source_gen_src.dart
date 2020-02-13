// ignore_for_file: redirect_to_non_class
import 'package:source_gen_test/annotations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@ShouldGenerate('\n')
@freezed
class Unrelated {}

@ShouldGenerate('\n')
@freezed
class NonFreezedClass {
  final int regularField;

  const NonFreezedClass(this.regularField);

  factory NonFreezedClass.someFactory(int x) => NonFreezedClass(x);
}
