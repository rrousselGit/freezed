// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'time_slot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$TimeSlotTearOff {
  const _$TimeSlotTearOff();

  _TimeSlot call({TimeOfDay start, TimeOfDay end}) {
    return _TimeSlot(
      start: start,
      end: end,
    );
  }
}

// ignore: unused_element
const $TimeSlot = _$TimeSlotTearOff();

mixin _$TimeSlot {
  TimeOfDay get start;
  TimeOfDay get end;

  $TimeSlotCopyWith<TimeSlot> get copyWith;
}

abstract class $TimeSlotCopyWith<$Res> {
  factory $TimeSlotCopyWith(TimeSlot value, $Res Function(TimeSlot) then) =
      _$TimeSlotCopyWithImpl<$Res>;
  $Res call({TimeOfDay start, TimeOfDay end});
}

class _$TimeSlotCopyWithImpl<$Res> implements $TimeSlotCopyWith<$Res> {
  _$TimeSlotCopyWithImpl(this._value, this._then);

  final TimeSlot _value;
  // ignore: unused_field
  final $Res Function(TimeSlot) _then;

  @override
  $Res call({
    Object start = freezed,
    Object end = freezed,
  }) {
    return _then(_value.copyWith(
      start: start == freezed ? _value.start : start as TimeOfDay,
      end: end == freezed ? _value.end : end as TimeOfDay,
    ));
  }
}

abstract class _$TimeSlotCopyWith<$Res> implements $TimeSlotCopyWith<$Res> {
  factory _$TimeSlotCopyWith(_TimeSlot value, $Res Function(_TimeSlot) then) =
      __$TimeSlotCopyWithImpl<$Res>;
  @override
  $Res call({TimeOfDay start, TimeOfDay end});
}

class __$TimeSlotCopyWithImpl<$Res> extends _$TimeSlotCopyWithImpl<$Res>
    implements _$TimeSlotCopyWith<$Res> {
  __$TimeSlotCopyWithImpl(_TimeSlot _value, $Res Function(_TimeSlot) _then)
      : super(_value, (v) => _then(v as _TimeSlot));

  @override
  _TimeSlot get _value => super._value as _TimeSlot;

  @override
  $Res call({
    Object start = freezed,
    Object end = freezed,
  }) {
    return _then(_TimeSlot(
      start: start == freezed ? _value.start : start as TimeOfDay,
      end: end == freezed ? _value.end : end as TimeOfDay,
    ));
  }
}

class _$_TimeSlot with DiagnosticableTreeMixin implements _TimeSlot {
  _$_TimeSlot({this.start, this.end});

  @override
  final TimeOfDay start;
  @override
  final TimeOfDay end;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TimeSlot(start: $start, end: $end)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TimeSlot'))
      ..add(DiagnosticsProperty('start', start))
      ..add(DiagnosticsProperty('end', end));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TimeSlot &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(start) ^
      const DeepCollectionEquality().hash(end);

  @override
  _$TimeSlotCopyWith<_TimeSlot> get copyWith =>
      __$TimeSlotCopyWithImpl<_TimeSlot>(this, _$identity);
}

abstract class _TimeSlot implements TimeSlot {
  factory _TimeSlot({TimeOfDay start, TimeOfDay end}) = _$_TimeSlot;

  @override
  TimeOfDay get start;
  @override
  TimeOfDay get end;
  @override
  _$TimeSlotCopyWith<_TimeSlot> get copyWith;
}
