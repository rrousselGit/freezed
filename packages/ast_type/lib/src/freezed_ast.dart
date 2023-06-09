import 'package:analyzer/dart/ast/ast.dart';
import 'package:ast_type/src/ast_type.dart';

// TODO should this be exposed?
extension StringUtils on String {
  bool get isPublic => !startsWith('_');

  String get public {
    if (startsWith('_')) return substring(1);
    return this;
  }

  String get generated => '_\$$public';

  String get titled {
    return replaceFirstMapped(
      RegExp('[a-zA-Z]'),
      (match) => match.group(0)!.toLowerCase(),
    );
  }
}

// TODO move to pkg:freezed
class FreezedAstType extends CustomResolvedAstType {
  FreezedAstType({
    required this.importAlias,
    required this.isNullable,
    required this.source,
    required this.typeArguments,
  });

  final String? importAlias;
  final bool isNullable;
  final String source;
  final List<AstType> typeArguments;

  @override
  String encode() {
    // TODO: implement encode
    return source;
  }
}
