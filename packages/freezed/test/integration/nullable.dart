import 'package:freezed_annotation/freezed_annotation.dart';

part 'nullable.freezed.dart';

@freezed
abstract class RequiredPositional with _$RequiredPositional {
  factory RequiredPositional(int a) = _RequiredPositional;
}

@freezed
abstract class NullableRequiredPositional with _$NullableRequiredPositional {
  factory NullableRequiredPositional(int? a) = _NullableRequiredPositional;
}

@freezed
abstract class Positional with _$Positional {
  factory Positional([int? a]) = _Positional;
}

@freezed
abstract class DefaultPositional with _$DefaultPositional {
  factory DefaultPositional([@Default(0) int a]) = _DefaultPositional;
}

@freezed
abstract class Named with _$Named {
  factory Named({int? a}) = _Named;
}

@freezed
abstract class DefaultNamed with _$DefaultNamed {
  factory DefaultNamed({@Default(0) int a}) = _DefaultNamed;
}

@freezed
abstract class RequiredNamed with _$RequiredNamed {
  factory RequiredNamed({required int a}) = _RequiredNamed;
}

@freezed
abstract class NullableRequiredNamed with _$NullableRequiredNamed {
  factory NullableRequiredNamed({required int? a}) = _NullableRequiredNamed;
}
