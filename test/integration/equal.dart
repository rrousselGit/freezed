import 'package:meta/meta.dart';
import 'package:collection/collection.dart';
part 'equal.freezed.dart';

@immutable
abstract class Simple with _$Simple {
  factory Simple(int value) = _Simple;
}

@immutable
abstract class ListEqual with _$ListEqual {
  factory ListEqual(List<int> value) = _ListEqual;
}

@immutable
abstract class MapEqual with _$MapEqual {
  factory MapEqual(Map<int, int> value) = _MapEqual;
}

@immutable
abstract class SetEqual with _$SetEqual {
  factory SetEqual(Set<int> value) = _SetEqual;
}

@immutable
abstract class IterableEqual with _$IterableEqual {
  factory IterableEqual(Iterable<int> value) = _IterableEqual;
}

@immutable
abstract class ListObjectEqual with _$ListObjectEqual {
  factory ListObjectEqual(List<Object> value) = _ListObjectEqual;
}

@immutable
abstract class ListDynamicEqual with _$ListDynamicEqual {
  factory ListDynamicEqual(List<dynamic> value) = _ListDynamicEqual;
}

@immutable
abstract class ObjectEqual with _$ObjectEqual {
  factory ObjectEqual(Object value) = _ObjectEqual;
}

@immutable
abstract class DynamicEqual with _$DynamicEqual {
  factory DynamicEqual(dynamic value) = _DynamicEqual;
}

@immutable
abstract class Generic<T> with _$Generic<T> {
  factory Generic(T value) = _Generic<T>;
}

@immutable
abstract class GenericObject<T extends Object> with _$GenericObject<T> {
  factory GenericObject(T value) = _GenericObject<T>;
}

@immutable
abstract class GenericIterable<T extends Iterable<dynamic>> with _$GenericIterable<T> {
  factory GenericIterable(T value) = _GenericIterable<T>;
}
