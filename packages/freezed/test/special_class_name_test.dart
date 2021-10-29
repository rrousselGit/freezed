// ignore_for_file: prefer_const_constructors, omit_local_variable_types
import 'package:test/test.dart';

import 'integration/special_class_name.dart';

Future<void> main() async {
  test('toString will properly handle dollar signs', () {
    final value = Class$With$Special$Name(a: 'a', b: 1);

    expect(
      value.toString(),
      r'Class$With$Special$Name(a: a, b: 1)',
    );
  });
}
