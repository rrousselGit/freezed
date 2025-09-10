// ignore_for_file: omit_local_variable_types, unused_local_variable

import 'package:analyzer/dart/analysis/results.dart';
import 'package:build_test/build_test.dart';
import 'package:expect_error/expect_error.dart';
import 'package:test/test.dart';

import 'integration/common_types.dart';

Future<void> main() async {
  final library = await Library.parseFromStacktrace();

  test('has no issue', () async {
    final main = await resolveSources(
      {'freezed|test/integration/common_types.dart': useAssetReader},
      (r) => r.libraries.firstWhere(
        (element) =>
            element.firstFragment.source.toString().contains('common_types'),
      ),
    );

    final errorResult =
        await main.session.getErrors(
              '/freezed/test/integration/common_types.freezed.dart',
            )
            as ErrorsResult;

    expect(errorResult.errors, isEmpty);
  });

  group('CommonSuperSubtype', () {
    test('on the shared interface, has the common properties available', () {
      const value = CommonSuperSubtype(
        nullabilityDifference: 42,
        typeDifference: 21,
      );
      int? nullabilityDifference = value.nullabilityDifference;
      num typeDifference = value.typeDifference;

      expect(value.nullabilityDifference, 42);
      expect(value.typeDifference, 21);

      const value2 = CommonSuperSubtype.named(
        nullabilityDifference: null,
        typeDifference: 22,
      );
      expect(value2.nullabilityDifference, null);
      expect(value2.typeDifference, 22);
    });

    test('on the subclass, properties use explicit type', () {
      const value = CommonSuperSubtype0(
        nullabilityDifference: 42,
        typeDifference: 21,
      );
      int nullabilityDifference = value.nullabilityDifference;
      int typeDifference = value.typeDifference;

      expect(value.nullabilityDifference, 42);
      expect(value.typeDifference, 21);

      const value2 = CommonSuperSubtype1(
        nullabilityDifference: null,
        typeDifference: 22,
      );
      int? nullabilityDifference2 = value2.nullabilityDifference;
      double typeDifference2 = value2.typeDifference;

      expect(value2.nullabilityDifference, null);
      expect(value2.typeDifference, 22);
    });

    test(
      'should not have getters for properties that are not shared between all unions',
      () async {
        await expectLater(
          library.withCode('''
import 'integration/common_types.dart';

void main() {
  const value = CommonSuperSubtype(
    nullabilityDifference: 42,
    typeDifference: 21,
  );
  // expect-error: UNDEFINED_GETTER
  value.unknown;
}
'''),
          compiles,
        );
      },
    );

    test('Can clone properties with nullability difference', () {
      const value = CommonSuperSubtype(
        nullabilityDifference: 42,
        typeDifference: 21,
      );

      expect(
        value.copyWith(nullabilityDifference: 84),
        const CommonSuperSubtype0(
          nullabilityDifference: 84,
          typeDifference: 21,
        ),
      );
    });

    test('Cannot clone with type mismatch', () async {
      await expectLater(
        library.withCode('''
import 'integration/common_types.dart';

void main() {
  final param = CommonSuperSubtype(
    nullabilityDifference: 42,
    typeDifference: 21,
  );
  param.copyWith(
    // Since not all unions have a nullable property, we cannot assign "null"
    // on the shared interface.
    // expect-error: ARGUMENT_TYPE_NOT_ASSIGNABLE
    nullabilityDifference: null,
    // Since not all unions use the same type, we can't clone that property at all.
    // expect-error: UNDEFINED_NAMED_PARAMETER
    typeDifference: 42,
  );
}
'''),
        compiles,
      );
    });
  });

  group('DeepCopySharedProperties', () {
    test('Can clone properties with nullability difference', () {
      const value = DeepCopySharedProperties(
        CommonSuperSubtype0(nullabilityDifference: 42, typeDifference: 21),
      );

      expect(
        value.copyWith(
          value: const CommonSuperSubtype0(
            nullabilityDifference: 84,
            typeDifference: 21,
          ),
        ),
        const DeepCopySharedProperties(
          CommonSuperSubtype0(nullabilityDifference: 84, typeDifference: 21),
        ),
      );

      expect(
        value.copyWith.value(nullabilityDifference: 84),
        const DeepCopySharedProperties(
          CommonSuperSubtype0(nullabilityDifference: 84, typeDifference: 21),
        ),
      );
    });

    test('Cannot clone with type mismatch', () async {
      await expectLater(
        library.withCode('''
import 'integration/common_types.dart';

void main() {
  final param = DeepCopySharedProperties(
    CommonSuperSubtype(
      nullabilityDifference: 42,
      typeDifference: 21,
    ),
  );
  param.copyWith.value(
    // Since not all unions have a nullable property, we cannot assign "null"
    // on the shared interface.
    // expect-error: ARGUMENT_TYPE_NOT_ASSIGNABLE
    nullabilityDifference: null,
    // Since not all unions use the same type, we can't clone that property at all.
    // expect-error: UNDEFINED_NAMED_PARAMETER
    typeDifference: 42,
  );
}
'''),
        compiles,
      );
    });
  });

  group('CommonUnfreezed', () {
    test('should have common getters available', () {
      final value = CommonUnfreezed.one(a: 42, b: 3.14);

      num a = value.a;
      expect(a, 42);
      double b = value.b;
      expect(b, 3.14);
    });

    test('should not have setters for getters with different type', () async {
      await expectLater(
        library.withCode('''
import 'integration/common_types.dart';

void main() {
  final param = CommonUnfreezed.one(a: 42, b: 3.14);
  // expect-error: ASSIGNMENT_TO_FINAL_NO_SETTER
  param.a = 42.24;
  // OK since all union cases are typed the same
  param.b = 42;
}
'''),
        compiles,
      );
    });
  });
}
