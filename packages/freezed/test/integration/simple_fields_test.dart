import 'package:freezed/freezed.dart';

@Freezed()
class Simple {
  final int foo;
  final String bar;
}

@Freezed(constructor: 'custom')
class Named {
  final int foo;
}

class SuperBase {
  SuperBase.custom(int value) : value = value * 2;
  final int value;
}

@Freezed(superCtor: 'custom')
class Super extends SuperBase {
  final int foo;
}
