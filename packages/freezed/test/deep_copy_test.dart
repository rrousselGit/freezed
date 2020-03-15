// ignore_for_file: prefer_const_constructors, omit_local_variable_types
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'common.dart';
import 'integration/deep_copy.dart';

void main() {
  // TODO: nullable
  // TODO: generic
  // TODO: copyWith is identical to itself if don't have descendants
  // TODO: VeryDeep.first is generic

  test('has no issue', () async {
    final main = await resolveSources(
      {
        'freezed|test/integration/deep_copy.dart': useAssetReader,
      },
      (r) => r.libraries.firstWhere(
          (element) => element.source.toString().contains('deep_copy')),
    );

    final errorResult = await main.session
        .getErrors('/freezed/test/integration/deep_copy.freezed.dart');

    expect(errorResult.errors, isEmpty);
  });

  group('Union', () {
    group('copyWith', () {
      test('from base class can access only shared property', () async {
        await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  Union value;
  Assistant assistant;
  Union second = value.copyWith(shared: assistant);
}
'''), completes);
        await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  Union value;
  Assistant assistant;
  Union second = value.copyWith(first: assistant);
}
'''), throwsCompileError);
        await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  Union value;
  Assistant assistant;
  Union second = value.copyWith(second: assistant);
}
'''), throwsCompileError);
      });

      test('from subclass can access uncommon properties', () async {
        await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  UnionFirst value;
  Assistant assistant;
  UnionFirst second = value.copyWith(shared: assistant, first: assistant);
}
'''), completes);
        await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  UnionFirst value;
  Assistant assistant;
  UnionFirst second = value.copyWith(second: assistant);
}
'''), throwsCompileError);
        await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  UnionSecond value;
  Assistant assistant;
  UnionSecond second = value.copyWith(shared: assistant, second: assistant);
}
'''), completes);
        await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  UnionSecond value;
  Assistant assistant;
  UnionSecond second = value.copyWith(first: assistant);
}
'''), throwsCompileError);
      });
    });
    test('Union.copyWith.something', () async {
      final assistant = Assistant(name: 'John', age: 21);
      Union value = Union.first(assistant, assistant);

      expect(
        value.copyWith.shared(age: 42),
        Union.first(
          Assistant(name: 'John', age: 42),
          assistant,
        ),
      );

      value = value.copyWith.shared(age: 42);

      await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  Union value;
  Union second = value.copyWith.shared(age: 42);
}
'''), completes);
      await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  Union value;
  Union second = value.copyWith.first(age: 42);
}
'''), throwsCompileError);
      await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  Union value;
  Union second = value.copyWith.second(age: 42);
}
'''), throwsCompileError);
    });
    test('UnionFirst.copyWith.something', () async {
      final assistant = Assistant(name: 'John', age: 21);
      UnionFirst value = UnionFirst(assistant, assistant);

      expect(
        value.copyWith.first(age: 42),
        UnionFirst(
          assistant,
          Assistant(name: 'John', age: 42),
        ),
      );
      expect(
        value.copyWith.shared(age: 42),
        UnionFirst(
          Assistant(name: 'John', age: 42),
          assistant,
        ),
      );

      value = value.copyWith.shared(age: 42);
      value = value.copyWith.first(age: 42);

      await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  UnionFirst value;
  UnionFirst second = value.copyWith.shared(age: 42);
}
'''), completes);
      await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  UnionFirst value;
  UnionFirst second = value.copyWith.first(age: 42);
}
'''), completes);
      await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  UnionFirst value;
  UnionFirst second = value.copyWith.second(age: 42);
}
'''), throwsCompileError);
    });
    test('UnionSecond.copyWith.something', () async {
      final assistant = Assistant(name: 'John', age: 21);
      UnionSecond value = UnionSecond(assistant, assistant);

      expect(
        value.copyWith.second(age: 42),
        UnionSecond(
          assistant,
          Assistant(name: 'John', age: 42),
        ),
      );
      expect(
        value.copyWith.shared(age: 42),
        UnionSecond(
          Assistant(name: 'John', age: 42),
          assistant,
        ),
      );

      value = value.copyWith.shared(age: 42);
      value = value.copyWith.second(age: 42);

      await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  UnionSecond value;
  UnionSecond second = value.copyWith.shared(age: 42);
}
'''), completes);
      await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  UnionSecond value;
  UnionSecond second = value.copyWith.second(age: 42);
}
'''), completes);
      await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  UnionSecond value;
  UnionSecond second = value.copyWith.first(age: 42);
}
'''), throwsCompileError);
    });
  });

  group('NoCommonProperty', () {
    group('copyWith', () {
      test('cannot read copyWith from base class', () async {
        await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  NoCommonProperty value;
}
'''), completes);
        await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  NoCommonProperty value;
  var second = value.copyWith;
}
'''), throwsCompileError);
      });
      test('NoCommonProperty.assistant has type-safe copyWith', () async {
        await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  NoCommonPropertyAssistant value;
  Assistant assistant;
  NoCommonPropertyAssistant copy = value.copyWith(assistant: assistant);
}
'''), completes);
        await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  NoCommonProperty value;
  NoCommonPropertyAssistant copy = value.copyWith(assistant: 42);
}
'''), throwsCompileError);
      });
      test('NoCommonProperty() has no copyWith', () async {
        await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  NoCommonPropertyEmpty value;
}
'''), completes);
        await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  NoCommonPropertyEmpty value;
  var second = value.copyWith;
}
'''), throwsCompileError);
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
    });
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

  group('Company', () {
    group('From subclass, copyWith parameters are not typed as Object', () {
      test('Company.copyWith', () async {
        await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  CompanySubclass company;
  CompanySubclass second = company.copyWith(name: 'Larry');
}
'''), completes);
        await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  CompanySubclass company;
  CompanySubclass second = company.copyWith(name: 42);
}
'''), throwsCompileError);
      });
      test('Company.copyWith.director', () async {
        await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  CompanySubclass company;
  CompanySubclass second = company.copyWith.director(name: 'Larry');
}
'''), completes);
        await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  CompanySubclass company;
  CompanySubclass second = company.copyWith.director(name: 42);
}
'''), throwsCompileError);
      });
      test('Company.copyWith.director.assistant', () async {
        await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  CompanySubclass company;
  CompanySubclass second = company.copyWith.director.assistant(name: 'Larry');
}
'''), completes);
        await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  CompanySubclass company;
  CompanySubclass second = company.copyWith.director.assistant(name: 42);
}
'''), throwsCompileError);
      });
    });
    group('From interface, copyWith parameters are not typed as Object', () {
      test('Company.copyWith', () async {
        await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  Company company;
  Company second = company.copyWith(name: 'Larry');
}
'''), completes);
        await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  Company company;
  Company second = company.copyWith(name: 42);
}
'''), throwsCompileError);
      });
      test('Company.copyWith.director', () async {
        await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  Company company;
  Company second = company.copyWith.director(name: 'Larry');
}
'''), completes);
        await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  Company company;
  Company second = company.copyWith.director(name: 42);
}
'''), throwsCompileError);
      });
      test('Company.copyWith.director.assistant', () async {
        await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  Company company;
  Company second = company.copyWith.director.assistant(name: 'Larry');
}
'''), completes);
        await expectLater(compile(r'''
import 'deep_copy.dart';

void main() {
  Company company;
  Company second = company.copyWith.director.assistant(name: 42);
}
'''), throwsCompileError);
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
        company.copyWith.director(name: 'Sundar Pichai'),
        Company(
          name: 'Google',
          director: Director(
            name: 'Sundar Pichai',
            assistant: company.director.assistant,
          ),
        ),
      );

      expect(
        company.copyWith
            .director(assistant: Assistant(name: 'John Doe', age: 21)),
        Company(
          name: 'Google',
          director: Director(
            name: 'Larry Page',
            assistant: Assistant(name: 'John Doe', age: 21),
          ),
        ),
      );

      expect(
        company.copyWith.director.assistant(name: 'John Doe'),
        Company(
          name: 'Google',
          director: Director(
            name: 'Larry Page',
            assistant: Assistant(
              name: 'John Doe',
              age: 42,
            ),
          ),
        ),
      );
    });
  });
}
