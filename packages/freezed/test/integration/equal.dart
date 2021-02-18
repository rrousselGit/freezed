import 'package:freezed_annotation/freezed_annotation.dart';

part 'equal.freezed.dart';

@freezed
class Simple with _$Simple {
  factory Simple(int value) = _Simple;
}

@freezed
class ListEqual with _$ListEqual {
  factory ListEqual(List<int> value) = _ListEqual;
}

@freezed
class MapEqual with _$MapEqual {
  factory MapEqual(Map<int, int> value) = _MapEqual;
}

@freezed
class SetEqual with _$SetEqual {
  factory SetEqual(Set<int> value) = _SetEqual;
}

@freezed
class IterableEqual with _$IterableEqual {
  factory IterableEqual(Iterable<int> value) = _IterableEqual;
}

@freezed
class ListObjectEqual with _$ListObjectEqual {
  factory ListObjectEqual(List<Object> value) = _ListObjectEqual;
}

@freezed
class ListDynamicEqual with _$ListDynamicEqual {
  factory ListDynamicEqual(List<dynamic> value) = _ListDynamicEqual;
}

@freezed
class ObjectEqual with _$ObjectEqual {
  factory ObjectEqual(Object value) = _ObjectEqual;
}

@freezed
class NullableObjectEqual with _$NullableObjectEqual {
  factory NullableObjectEqual(Object? value) = _NullableObjectEqual;
}

@freezed
class DynamicEqual with _$DynamicEqual {
  factory DynamicEqual(dynamic value) = _DynamicEqual;
}

@freezed
class Generic<T> with _$Generic<T> {
  factory Generic(T value) = _Generic<T>;
}

@freezed
class GenericObject<T extends Object> with _$GenericObject<T> {
  factory GenericObject(T value) = _GenericObject<T>;
}

@freezed
class GenericIterable<T extends Iterable<dynamic>> with _$GenericIterable<T> {
  factory GenericIterable(T value) = _GenericIterable<T>;
}

@freezed
class ObjectWithOtherProperty with _$ObjectWithOtherProperty {
  factory ObjectWithOtherProperty(List<int> other) = _ObjectWithOtherProperty;
}
