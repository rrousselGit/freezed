import 'package:test/test.dart';

import 'integration/extend.dart';

void main() {
  test('Calls super', () {
    expect(Subclass2(1, 2), Subclass2(1, 2));
    expect(Subclass2(1, 1), isNot(Subclass2(1, 2)));
    expect(Subclass2(2, 2), isNot(Subclass2(1, 2)));

    expect(Subclass2(1, 2).hashCode, Subclass2(1, 2).hashCode);
    expect(Subclass2(1, 1).hashCode, isNot(Subclass2(1, 2).hashCode));
    expect(Subclass2(2, 2).hashCode, isNot(Subclass2(1, 2).hashCode));
  });
}
