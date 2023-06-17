import 'package:analyzer/dart/ast/ast.dart';
import 'package:freezed/src/ast_type.dart';

class FreezedAnnotation {}

typedef FreezedClassID = ({String className, String? constructorName});

sealed class FreezedAst {
  FreezedClassID get id;
}

/// A class annotated with `@freezed`.
class FreezedClassDefinition implements FreezedAst {
  FreezedClassDefinition(
    this.declaration, {
    required this.annotation,
    required this.children,
  });

  @override
  FreezedClassID get id {
    return (
      className: declaration.name.lexeme,
      constructorName: null,
    );
  }

  final FreezedAnnotation annotation;
  final ClassDeclaration declaration;
  final List<FreezedConstructorIdentifier> children;
}

/// A reference to another Freezed class, be it a generated one or a
/// user-defined one.
///
/// They are declared through a redirecting factory constructor on a [FreezedClassDefinition].
class FreezedConstructorIdentifier implements FreezedAst {
  FreezedConstructorIdentifier(this.redirectConstructor, this.constructor);

  @override
  FreezedClassID get id {
    return (
      className: redirectConstructor.type.name2.lexeme,
      constructorName: redirectConstructor.name?.name,
    );
  }

  final ConstructorDeclaration constructor;
  final ConstructorName redirectConstructor;
}

class GeneratedField {
  GeneratedField({
    required this.name,
    required this.type,
    required this.cloneable,
    required this.comparable,
    required this.isNamed,
    required this.isPositiona,
    required this.isRequired,
    this.defaultValueSourceCode,
  });

  static List<GeneratedField> computeCommonFields(
    List<GeneratedField> a,
    List<GeneratedField> b,
  ) {
    // TODO
    throw UnimplementedError();
  }

  final String name;
  final String? defaultValueSourceCode;
  final AstType type;
  final bool cloneable;
  final bool comparable;
  final bool isNamed;
  final bool isPositiona;
  final bool isRequired;
}

class FreezedAstType extends CustomResolvedCustomDartType {
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
