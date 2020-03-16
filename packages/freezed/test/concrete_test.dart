// TODO: can use mixin on main class without having an extends
// TODO: Freezed does not override concrete members
// TODO: debugFillProperties still works if base class is Diagnosticable
// TODO: can use `@With` to have union-specific interfaces
// TODO: `@With` has the same rules as previously mentionned

import 'package:test/test.dart';

import 'integration/concrete.dart';

void main() {
  test('EmptyExtends', () {
    expect(
      EmptyExtends(42),
      isA<Empty>()
          .having((source) => (source as EmptyExtends).value, 'value', 42),
    );
  });
  test('Concrete', () {
    expect(
      Concrete(42),
      isA<A>()
          .having((source) => source.method(), 'method', 42)
          .having((source) => source.value, 'value', 42),
    );
  });
  test('can have const', () {
    const ConstConcrete();
  });
  test('MixedIn', () {
    expect(MixedIn().method(), 42);
  });
}
