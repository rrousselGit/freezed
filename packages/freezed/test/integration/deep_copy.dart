import 'package:freezed_annotation/freezed_annotation.dart';

part 'deep_copy.freezed.dart';

@freezed
class Company with _$Company {
  factory Company({String? name, Director? director}) = CompanySubclass;
}

@freezed
class Director with _$Director {
  factory Director({String? name, Assistant? assistant}) = _Director;
}

@freezed
class Assistant with _$Assistant {
  factory Assistant({String? name, int? age}) = _Assistant;
}

@freezed
class NoCommonProperty with _$NoCommonProperty {
  factory NoCommonProperty() = NoCommonPropertyEmpty;
  factory NoCommonProperty.assistant(Assistant assistant) =
      NoCommonPropertyAssistant;
}

@freezed
class Union with _$Union {
  factory Union.first(Assistant shared, Assistant first) = UnionFirst;
  factory Union.second(Assistant shared, Assistant second) = UnionSecond;
}

@freezed
class _Private with _$_Private {
  factory _Private(Assistant assistant) = __Private;
}

@freezed
class DeepGeneric<T> with _$DeepGeneric<T> {
  factory DeepGeneric(Generic<T> value, T second) = _DeepGeneric<T>;
}

@freezed
class Generic<T> with _$Generic<T> {
  factory Generic(T value, T value2) = _Generic<T>;
}

@freezed
class Recursive with _$Recursive {
  factory Recursive([Recursive? value]) = _Recursive;
}

@freezed
class DisabledDeepCopyWith with _$DisabledDeepCopyWith {
  factory DisabledDeepCopyWith(DisabledCopy disabled) = _DisabledDeepCopyWith;
}

@Freezed(copyWith: false)
class DisabledCopy with _$DisabledCopy {
  factory DisabledCopy(DisabledCopy disabled) = _DisabledCopy;
}
