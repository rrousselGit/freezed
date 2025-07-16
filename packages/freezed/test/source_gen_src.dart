// ignore_for_file: avoid_unused_constructor_parameters, unused_element
import 'package:freezed_annotation/freezed_annotation.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:source_gen_test/annotations.dart';

@ShouldThrow('''
The class RequiredCloneable requested a copyWith implementation, yet the parameter `notCloneable` is not cloneable.

To fix, either:
- Disable copyWith using @Freezed(copyWith: false)
- Make `notCloneable` optional
- Make sure `this.notCloneable` is accessible from the copyWith method
''')
@freezed
class RequiredCloneable with _$RequiredCloneable {
  RequiredCloneable({required int notCloneable});
}

mixin _$RequiredCloneable {}

@ShouldThrow(r'Classes using @freezed must use `with _$NoMixin`.')
@freezed
class NoMixin {}

class Base {}

@ShouldThrow(
  'Classes using extends/with must define a MyClass._() constructor.',
)
@freezed
abstract class ExtendsWithoutDefault extends Base with _$ExtendsWithoutDefault {
  factory ExtendsWithoutDefault() = _ExtendsWithoutDefault;
}

class _ExtendsWithoutDefault implements ExtendsWithoutDefault {}

mixin _$ExtendsWithoutDefault {}

@ShouldThrow('@freezed can only be applied on classes.')
@freezed
enum Foo { a }

@ShouldThrow('Getters require a MyClass._() constructor')
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
  factory DefaultOnRequiredPositional(@Default(42) int a) =
      _DefaultOnRequiredPositional;
}

class _DefaultOnRequiredPositional implements DefaultOnRequiredPositional {
  _DefaultOnRequiredPositional(int a);
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

@ShouldThrow('Classes decorated with @freezed cannot have mutable properties')
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

@ShouldGenerate('', contains: true, expectedLogItems: [])
@freezed
abstract class AbstractClass with _$AbstractClass {
  const factory AbstractClass() = _AbstractClass;
}

class _AbstractClass implements AbstractClass {
  const _AbstractClass();
}

mixin _$AbstractClass {}
