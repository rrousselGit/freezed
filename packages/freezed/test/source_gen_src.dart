// ignore_for_file: redirect_to_non_class
import 'package:source_gen_test/annotations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@ShouldThrow('Marked Unrelated with @freezed, but the class is not abstract')
@freezed
class Unrelated {}

@ShouldThrow(
    'Marked NonFreezedClass with @freezed, but freezed has nothing to generate')
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

@ShouldThrow('@freezed cannot be used on classes with unimplemented getters')
@freezed
abstract class Get {
  int get regularProperty => 42;

  factory Get() = _Get;
}

@ShouldThrow('@late cannot be used in combination with const constructors')
@freezed
abstract class LateConst {
  const factory LateConst() = _LateConst;

  @late
  String get name => '42';
}

@ShouldThrow('@late can only be used on getters with using =>')
@freezed
abstract class LateBody {
  factory LateBody() = _LateBody;

  @late
  String get name {
    return '42';
  }
}

@ShouldThrow('@late can only be used on getters with using =>')
@freezed
abstract class LateAbstract {
  factory LateAbstract() = _LateAbstract;

  @late
  String get name;
}
