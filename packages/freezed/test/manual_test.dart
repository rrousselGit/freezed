import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test/test.dart';

part 'manual_test.freezed.dart';
part 'manual_test.g.dart';

// https://github.com/rrousselGit/freezed/issues/1216
@freezed
class Product with _$Product {
  final int price;
  const Product(this.price);
}

// https://github.com/rrousselGit/freezed/issues/1216
@freezed
class CartLine with _$CartLine {
  final Product product;
  final int amount;

  CartLine({required this.product, int? defaultAmount})
    : amount = defaultAmount ?? product.price;
}

// Regression for https://github.com/rrousselGit/freezed/issues/1168
@freezed
class Person with _$Person {
  const Person({required this.firstName, required this.lastName});

  final String firstName;
  final String lastName;

  String get fullName => '$firstName $lastName';
}

@freezed
@JsonSerializable()
class JsonManual with _$JsonManual {
  JsonManual(this.a);
  factory JsonManual.fromJson(Map<String, dynamic> json) =>
      _$JsonManualFromJson(json);

  final int a;

  Map<String, dynamic> toJson() => _$JsonManualToJson(this);
}

@freezed
class ManualWithBothDefault with _$ManualWithBothDefault {
  ManualWithBothDefault._(String this.b) : a = null;
  ManualWithBothDefault(int this.a) : b = null;

  final int? a;
  final String? b;
}

@freezed
class ManualWithPrivateDefault with _$ManualWithPrivateDefault {
  ManualWithPrivateDefault.b(String this.b) : a = null;
  ManualWithPrivateDefault._(int this.a) : b = null;

  final int? a;
  final String? b;
}

@freezed
class ManualWithDefault with _$ManualWithDefault {
  ManualWithDefault.b(String this.b) : a = null;
  ManualWithDefault(int this.a) : b = null;

  final int? a;
  final String? b;
}

@freezed
class ManualWithoutDefault with _$ManualWithoutDefault {
  ManualWithoutDefault.a(int this.a) : b = null;
  ManualWithoutDefault.b(String this.b) : a = null;

  final int? a;
  final String? b;
}

@freezed
class ManualWithoutDefault2 with _$ManualWithoutDefault2 {
  ManualWithoutDefault2.b(String this.b) : a = null;
  ManualWithoutDefault2.a(int this.a) : b = null;

  final int? a;
  final String? b;
}

void main() {
  group('CartLine', () {
    test('has copyWith use default', () {
      expect(
        CartLine(product: const Product(42))
            .copyWith(product: const Product(21)),
        CartLine(product: const Product(21)),
      );
    });
  });

  group('ManualWithBothDefault', () {
    test('has copyWith use default', () {
      expect(
        ManualWithBothDefault(42).copyWith(a: 21),
        ManualWithBothDefault(21),
      );
    });
    test('overrides ==/hashCode/toString', () {
      final manual = ManualWithBothDefault(42);
      final manual2 = ManualWithBothDefault._('foo');

      expect(manual, ManualWithBothDefault(42));
      expect(manual, isNot(ManualWithBothDefault(21)));
      expect(manual.hashCode, ManualWithBothDefault(42).hashCode);
      expect(manual.hashCode, isNot(ManualWithBothDefault(21).hashCode));
      expect(manual.toString(), 'ManualWithBothDefault(a: 42, b: null)');

      expect(manual2, ManualWithBothDefault._('foo'));
      expect(manual2, isNot(ManualWithBothDefault._('bar')));
      expect(manual2.hashCode, ManualWithBothDefault._('foo').hashCode);
      expect(manual2.hashCode, isNot(ManualWithBothDefault._('bar').hashCode));
      expect(manual2.toString(), 'ManualWithBothDefault(a: null, b: foo)');
    });
  });

  group('ManualWithPrivateDefault', () {
    test('has copyWith use _', () {
      expect(
        ManualWithPrivateDefault._(42).copyWith(a: 21),
        ManualWithPrivateDefault._(21),
      );
    });
  });

  group('ManualWithDefault', () {
    test('has copyWith use default', () {
      expect(ManualWithDefault(42).copyWith(a: 21), ManualWithDefault(21));
    });
  });

  group('ManualWithoutDefault', () {
    test('has copyWith target the first ctor', () {
      expect(
        ManualWithoutDefault.a(42).copyWith(a: 21),
        ManualWithoutDefault.a(21),
      );
    });
  });
  group('ManualWithoutDefault2', () {
    test('has copyWith target the first ctor', () {
      expect(
        ManualWithoutDefault2.a(42).copyWith(b: 'foo'),
        ManualWithoutDefault2.b('foo'),
      );
    });
  });
}
