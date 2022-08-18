// ignore_for_file: prefer_const_constructors, omit_local_variable_types, deprecated_member_use_from_same_package, cascade_invocations
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'common.dart';
import 'integration/common_types.dart';

void main() {
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
      var value = CommonSuperSubtype('a', 1337, 42.24);
      expect(value.a, 'a');
      expect(value.b, 1337);
      expect(value.c, 42.24);

      value = CommonSuperSubtype.named('b', 12.34, 56.78);
      expect(value.a, 'b');
      expect(value.b, 12.34);
      expect(value.c, 56.78);
    });

    test('copy has all with common subtypes available', () {
      var value = CommonSuperSubtype('a', 1337, 42);
      expect(value.a, 'a');

      value = value.copyWith(a: 'b', c: 24.42);
      expect(value.a, 'b');
      expect(value.c, 24.42);
    });

    test(
      'copy has shared params with common subtypes available',
      () async {
        await expectLater(compile(r'''
import 'common_types.dart';

void main() {
  final param = CommonSuperSubtype('a', 1337, 42);
  param.copyWith(a: '2');
}
'''), completes);

        await expectLater(compile(r'''
import 'common_types.dart';

void main() {
  final param = CommonSuperSubtype('a', 1337, 42);
  param.copyWith(c: 12.34);
}
'''), completes);

        await expectLater(compile(r'''
import 'common_types.dart';

void main() {
  final param = CommonSuperSubtype('a', 1337, 42);
  param.copyWith(c: 24.42);
}
'''), completes);

        await expectLater(compile(r'''
import 'common_types.dart';

void main() {
  final param = CommonSuperSubtype('a', 1337, 42);
  param.copyWith(a: null);
}
'''), throwsCompileError);

        await expectLater(compile(r'''
import 'common_types.dart';

void main() {
  final param = CommonSuperSubtype('a', 1337, 42);
  param.copyWith(c: null);
}
'''), throwsCompileError);
      },
    );

    test(
      'copy does not have shared params without common subtype available',
      () async {
        await expectLater(compile(r'''
import 'common_types.dart';

void main() {
  final param = CommonSuperSubtype('a', 1337, 42);
  param.copyWith(b: 42);
}
'''), throwsCompileError);

        await expectLater(compile(r'''
import 'common_types.dart';

void main() {
  final param = CommonSuperSubtype('a', 1337, 42);
  param.copyWith(b: null);
}
'''), throwsCompileError);
      },
    );
  });

  group('GeneratedDependency', () {
    test('should have getters available', () async {
      final param = GeneratedDependency(Dependency0());
      expect(param.a, isA<Dependency0>());
    });
  });

  group('CommonInterfaceSupertype', () {
    test('has common param available', () {
      var value = CommonInterfaceSupertype(CommonInterfaceB());
      expect(value.param, isA<CommonInterfaceB>());
    });

    test('does not have copy available', () async {
      await expectLater(compile(r'''
import 'common_types.dart';

void main() {
  CommonInterfaceSupertype param =
    CommonInterfaceSupertype(CommonInterfaceB());
  param.copyWith;
}
'''), throwsCompileError);
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
          .whereType<ClassElement>()
          .firstWhere((element) => element.displayName == r'_$CommonTypedefs');

      var a = freezedClass.getGetter('a')!.returnType;
      expect(a, isA<FunctionType>());
      expect(a.alias!.element.name, equals('ExternalTypedef'));

      var b = freezedClass.getGetter('b')!.returnType;
      expect(b, isA<FunctionType>());
      expect(b.alias!.element.name, equals('ExternalTypedefTwo'));

      var c = freezedClass.getGetter('c')!.returnType;
      expect(c, isA<InterfaceType>());
      expect(c.element2!.name, equals('String'));

      var e = freezedClass.getGetter('genericTypedef')!.returnType;
      expect(e, isA<FunctionType>());
      expect(e.alias!.element.name, equals('GenericTypedef'));
      expect(e.alias!.typeArguments.toString(), equals('[int, bool]'));
    });
  });

  group('CommonTypeNestedContainer', () {
    test(
      'nested copyWith with a default value that is not a subtype of the common subtype',
      () {
        var commonTypeContainer = CommonTypeNestedContainer(
          internal: CommonTypeNested.two(a: 0.0),
        );
        commonTypeContainer = commonTypeContainer.copyWith.internal();
        expect(commonTypeContainer.internal.a, 0.0);

        commonTypeContainer = commonTypeContainer.copyWith.internal(a: 12);
        expect(commonTypeContainer.internal.a, 12);
      },
    );
  });

  group('CommonUnfreezed', () {
    test('should have common getters available', () {
      var value = CommonUnfreezed.one(a: 42, b: 3.14);
      expect(value.a, 42);
      expect(value.b, 3.14);
    });

    test('should have common setters available', () {
      var value = CommonUnfreezed.one(a: 42, b: 3.14);
      value.b = 42.24;
      expect(value.b, 42.24);
    });

    test('should not have setters for getters with different type', () async {
      await expectLater(compile(r'''
import 'common_types.dart';

void main() {
  final param = CommonUnfreezed.one(a: 42, b: 3.14);
  param.a = 42.24;
}
'''), throwsCompileError);
      await expectLater(compile(r'''
import 'common_types.dart';

void main() {
  final param = CommonUnfreezed.one(a: 42, b: 3.14);
  param.b = 42.24;
}
'''), completes);
    });
  });
}
