import 'package:freezed_annotation/freezed_annotation.dart';

part 'equal.freezed.dart';

@freezed
abstract class Simple with _$Simple {
  factory Simple(int value) = _Simple;
}

@freezed
abstract class ListEqual with _$ListEqual {
  factory ListEqual(List<int> value) = _ListEqual;
}

@freezed
abstract class MapEqual with _$MapEqual {
  factory MapEqual(Map<int, int> value) = _MapEqual;
}

@freezed
abstract class SetEqual with _$SetEqual {
  factory SetEqual(Set<int> value) = _SetEqual;
}

@freezed
abstract class IterableEqual with _$IterableEqual {
  factory IterableEqual(Iterable<int> value) = _IterableEqual;
}

@freezed
abstract class ListObjectEqual with _$ListObjectEqual {
  factory ListObjectEqual(List<Object> value) = _ListObjectEqual;
}

@freezed
abstract class ListDynamicEqual with _$ListDynamicEqual {
  factory ListDynamicEqual(List<dynamic> value) = _ListDynamicEqual;
}

@freezed
abstract class ObjectEqual with _$ObjectEqual {
  factory ObjectEqual(Object value) = _ObjectEqual;
}

@freezed
abstract class DynamicEqual with _$DynamicEqual {
  factory DynamicEqual(dynamic value) = _DynamicEqual;
}

@freezed
abstract class Generic<T> with _$Generic<T> {
  factory Generic(T value) = _Generic<T>;
}

@freezed
abstract class GenericObject<T extends Object> with _$GenericObject<T> {
  factory GenericObject(T value) = _GenericObject<T>;
}

@freezed
abstract class GenericIterable<T extends Iterable<dynamic>>
    with _$GenericIterable<T> {
  factory GenericIterable(T value) = _GenericIterable<T>;
}

@freezed
abstract class ObjectWithOtherProperty with _$ObjectWithOtherProperty {
  factory ObjectWithOtherProperty(int other) = _ObjectWithOtherProperty;
}
