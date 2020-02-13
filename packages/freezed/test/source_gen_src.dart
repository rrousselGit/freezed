// ignore_for_file: redirect_to_non_class
import 'package:source_gen_test/annotations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@ShouldThrow('Marked Unrelated with @freezed, but the class is not abstract')
@freezed
class Unrelated {}

@ShouldThrow('Marked NonFreezedClass with @freezed, but freezed has nothing to generate')
@freezed
abstract class NonFreezedClass {
  const NonFreezedClass();
}

@ShouldThrow('@freezed can only be applied on classes. Failing element: foo')
@freezed
int foo;

@ShouldThrow('@freezed cannot be used on classes with unimplemented getters')
@freezed
abstract class Properties {
  int get regularProperty;

  factory Properties() = _Properties;
}
