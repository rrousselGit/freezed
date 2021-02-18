import 'package:freezed_annotation/freezed_annotation.dart';

part 'nullable.freezed.dart';

@freezed
class RequiredPositional with _$RequiredPositional {
  factory RequiredPositional(int a) = _RequiredPositional;
}

@freezed
class NullableRequiredPositional with _$NullableRequiredPositional {
  factory NullableRequiredPositional(int? a) = _NullableRequiredPositional;
}

@freezed
class Positional with _$Positional {
  factory Positional([int? a]) = _Positional;
}

@freezed
class DefaultPositional with _$DefaultPositional {
  factory DefaultPositional([@Default(0) int a]) = _DefaultPositional;
}

@freezed
class Named with _$Named {
  factory Named({int? a}) = _Named;
}

@freezed
class DefaultNamed with _$DefaultNamed {
  factory DefaultNamed({@Default(0) int a}) = _DefaultNamed;
}

@freezed
class RequiredNamed with _$RequiredNamed {
  factory RequiredNamed({required int a}) = _RequiredNamed;
}

@freezed
class NullableRequiredNamed with _$NullableRequiredNamed {
  factory NullableRequiredNamed({required int? a}) = _NullableRequiredNamed;
}
