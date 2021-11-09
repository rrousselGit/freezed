// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'time_slot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$TimeSlotTearOff {
  const _$TimeSlotTearOff();

  _TimeSlot call({TimeOfDay? start, TimeOfDay? end}) {
    return _TimeSlot(
      start: start,
      end: end,
    );
  }
}

/// @nodoc
const $TimeSlot = _$TimeSlotTearOff();

/// @nodoc
mixin _$TimeSlot {
  TimeOfDay? get start => throw _privateConstructorUsedError;
  TimeOfDay? get end => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TimeSlotCopyWith<TimeSlot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeSlotCopyWith<$Res> {
  factory $TimeSlotCopyWith(TimeSlot value, $Res Function(TimeSlot) then) =
      _$TimeSlotCopyWithImpl<$Res>;
  $Res call({TimeOfDay? start, TimeOfDay? end});
}

/// @nodoc
class _$TimeSlotCopyWithImpl<$Res> implements $TimeSlotCopyWith<$Res> {
  _$TimeSlotCopyWithImpl(this._value, this._then);

  final TimeSlot _value;
  // ignore: unused_field
  final $Res Function(TimeSlot) _then;

  @override
  $Res call({
    Object? start = freezed,
    Object? end = freezed,
  }) {
    return _then(_value.copyWith(
      start: start == freezed
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
      end: end == freezed
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
    ));
  }
}

/// @nodoc
abstract class _$TimeSlotCopyWith<$Res> implements $TimeSlotCopyWith<$Res> {
  factory _$TimeSlotCopyWith(_TimeSlot value, $Res Function(_TimeSlot) then) =
      __$TimeSlotCopyWithImpl<$Res>;
  @override
  $Res call({TimeOfDay? start, TimeOfDay? end});
}

/// @nodoc
class __$TimeSlotCopyWithImpl<$Res> extends _$TimeSlotCopyWithImpl<$Res>
    implements _$TimeSlotCopyWith<$Res> {
  __$TimeSlotCopyWithImpl(_TimeSlot _value, $Res Function(_TimeSlot) _then)
      : super(_value, (v) => _then(v as _TimeSlot));

  @override
  _TimeSlot get _value => super._value as _TimeSlot;

  @override
  $Res call({
    Object? start = freezed,
    Object? end = freezed,
  }) {
    return _then(_TimeSlot(
      start: start == freezed
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
      end: end == freezed
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
    ));
  }
}

/// @nodoc

class _$_TimeSlot implements _TimeSlot {
  _$_TimeSlot({this.start, this.end});

  @override
  final TimeOfDay? start;
  @override
  final TimeOfDay? end;

  @override
  String toString() {
    return 'TimeSlot(start: $start, end: $end)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TimeSlot &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @override
  int get hashCode => Object.hash(runtimeType, start, end);

  @JsonKey(ignore: true)
  @override
  _$TimeSlotCopyWith<_TimeSlot> get copyWith =>
      __$TimeSlotCopyWithImpl<_TimeSlot>(this, _$identity);
}

abstract class _TimeSlot implements TimeSlot {
  factory _TimeSlot({TimeOfDay? start, TimeOfDay? end}) = _$_TimeSlot;

  @override
  TimeOfDay? get start;
  @override
  TimeOfDay? get end;
  @override
  @JsonKey(ignore: true)
  _$TimeSlotCopyWith<_TimeSlot> get copyWith =>
      throw _privateConstructorUsedError;
}
