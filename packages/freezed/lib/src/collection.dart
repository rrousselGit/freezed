import 'dart:collection';

/// An [UnmodifiableListView] which overrides ==
// ignore: invalid_internal_annotation
class EqualUnmodifiableListView<T> extends UnmodifiableListView<T> {
  /// An [UnmodifiableListView] which overrides ==
  EqualUnmodifiableListView(this._source) : super(_source);

  final Iterable<T> _source;

  @override
  bool operator ==(Object other) {
    return other is EqualUnmodifiableListView<T> &&
        other.runtimeType == runtimeType &&
        other._source == _source;
  }

  @override
  int get hashCode => Object.hash(runtimeType, _source);
}

/// An [UnmodifiableSetView] which overrides ==
// ignore: invalid_internal_annotation
class EqualUnmodifiableSetView<T> extends UnmodifiableSetView<T> {
  /// An [UnmodifiableSetView] which overrides ==
  EqualUnmodifiableSetView(this._source) : super(_source);

  final Set<T> _source;

  @override
  bool operator ==(Object other) {
    return other is EqualUnmodifiableSetView<T> &&
        other.runtimeType == runtimeType &&
        other._source == _source;
  }

  @override
  int get hashCode => Object.hash(runtimeType, _source);
}

/// An [UnmodifiableMapView] which overrides ==
// ignore: invalid_internal_annotation
class EqualUnmodifiableMapView<Key, Value>
    extends UnmodifiableMapView<Key, Value> {
  /// An [UnmodifiableMapView] which overrides ==
  EqualUnmodifiableMapView(this._source) : super(_source);

  final Map<Key, Value> _source;

  @override
  bool operator ==(Object other) {
    return other is EqualUnmodifiableMapView<Key, Value> &&
        other.runtimeType == runtimeType &&
        other._source == _source;
  }

  @override
  int get hashCode => Object.hash(runtimeType, _source);
}
