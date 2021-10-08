import 'package:test/test.dart';
import 'integration/custom_equals.dart';

void main() {
  test('simple custom equals', () {
    expect(CustomEquals(name: 'a', id: 1), CustomEquals(name: 'a', id: 2));
  });

  test('custom equals in unions', () {
    expect(
      CustomEqualsFirst(name: 'a', id: 1),
      CustomEqualsSecond(name: 'a', active: true),
    );
  });

}
