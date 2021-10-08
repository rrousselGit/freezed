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

  test('custom equals with implements', () {
    expect(
      CustomEqualsWithImplements(name: 'a', id: 1),
      CustomEqualsWithImplements(name: 'a', id: 2),
    );
  });

  test('custom equals in unions with implements', () {
    expect(
      CustomEqualsWithUnionAndImplements.first(name: 'a', id: 1),
      CustomEqualsWithUnionAndImplements.second(name: 'a'),
    );

    expect(
      CustomEqualsWithUnionAndImplements.second(name: 'a', id: 5) ==
          CustomEqualsWithUnionAndImplements.third(name: 'a'),
      isFalse,
    );
  });
}
