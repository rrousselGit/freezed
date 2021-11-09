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

  test('custom equals with mixin and union', () {
    expect(
      EqualsWithUnionMixin.first(1) != EqualsWithUnionMixin.second('2'),
      isTrue,
    );

    expect(
      EqualsWithUnionMixin.first(1) == EqualsWithUnionMixin.first(1),
      isFalse,
    );

    expect(
      EqualsWithUnionMixin.second('1') == EqualsWithUnionMixin.second('2'),
      isTrue,
    );
  });

  test('custom equals with base class and union', () {
    expect(
      EqualsWithUnionExtends.first(1) != EqualsWithUnionExtends.second('2'),
      isTrue,
    );

    expect(
      EqualsWithUnionExtends.first(1) == EqualsWithUnionExtends.first(1),
      isFalse,
    );

    expect(
      EqualsWithUnionExtends.second('1') == EqualsWithUnionExtends.second('2'),
      isTrue,
    );
  });
}
