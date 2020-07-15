import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_slot.freezed.dart';

@freezed

/// This is class has been added to address the issue described in
/// https://github.com/rrousselGit/freezed/issues/220
abstract class TimeSlot with _$TimeSlot {
  factory TimeSlot({
    TimeOfDay start,
    TimeOfDay end,
  }) = _TimeSlot;
}
