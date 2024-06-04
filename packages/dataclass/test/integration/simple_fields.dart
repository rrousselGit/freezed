import 'package:dataclass/dataclass.dart';

@Data()
class Simple {
  final int foo;
  final String bar;
  final double initialized = 42;
}

@Data(constructor: 'custom')
class Named {
  final int foo;
}

class SuperBase {
  SuperBase.custom(int value) : value = value * 2;
  final int value;
}

@Data(superCtor: 'custom')
class Super extends SuperBase {
  final int foo;
}

// TODO uncomment once "super.field" works in augmentation constructors.
// @Data()
// sealed class ExtendsBase {
//   final int a;
// }

// @Data()
// class Extends extends ExtendsBase {
//   final int b;
// }

// TODO augmentations are confused once again
// @Data()
// sealed class ImplementsBase {
//   final int a;
// }

// @Data()
// class Implements implements ImplementsBase {
//   final int b;
// }
