import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/diagnosticable.dart' as diagnosticable;
import 'package:example/non_diagnosticable.dart' as non_diagnosticable;

void main() {
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

    expect(properties.properties.length, 3);
    expect(
      properties.properties.first,
      isA<DiagnosticsProperty>().having((d) => d.name, 'name', 'type').having((d) => d.value, 'value', 'Example<int>'),
    );
    expect(
      properties.properties[1],
      isA<DiagnosticsProperty>().having((d) => d.name, 'name', 'a').having((d) => d.value, 'value', 42),
    );
    expect(
      properties.properties.last,
      isA<DiagnosticsProperty>().having((d) => d.name, 'name', 'b').having((d) => d.value, 'value', '21'),
    );
  });
  test('noop if Diagnosticable not available', () {
    var value = non_diagnosticable.Example<int>(42, '21');

    expect(value, isNot(isA<DiagnosticableTree>()));
    expect(value.toString(), 'Example<int>(a: 42, b: 21)');

    value = non_diagnosticable.Example.named(42);
    expect(value, isNot(isA<DiagnosticableTree>()));
    expect(value.toString(), 'Example<int>.named(c: 42)');
  });
}
