// ignore_for_file: redirect_to_non_class, unused_element, avoid_unused_constructor_parameters
import 'package:source_gen_test/annotations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@ShouldThrow('Marked Unrelated with @freezed, but the class is not abstract')
@freezed
class Unrelated {}

@ShouldThrow('@freezed can only be applied on classes. Failing element: foo')
@freezed
int foo;

@ShouldThrow(
    'Getters not decorated with @late requires a MyClass._() constructor')
@freezed
abstract class Properties {
  int get regularProperty;

  factory Properties() = _Properties;
}

@ShouldThrow(
    'Getters not decorated with @late requires a MyClass._() constructor')
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

@ShouldThrow('@Default cannot be used on non-optional parameters')
@freezed
abstract class DefaultOnRequiredPositional {
  factory DefaultOnRequiredPositional(
    @Default(42) int a,
  ) = _DefaultOnRequiredPositional;
}

@ShouldThrow(
  'Classes decorated with @freezed can only have a single non-factory'
  ', without parameters, and named MyClass._()',
)
@freezed
abstract class MultipleConcreteConstructors {
  MultipleConcreteConstructors._();
  MultipleConcreteConstructors();
}

@ShouldThrow(
  'Classes decorated with @freezed can only have a single non-factory'
  ', without parameters, and named MyClass._()',
)
@freezed
abstract class SingleConcreteConstructorInvalidName {
  SingleConcreteConstructorInvalidName();
}

@ShouldThrow(
  'Classes decorated with @freezed can only have a single non-factory'
  ', without parameters, and named MyClass._()',
)
@freezed
abstract class ConcreteConstructorWithParameters {
  ConcreteConstructorWithParameters(int a);
}

@ShouldThrow(
  'Marked NothingToDo with @freezed, but freezed has nothing to generate',
)
@freezed
abstract class NothingToDo {
  NothingToDo._();
}

@ShouldThrow(
  'Classes decorated with @freezed cannot have mutable properties',
)
@freezed
abstract class MutableProperty {
  MutableProperty._();

  factory MutableProperty() = _MutableProperty;

  int a;
}
