// ignore_for_file: omit_local_variable_types

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build_test/build_test.dart';
import 'package:expect_error/expect_error.dart';
import 'package:test/test.dart';

import 'integration/common_types.dart';

Future<void> main() async {
  final library = await Library.parseFromStacktrace();

  test('has no issue', () async {
    final main = await resolveSources(
      {
        'freezed|test/integration/common_types.dart': useAssetReader,
      },
      (r) => r.libraries.firstWhere(
          (element) => element.source.toString().contains('common_types')),
    );

    final errorResult = await main.session
            .getErrors('/freezed/test/integration/common_types.freezed.dart')
        as ErrorsResult;

    expect(errorResult.errors, isEmpty);
  });

  group('CommonSuperSubtype', () {
    test('has the common properties available', () {
      const value = CommonSuperSubtype('a', 1337, 42.24);
      String? a = value.a;
      expect(a, 'a');
      num b = value.b;
      expect(b, 1337);
      num c = value.c;
      expect(c, 42.24);

      const value2 = CommonSuperSubtype.named('b', 12.34, 56.78);
      expect(value2.a, 'b');
      expect(value2.b, 12.34);
      expect(value2.c, 56.78);
    });
  });

  group('GeneratedDependency', () {
    test('should have getters available', () async {
      final param = const GeneratedDependency(Dependency0());
      expect(param.a, isA<Dependency0>());
    });
  });

  group('CommonInterfaceSupertype', () {
    test('has common param available', () {
      var value = const CommonInterfaceSupertype(CommonInterfaceB());
      expect(value.param, isA<CommonInterfaceB>());
    });

    test('does not have copy available', () async {
      await expectLater(library.withCode('''
import 'integration/common_types.dart';

void main() {
  CommonInterfaceSupertype param = CommonInterfaceSupertype(CommonInterfaceB());
  // expect-error: UNDEFINED_METHOD
  param.copyWith();
}
'''), compiles);
    });
  });

  group('CommonTypedefs', () {
    test('generates correct typedefs', () async {
      final main = await resolveSources(
        {
          'freezed|test/integration/common_types.dart': useAssetReader,
        },
        (r) => r.libraries.firstWhere(
            (element) => element.source.toString().contains('common_types')),
      );

      var freezedClass = main.topLevelElements
          .whereType<MixinElement>()
          .firstWhere((element) => element.displayName == r'_$CommonTypedefs');

      var a = freezedClass.getGetter('a')!.returnType;
      expect(a, isA<FunctionType>());
      expect(a.alias!.element.name, equals('ExternalTypedef'));

      var b = freezedClass.getGetter('b')!.returnType;
      expect(b, isA<FunctionType>());
      expect(b.alias!.element.name, equals('ExternalTypedefTwo'));

      var c = freezedClass.getGetter('c')!.returnType;
      expect(c, isA<InterfaceType>());
      expect(c.element!.name, equals('String'));

      var e = freezedClass.getGetter('genericTypedef')!.returnType;
      expect(e, isA<FunctionType>());
      expect(e.alias!.element.name, equals('GenericTypedef'));
      expect(e.alias!.typeArguments.toString(), equals('[int, bool]'));
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
      await expectLater(library.withCode('''
import 'integration/common_types.dart';

void main() {
  final param = CommonUnfreezed.one(a: 42, b: 3.14);
  // expect-error: ASSIGNMENT_TO_FINAL_NO_SETTER
  param.a = 42.24;
  // OK since all union cases are typed the same
  param.b = 42;
}
'''), compiles);
    });
  });
}
