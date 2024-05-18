import 'package:freezed/freezed.dart';

@Freezed()
class Simple {
  final int foo;
  final String bar;
  final double initialized = 42;
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

// TODO uncomment once "super.field" works in augmentation constructors.
// @Freezed()
// sealed class ExtendsBase {
//   final int a;
// }

// @Freezed()
// class Extends extends ExtendsBase {
//   final int b;
// }

// TODO augmentations are confused once again
// @Freezed()
// sealed class ImplementsBase {
//   final int a;
// }

// @Freezed()
// class Implements implements ImplementsBase {
//   final int b;
// }
