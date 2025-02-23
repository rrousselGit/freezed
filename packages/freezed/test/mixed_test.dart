import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test/test.dart';

part 'mixed_test.freezed.dart';

@freezed
sealed class Mixed with _$Mixed {
  Mixed._();
  factory Mixed.a(num common, int value, String a) = MixedA;
  factory Mixed.b(num common, double value, int b) = FreezedImplements;
  factory Mixed.c(num common, double value, bool c) = ManualClass;
  factory Mixed.d(num common, double value, int d) = FreezedExtends;
}

@freezed
class FreezedImplements with _$FreezedImplements implements Mixed {
  FreezedImplements(this.common, this.value, this.b);

  @override
  final num common;
  @override
  final double value;
  @override
  final int b;
}

class ManualClass extends Mixed {
  ManualClass(this.common, this.value, this.c) : super._();

  @override
  final num common;
  @override
  final double value;
  final bool c;
}

@freezed
class FreezedExtends extends Mixed with _$FreezedExtends {
  FreezedExtends(this.common, this.value, this.d) : super._();

  @override
  final num common;
  @override
  final double value;
  @override
  final int d;
}

@freezed
sealed class DiamondA with _$DiamondA {
  factory DiamondA(int common) = DiamondLeaf;
}

@freezed
sealed class DiamondB with _$DiamondB {
  factory DiamondB(int common) = DiamondLeaf;
}

@freezed
sealed class DiamondLeaf with _$DiamondLeaf implements DiamondA, DiamondB {
  factory DiamondLeaf(int common) = _DiamondLeaf;
}

void main() {
  group('Mixed', () {
    test('a', () {
      final object = Mixed.a(42, 21, 'a');
      expect(object, isA<MixedA>());
      expect(object.toString(), 'Mixed.a(common: 42, value: 21, a: a)');
    });

    test('b', () {
      final object = Mixed.b(42, 21, 42);
      expect(object, isA<FreezedImplements>());
      expect(
        object.toString(),
        'FreezedImplements(common: 42, value: 21.0, b: 42)',
      );
    });

    test('c', () {
      final object = Mixed.c(42, 21, true);
      expect(object, isA<ManualClass>());
      expect(object.toString(), 'Mixed(common: 42, value: 21.0)');
    });

    test('d', () {
      final object = Mixed.d(42, 21, 42);
      expect(object, isA<FreezedExtends>());
      expect(
        object.toString(),
        'FreezedExtends(common: 42, value: 21.0, d: 42)',
      );
    });
  });
}
