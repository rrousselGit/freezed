// ignore_for_file: avoid_unused_constructor_parameters, unused_element
// ignore: import_of_legacy_library_into_null_safe
import 'package:source_gen_test/annotations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@ShouldThrow('Marked Unrelated with @freezed, but the class is not abstract')
@freezed
class Unrelated {}

@ShouldThrow('@freezed can only be applied on classes. Failing element: foo')
@freezed
Object? foo;

@ShouldThrow(
  'Getters require a MyClass._() constructor',
)
@freezed
abstract class Properties {
  factory Properties() = _Properties;

  int get regularProperty;
}

class _Properties implements Properties {
  @override
  final int regularProperty = 0;
}

@ShouldThrow(
  'The parameter `a` of `RequiredNamed.foo` is non-nullable but is neither required nor marked with @Default',
)
@freezed
abstract class RequiredNamed {
  factory RequiredNamed.foo({int a}) = _RequiredNamed;
}

class _RequiredNamed implements RequiredNamed {
  _RequiredNamed({int? a});
}

@ShouldThrow(
  'The parameter `a` of `RequiredPositional` is non-nullable but is neither required nor marked with @Default',
)
@freezed
abstract class RequiredPositional {
  factory RequiredPositional([int a]) = _RequiredPositional;
}

class _RequiredPositional implements RequiredPositional {
  _RequiredPositional([int? a]);
}

@ShouldThrow(
  'The parameter `a` of `RequiredNamedDefault` is non-nullable but is neither required nor marked with @Default',
)
@freezed
abstract class RequiredNamedDefault {
  factory RequiredNamedDefault({int a}) = _RequiredNamedDefault;
}

class _RequiredNamedDefault implements RequiredNamedDefault {
  _RequiredNamedDefault({int? a});
}

@ShouldThrow('Getters require a MyClass._() constructor')
@freezed
abstract class Get {
  factory Get() = _Get;

  int get regularProperty => 42;
}

class _Get implements Get {
  @override
  final int regularProperty = 0;
}

@ShouldThrow('Final variables require a MyClass._() constructor')
@freezed
abstract class Final {
  factory Final() = _Final;

  final int regularProperty = 42;
}

class _Final implements Final {
  @override
  final int regularProperty = 0;
}

@ShouldThrow('@Default cannot be used on non-optional parameters')
@freezed
abstract class DefaultOnRequiredPositional {
  factory DefaultOnRequiredPositional(
    @Default(42) int a,
  ) = _DefaultOnRequiredPositional;
}

class _DefaultOnRequiredPositional implements DefaultOnRequiredPositional {
  _DefaultOnRequiredPositional(int a);
}

@ShouldThrow('A freezed union cannot have private constructors')
@freezed
abstract class Mixed {
  factory Mixed._internal(String a) = Mixed0;
  factory Mixed.named(String b) = Mixed1;
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
  'Marked ManualFactory with @freezed, but freezed has nothing to generate',
)
@freezed
abstract class ManualFactory {
  factory ManualFactory() => _Manual();
}

class _Manual implements ManualFactory {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

@ShouldThrow(
  'Marked ManualFactory2 with @freezed, but freezed has nothing to generate',
)
@freezed
abstract class ManualFactory2 {
  factory ManualFactory2({int? a}) => _Manual2(a: a ??= 42);
}

class _Manual2 implements ManualFactory2 {
  _Manual2({int? a});

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

@ShouldThrow(
  'Classes decorated with @freezed cannot have mutable properties',
)
@freezed
abstract class MutableProperty {
  MutableProperty._();

  factory MutableProperty() = _MutableProperty;

  int? a;
}

class _MutableProperty implements MutableProperty {
  @override
  int? a;
}

class Mixed1 implements Mixed {
  Mixed1(String b);
}

class Mixed0 implements Mixed {
  Mixed0(String a);
}
