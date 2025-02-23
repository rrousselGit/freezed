// ignore_for_file: avoid_unused_constructor_parameters, unused_element
import 'package:freezed_annotation/freezed_annotation.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:source_gen_test/annotations.dart';

@ShouldThrow('@freezed can only be applied on classes.')
@freezed
enum Foo { a }

@ShouldThrow(
  'Getters require a MyClass._() constructor',
)
@freezed
abstract class Properties {
  factory Properties() = _Properties;

  int get regularProperty => 42;
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

@ShouldThrow('Fallback union was specified but no fallback constructor exists.')
@Freezed(fallbackUnion: 'fallback')
class FallbackUnionMissing {
  factory FallbackUnionMissing.first() = _First;
  factory FallbackUnionMissing.second() = _Second;
}

class _First implements FallbackUnionMissing {
  _First();
}

class _Second implements FallbackUnionMissing {
  _Second();
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

@ShouldGenerate(
  '',
  contains: true,
  expectedLogItems: [],
)
@freezed
abstract class AstractClass {
  const factory AstractClass() = _AstractClass;
}

class _AstractClass implements AstractClass {
  const _AstractClass();
}
