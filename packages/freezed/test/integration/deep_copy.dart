import 'package:freezed_annotation/freezed_annotation.dart';

part 'deep_copy.freezed.dart';

@freezed
abstract class Company with _$Company {
  factory Company({String name, Director director}) = CompanySubclass;
}

@freezed
abstract class Director with _$Director {
  factory Director({String name, Assistant assistant}) = _Director;
}

@freezed
abstract class Assistant with _$Assistant {
  factory Assistant({String name, int age}) = _Assistant;
}

@freezed
abstract class NoCommonProperty with _$NoCommonProperty {
  factory NoCommonProperty() = NoCommonPropertyEmpty;
  factory NoCommonProperty.assistant(Assistant assistant) =
      NoCommonPropertyAssistant;
}

@freezed
abstract class Union with _$Union {
  factory Union.first(Assistant shared, Assistant first) = UnionFirst;
  factory Union.second(Assistant shared, Assistant second) = UnionSecond;
}

@freezed
abstract class _Private with _$_Private {
  factory _Private(Assistant assistant) = __Private;
}
