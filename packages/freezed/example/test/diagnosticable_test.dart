import 'package:example/diagnosticable.dart' as diagnosticable;
import 'package:example/non_diagnosticable.dart' as non_diagnosticable;
import 'package:example/time_slot.dart';
import 'package:example/with_double_quotes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('overriding toString works', () {
    // regression test for https://github.com/rrousselGit/freezed/issues/221

    expect(
      diagnosticable.ToString().toString(),
      'MyToString()',
    );
  });

  test('use Diagnosticable instead of toString if possible', () {
    var value = diagnosticable.Example<int>(42, '21');

    expect(value, isA<DiagnosticableTree>());
    expect(value.toString(), 'Example<int>(a: 42, b: 21)');

    value = diagnosticable.Example.named(42);
    expect(value, isA<DiagnosticableTree>());
    expect(value.toString(), 'Example<int>.named(c: 42)');
  });

  test('debugFillProperties', () {
    final properties = DiagnosticPropertiesBuilder();
    var value = diagnosticable.Example<int>(42, '21');

    // ignore: invalid_use_of_protected_member
    (value as Diagnosticable).debugFillProperties(properties);

    expect(properties.properties, [
      isA<DiagnosticsProperty<void>>()
          .having((d) => d.name, 'name', 'type')
          .having((d) => d.value, 'value', 'Example<int>'),
      isA<DiagnosticsProperty<void>>()
          .having((d) => d.name, 'name', 'a')
          .having((d) => d.value, 'value', 42),
      isA<DiagnosticsProperty<void>>()
          .having((d) => d.name, 'name', 'b')
          .having((d) => d.value, 'value', '21'),
    ]);
  });

  test('noop if Diagnosticable not available', () {
    var value = non_diagnosticable.Example<int>(42, '21');

    expect(value, isNot(isA<DiagnosticableTree>()));
    expect(value.toString(), 'Example<int>(a: 42, b: 21)');

    value = non_diagnosticable.Example.named(42);
    expect(value, isNot(isA<DiagnosticableTree>()));
    expect(value.toString(), 'Example<int>.named(c: 42)');
  });

  test('timeslot is not Diagnosticable', () {
    final timeslot = TimeSlot(
      start: const TimeOfDay(hour: 10, minute: 30),
      end: const TimeOfDay(hour: 12, minute: 45),
    );

    expect(timeslot, isNot(isA<DiagnosticableTree>()));
  });

  test('with double quotes', () {
    final temp = const WithDoubleQuotes();
    expect(temp, isNot(isA<DiagnosticableTree>()));
  });
}
