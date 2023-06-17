import 'dart:io';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:ast_type/src/ast_type.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as p;

class MyCustomType extends CustomResolvedAstType {
  MyCustomType(this.name, this.typeArguments);

  final String name;
  final List<AstType> typeArguments;

  @override
  String encode() => name;
}

void main() {
  test('throws if passing non-resolved AST', () {
    final result = parseString(content: 'int simple = 0;');

    final variable =
        result.unit.declarations.single as TopLevelVariableDeclaration;
    final type = variable.variables.type!;

    expect(
      () => AstType.fromTypeAnnotation(type),
      throwsArgumentError,
    );
  });

  test('Unables manually resolving UnresolvedTypes with custom type', () async {
    final result = await resolveString('''
List<Unknown<MyUnknown<MyUnknown2<Unknown2>>>> value;
''');

    final list = AstType.fromTypeAnnotation(
      result.unit.declarations.typeAnnotations.single.type,
      tryParseUnresolvedType: (type) {
        if (!type.encode().startsWith('My')) return null;
        return MyCustomType(type.encode(), type.typeArguments);
      },
    ) as NamedAstType;

    final unknwon = list.typeArguments.single as UnresolvedAstType;
    final myUnknown = unknwon.typeArguments.single as MyCustomType;
    final myUnknown2 = myUnknown.typeArguments.single as MyCustomType;
    final unknown2 = myUnknown2.typeArguments.single as UnresolvedAstType;

    expect(list.encode(), 'List<Unknown<MyUnknown<MyUnknown2<Unknown2>>>>');
    expect(unknwon.encode(), 'Unknown<MyUnknown<MyUnknown2<Unknown2>>>');
    expect(myUnknown.encode(), 'MyUnknown<MyUnknown2<Unknown2>>');
    expect(myUnknown2.encode(), 'MyUnknown2<Unknown2>');
    expect(unknown2.encode(), 'Unknown2');
  });

  test('parse', () async {
    final result = await resolveString('''
int simple;
Generated simpleUnresolved;

List<int> list;
List<Generated> unresolvedList;

List<List<int>> nestedList;
List<List<Generated>> nestedUnresolvedList;
''');

    for (final (:type, :name) in result.unit.declarations.typeAnnotations) {
      final astType = AstType.fromTypeAnnotation(type);
      switch (name) {
        case 'simple':
          astType as NamedAstType;
          expect(astType.encode(), 'int');

        case 'simpleUnresolved':
          astType as UnresolvedAstType;
          expect(astType.encode(), 'Generated');

        case 'list':
          astType as NamedAstType;
          expect(astType.encode(), 'List<int>');
          expect(astType.typeArguments.single, isA<NamedAstType>());

        case 'unresolvedList':
          astType as NamedAstType;
          expect(astType.encode(), 'List<Generated>');
          expect(astType.typeArguments.single, isA<UnresolvedAstType>());

        case 'nestedList':
          astType as NamedAstType;
          expect(astType.encode(), 'List<List<int>>');

          final child = astType.typeArguments.single as NamedAstType;
          expect(child.typeArguments.single, isA<NamedAstType>());

        case 'nestedUnresolvedList':
          astType as NamedAstType;
          expect(astType.encode(), 'List<List<Generated>>');

          final child = astType.typeArguments.single as NamedAstType;
          expect(child.typeArguments.single, isA<UnresolvedAstType>());

        default:
          throw ArgumentError.value(name);
      }
    }
  });
}

Future<ResolvedUnitResult> resolveString(String content) async {
  final dir = Directory('.dart_tool/test').createTempSync();
  final file = File(p.join(dir.path, 'test.dart'))
    ..createSync(recursive: true)
    ..writeAsStringSync(content);
  addTearDown(() => file.deleteSync(recursive: true));

  final result = await resolveFile2(
    path: p.normalize(file.absolute.path),
  );
  return result as ResolvedUnitResult;
}

extension on NodeList<CompilationUnitMember> {
  Iterable<({TypeAnnotation type, String name})> get typeAnnotations {
    return whereType<TopLevelVariableDeclaration>().map((variable) {
      final type = variable.variables.type!;
      final name = variable.variables.variables.single.name.lexeme;
      return (type: type, name: name);
    });
  }
}
