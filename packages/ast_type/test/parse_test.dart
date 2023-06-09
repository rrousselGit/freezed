import 'dart:io';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:ast_type/src/ast_type.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as p;

sealed class Sealed {
  int get offset;
}

abstract class A implements Sealed {}

abstract class B implements Sealed {}

void main() {
  test('parse', () async {
    final result = await resolveString('''
int simple;
Generated simpleUnresolved;

List<int> list;
List<Generated> unresolvedList;

List<List<int>> nestedList;
List<List<Generated>> nestedUnresolvedList;
''');

    for (final Object variable in result.unit.declarations) {
      variable as TopLevelVariableDeclaration;
      final type = variable.variables.type!;
      final name = variable.variables.variables.single.name.lexeme;
      final resolved = AstType.fromTypeAnnotation(
        type,
        tryParseUnresolvedType: (type) => null,
      );

      switch (name) {
        case 'simple':
          resolved as NamedAstType;
          expect(resolved.encode(), 'int');

        case 'simpleUnresolved':
          resolved as UnresolvedAstType;
          expect(resolved.encode(), 'Generated');

        case 'list':
          resolved as NamedAstType;
          expect(resolved.encode(), 'List<int>');
          expect(resolved.typeArguments.single, isA<NamedAstType>());

        case 'unresolvedList':
          resolved as NamedAstType;
          expect(resolved.encode(), 'List<Generated>');
          expect(resolved.typeArguments.single, isA<UnresolvedAstType>());

        case 'nestedList':
          resolved as NamedAstType;
          expect(resolved.encode(), 'List<List<int>>');

          final child = resolved.typeArguments.single as NamedAstType;
          expect(child.typeArguments.single, isA<NamedAstType>());

        case 'nestedUnresolvedList':
          resolved as NamedAstType;
          expect(resolved.encode(), 'List<List<Generated>>');

          final child = resolved.typeArguments.single as NamedAstType;
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
