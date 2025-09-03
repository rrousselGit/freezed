// ignore_for_file: prefer_const_constructors, omit_local_variable_types
import 'package:analyzer/dart/analysis/results.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'common.dart';
import 'integration/deep_copy.dart';
import 'integration/deep_copy2.dart';
import 'integration/generic.dart'
    show AnyGeneric, NullableGeneric, NonNullableGeneric;
import 'integration/single_class_constructor.dart' show Dynamic;

void main() {
  test('cross-library deep copy', () {
    final newValue = Country().copyWith.president?.assistant?.call();
    expect(newValue, isNull);
  });

  test('has no issue', () async {
    final main = await resolveSources(
      {'freezed|test/integration/deep_copy.dart': useAssetReader},
      (r) => r.libraries.firstWhere(
        (element) =>
            element.firstFragment.source.toString().contains('deep_copy'),
      ),
    );

    final errorResult =
        await main.session.getErrors(
              '/freezed/test/integration/deep_copy.freezed.dart',
            )
            as ErrorsResult;

    expect(errorResult.diagnostics, isEmpty);
  });

  test('has no issue #2', () async {
    final main = await resolveSources(
      {'freezed|test/integration/deep_copy2.dart': useAssetReader},
      (r) => r.libraries.firstWhere(
        (element) =>
            element.firstFragment.source.toString().contains('deep_copy2'),
      ),
    );

    final errorResult =
        await main.session.getErrors(
              '/freezed/test/integration/deep_copy2.freezed.dart',
            )
            as ErrorsResult;

    expect(errorResult.diagnostics, isEmpty);
  });

  test('handles null', () {
    Company company = Company(director: null, name: 'Google');

    expect(
      () => company.copyWith.director!.assistant!(name: 'John'),
      throwsA(isA<TypeError>()),
    );

    expect(company.copyWith.director?.assistant!(name: 'John'), null);

    company = Company(
      director: Director(assistant: null, name: 'John'),
      name: 'Google',
    );

    expect(company.copyWith.director!.assistant?.call(name: 'John'), isNull);
    expect(
      () => company.copyWith.director!.assistant!(name: 'John'),
      throwsA(isA<TypeError>()),
    );

    expect(
      Dynamic(foo: 42, bar: 21).copyWith(foo: null, bar: null),
      Dynamic(foo: null, bar: null),
    );
    expect(Dynamic(foo: 42, bar: 21).copyWith(), Dynamic(foo: 42, bar: 21));

    expect(AnyGeneric<int?>(42).copyWith(value: null), AnyGeneric<int?>(null));
    expect(AnyGeneric<int?>(42).copyWith(), AnyGeneric<int?>(42));

    expect(
      NullableGeneric<int?>(42).copyWith(value: null),
      NullableGeneric<int?>(null),
    );
    expect(NullableGeneric<int?>(42).copyWith(), NullableGeneric<int?>(42));

    expect(
      NonNullableGeneric<int>(42).copyWith(value: 21),
      NonNullableGeneric<int>(21),
    );
    expect(NonNullableGeneric<int>(42).copyWith(), NonNullableGeneric<int>(42));
  });

  group('DeepGeneric', () {
    test('copyWith parameters are generic', () async {
      Generic<int> generic = Generic(42, 042);
      DeepGeneric<int> deep = DeepGeneric(generic, 42);

      expect(
        deep.copyWith(value: Generic(42, 042)),
        DeepGeneric(Generic(42, 042), 42),
      );

      expect(deep.copyWith(second: 21), DeepGeneric(Generic(42, 042), 21));

      expect(deep.copyWith.value(value: 21), DeepGeneric(Generic(21, 042), 42));

      expect(
        deep.copyWith.value(value2: 021),
        DeepGeneric(Generic(42, 021), 42),
      );

      const value =
          'DeepGeneric<int> value = DeepGeneric(Generic(42, 42), 42);';

      await expectLater(
        compile('''
import 'deep_copy.dart';

void main() {
  $value
  DeepGeneric<int> clone = value.copyWith(value: Generic(42, 42));
}
'''),
        completes,
      );

      await expectLater(
        compile('''
import 'deep_copy.dart';

void main() {
  $value
  DeepGeneric<int> clone = value.copyWith(value: Generic('42', '42'));
}
'''),
        throwsCompileError,
      );

      await expectLater(
        compile('''
import 'deep_copy.dart';

void main() {
  $value
  DeepGeneric<int> clone = value.copyWith.value(value: 42);
}
'''),
        completes,
      );

      await expectLater(
        compile('''
import 'deep_copy.dart';

void main() {
  $value
  DeepGeneric<int> clone = value.copyWith.value(value: '42');
}
'''),
        throwsCompileError,
      );
    });
  });

  group('Union', () {
    group('copyWith', () {
      test('from base class can access only shared property', () async {
        final valueCode =
            'final value = Union.first(Assistant(), Assistant());';
        await expectLater(
          compile('''
import 'deep_copy.dart';

void main() {
  $valueCode
  Union second = value.copyWith(shared: Assistant());
}
'''),
          completes,
        );

        await expectLater(
          compile('''
import 'deep_copy.dart';

void main() {
  $valueCode
  Union second = value.copyWith(first: Assistant());
}
'''),
          throwsCompileError,
        );

        await expectLater(
          compile('''
import 'deep_copy.dart';

void main() {
  $valueCode
  Union second = value.copyWith(second: Assistant());
}
'''),
          throwsCompileError,
        );
      });

      test('from subclass can access uncommon properties', () async {
        final firstCode = 'final value = UnionFirst(Assistant(), Assistant());';
        final secondCode =
            'final value = UnionSecond(Assistant(), Assistant());';

        await expectLater(
          compile('''
import 'deep_copy.dart';

void main() {
  $firstCode
  UnionFirst second = value.copyWith(shared: Assistant(), first: Assistant());
}
'''),
          completes,
        );

        await expectLater(
          compile('''
import 'deep_copy.dart';

void main() {
  $firstCode
  UnionFirst second = value.copyWith(second: Assistant());
}
'''),
          throwsCompileError,
        );

        await expectLater(
          compile('''
import 'deep_copy.dart';

void main() {
  $secondCode
  UnionSecond second = value.copyWith(shared: Assistant(), second: Assistant());
}
'''),
          completes,
        );

        await expectLater(
          compile('''
import 'deep_copy.dart';

void main() {
  $secondCode
  UnionSecond second = value.copyWith(first: Assistant());
}
'''),
          throwsCompileError,
        );
      });
    });

    test('UnionFirst.copyWith.something', () async {
      final valueCode = 'final value = UnionFirst(Assistant(), Assistant());';

      final assistant = Assistant(name: 'John', age: 21);
      UnionFirst value = UnionFirst(assistant, assistant);

      expect(
        value.copyWith.first(age: 42),
        UnionFirst(assistant, Assistant(name: 'John', age: 42)),
      );
      expect(
        value.copyWith.shared(age: 42),
        UnionFirst(Assistant(name: 'John', age: 42), assistant),
      );

      // test that the copyWith returns a UnionFirst
      value = value.copyWith.shared(age: 42);
      value = value.copyWith.first(age: 42);

      await expectLater(
        compile('''
import 'deep_copy.dart';

void main() {
  $valueCode
  UnionFirst second = value.copyWith.shared(age: 42);
}
'''),
        completes,
      );

      await expectLater(
        compile('''
import 'deep_copy.dart';

void main() {
  $valueCode
  UnionFirst second = value.copyWith.first(age: 42);
}
'''),
        completes,
      );

      await expectLater(
        compile('''
import 'deep_copy.dart';

void main() {
  $valueCode
  UnionFirst second = value.copyWith.second(age: 42);
}
'''),
        throwsCompileError,
      );
    });

    test('UnionSecond.copyWith.something', () async {
      final valueCode = 'final value = UnionSecond(Assistant(), Assistant());';

      final assistant = Assistant(name: 'John', age: 21);
      UnionSecond value = UnionSecond(assistant, assistant);

      expect(
        value.copyWith.second(age: 42),
        UnionSecond(assistant, Assistant(name: 'John', age: 42)),
      );
      expect(
        value.copyWith.shared(age: 42),
        UnionSecond(Assistant(name: 'John', age: 42), assistant),
      );

      // test that the copyWith returns a UnionSecond
      value = value.copyWith.shared(age: 42);
      value = value.copyWith.second(age: 42);

      await expectLater(
        compile('''
import 'deep_copy.dart';

void main() {
  $valueCode
  UnionSecond second = value.copyWith.shared(age: 42);
}
'''),
        completes,
      );

      await expectLater(
        compile('''
import 'deep_copy.dart';

void main() {
  $valueCode
  UnionSecond second = value.copyWith.second(age: 42);
}
'''),
        completes,
      );

      await expectLater(
        compile('''
import 'deep_copy.dart';

void main() {
  $valueCode
  UnionSecond second = value.copyWith.first(age: 42);
}
'''),
        throwsCompileError,
      );
    });
  });

  group('NoCommonProperty', () {
    group('copyWith', () {
      test('cannot read copyWith from base class', () async {
        await expectLater(
          compile(r'''
import 'deep_copy.dart';

void main() {
  final value = NoCommonProperty();
}
'''),
          completes,
        );

        await expectLater(
          compile(r'''
import 'deep_copy.dart';

void main() {
  final value = NoCommonProperty();
  var second = value.copyWith;
}
'''),
          throwsCompileError,
        );
      });

      test('NoCommonProperty.assistant has type-safe copyWith', () async {
        await expectLater(
          compile(r'''
import 'deep_copy.dart';

void main() {
  final value = NoCommonPropertyAssistant(Assistant());
  NoCommonPropertyAssistant copy = value.copyWith(assistant: Assistant());
}
'''),
          completes,
        );

        await expectLater(
          compile(r'''
import 'deep_copy.dart';

void main() {
  final value = NoCommonProperty.assistant!(Assistant());
  NoCommonPropertyAssistant copy = value.copyWith(assistant: Assistant());
}
'''),
          throwsCompileError,
        );
      });

      test('NoCommonProperty() has no copyWith', () async {
        await expectLater(
          compile(r'''
import 'deep_copy.dart';

void main() {
  NoCommonPropertyEmpty value = NoCommonPropertyEmpty();
}
'''),
          completes,
        );

        await expectLater(
          compile(r'''
import 'deep_copy.dart';

void main() {
  NoCommonPropertyEmpty value = NoCommonPropertyEmpty();
  var second = value.copyWith;
}
'''),
          throwsCompileError,
        );
      });
    });

    test(
      'NoCommonPropertyAssistant.copyWith.assistant returns NoCommonPropertyAssistant',
      () {
        NoCommonPropertyAssistant value = NoCommonPropertyAssistant(
          Assistant(age: 42, name: 'John'),
        );

        value = value.copyWith.assistant(age: 21);

        expect(
          value,
          NoCommonPropertyAssistant(Assistant(age: 21, name: 'John')),
        );
      },
    );

    test('NoCommonPropertyAssistant can copy assistant', () {
      NoCommonPropertyAssistant value = NoCommonPropertyAssistant(
        Assistant(age: 42, name: 'John'),
      );

      expect(
        value.copyWith.assistant(age: 21),
        NoCommonPropertyAssistant(Assistant(age: 21, name: 'John')),
      );

      expect(
        value.copyWith.assistant(name: 'Smith'),
        NoCommonPropertyAssistant(Assistant(age: 42, name: 'Smith')),
      );
    });
  });

  test('DeepWithManualField', () {
    final value = DeepWithManualField(ManualField(42));

    expect(
      value.copyWith.manual(value: 21),
      DeepWithManualField(ManualField(21)),
    );
  });

  group('Company', () {
    group('From subclass, copyWith parameters are not typed as Object', () {
      test('Company.copyWith', () async {
        await expectLater(
          compile(r'''
import 'deep_copy.dart';

void main() {
  CompanySubclass company = CompanySubclass();
  CompanySubclass second = company.copyWith(name: 'Larry');
}
'''),
          completes,
        );

        await expectLater(
          compile(r'''
import 'deep_copy.dart';

void main() {
  CompanySubclass company = CompanySubclass();
  CompanySubclass second = company.copyWith(name: 42);
}
'''),
          throwsCompileError,
        );
      });
      test('Company.copyWith.director', () async {
        await expectLater(
          compile(r'''
import 'deep_copy.dart';

void main() {
  CompanySubclass company = CompanySubclass();
  CompanySubclass second = company.copyWith.director!(name: 'Larry');
}
'''),
          completes,
        );

        await expectLater(
          compile(r'''
import 'deep_copy.dart';

void main() {
  CompanySubclass company = CompanySubclass();
  CompanySubclass second = company.copyWith.director!(name: 42);
}
'''),
          throwsCompileError,
        );
      });

      test('Company.copyWith.director!.assistant', () async {
        await expectLater(
          compile(r'''
import 'deep_copy.dart';

void main() {
  CompanySubclass company = CompanySubclass();
  CompanySubclass second = company.copyWith.director!.assistant!(name: 'Larry');
}
'''),
          completes,
        );

        await expectLater(
          compile(r'''
import 'deep_copy.dart';

void main() {
  CompanySubclass company = CompanySubclass();
  CompanySubclass second = company.copyWith.director!.assistant!(name: 42);
}
'''),
          throwsCompileError,
        );
      });
    });

    group('From interface, copyWith parameters are not typed as Object', () {
      test('Company.copyWith', () async {
        await expectLater(
          compile(r'''
import 'deep_copy.dart';

void main() {
  Company company = Company();
  Company second = company.copyWith(name: 'Larry');
}
'''),
          completes,
        );

        await expectLater(
          compile(r'''
import 'deep_copy.dart';

void main() {
  Company company = Company();
  Company second = company.copyWith(name: 42);
}
'''),
          throwsCompileError,
        );
      });

      test('Company.copyWith.director', () async {
        await expectLater(
          compile(r'''
import 'deep_copy.dart';

void main() {
  Company company = Company();
  Company second = company.copyWith.director!(name: 'Larry');
}
'''),
          completes,
        );

        await expectLater(
          compile(r'''
import 'deep_copy.dart';

void main() {
  Company company = Company();
  Company second = company.copyWith.director!(name: 42);
}
'''),
          throwsCompileError,
        );
      });

      test('Company.copyWith.director!.assistant', () async {
        await expectLater(
          compile(r'''
import 'deep_copy.dart';

void main() {
  Company company = Company();
  Company second = company.copyWith.director!.assistant!(name: 'Larry');
}
'''),
          completes,
        );

        await expectLater(
          compile(r'''
import 'deep_copy.dart';

void main() {
  Company company = Company();
  Company second = company.copyWith.director!.assistant!(name: 42);
}
'''),
          throwsCompileError,
        );
      });
    });

    test('Simple', () {
      final company = Company(
        name: 'Google',
        director: Director(
          name: 'Larry Page',
          assistant: Assistant(name: 'John Smith', age: 42),
        ),
      );

      expect(
        company.copyWith(name: 'Kin and Carta'),
        Company(name: 'Kin and Carta', director: company.director),
      );

      expect(
        company.copyWith.director!(name: 'Sundar Pichai'),
        Company(
          name: 'Google',
          director: Director(
            name: 'Sundar Pichai',
            assistant: company.director!.assistant,
          ),
        ),
      );

      expect(
        company.copyWith.director!(
          assistant: Assistant(name: 'John Doe', age: 21),
        ),
        Company(
          name: 'Google',
          director: Director(
            name: 'Larry Page',
            assistant: Assistant(name: 'John Doe', age: 21),
          ),
        ),
      );

      expect(
        company.copyWith.director!.assistant!(name: 'John Doe'),
        Company(
          name: 'Google',
          director: Director(
            name: 'Larry Page',
            assistant: Assistant(name: 'John Doe', age: 42),
          ),
        ),
      );
    });
  });

  test('warns about unused copyWith result', () async {
    final main = await resolveSources(
      {
        'freezed|test/integration/main.dart': r'''
library main;
import 'deep_copy.dart';

void main() {
  Company company = Company();
  company.copyWith.director!(name: 'Larry');
  company.copyWith(name: 'MyCompany');
}
''',
      },
      (r) => r.libraries.firstWhere(
        (element) =>
            element.firstFragment.source.toString().contains('deep_copy'),
      ),
      readAllSourcesFromFilesystem: true,
    );

    final errorResult =
        await main.session.getErrors('/freezed/test/integration/main.dart')
            as ErrorsResult;

    expect(errorResult.diagnostics.map((e) => e.diagnosticCode.name), [
      'UNUSED_RESULT',
      'UNUSED_RESULT',
    ]);
  });
}
