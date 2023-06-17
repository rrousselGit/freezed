import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:meta/meta.dart';

typedef TryParseUnresolvedType = CustomResolvedAstType? Function(
  // TODO should be pass the TypeAnnotation directly?
  // TODO should we pass in type arguments/parameters?
  UnresolvedAstType type,
);

sealed class AstType {
  factory AstType.fromTypeAnnotation(
    TypeAnnotation type, {
    TryParseUnresolvedType? tryParseUnresolvedType,
  }) {
    switch (type) {
      case NamedType():
        return _parseNamedType(
          type,
          tryParseUnresolvedType: tryParseUnresolvedType,
        );
      case GenericFunctionType():
        final typeParams = _parseTypeParameters(
          type.typeParameters,
          tryParseUnresolvedType: tryParseUnresolvedType,
        );
        // TODO be careful with leastUpperBound as parameters needs to be upcasted not downcasted.
        // TODO
        throw UnimplementedError();
      case RecordTypeAnnotation():
        // TODO
        throw UnimplementedError();
      default:
        throw UnsupportedError('Unknown type annotation: ${type.runtimeType}');
    }
  }

  static AstType _parseNamedType(
    NamedType type, {
    required TryParseUnresolvedType? tryParseUnresolvedType,
  }) {
    final typeArgs = _parseTypeArguments(
      type.typeArguments,
      tryParseUnresolvedType: tryParseUnresolvedType,
    );

    switch (type.type) {
      case null:
        throw ArgumentError.value(type, 'type', 'The AST must be "resolved".');
      case InvalidType():
        final unresolvedType = UnresolvedAstType(type, typeArgs);
        return tryParseUnresolvedType?.call(unresolvedType) ?? unresolvedType;
      case _:
        return NamedAstType(type, typeArgs);
    }
  }

  static List<AstType> _parseTypeArguments(
    TypeArgumentList? typeArguments, {
    required TryParseUnresolvedType? tryParseUnresolvedType,
  }) {
    if (typeArguments == null) return const [];

    return typeArguments.arguments
        .map(
          // TODO how do type parameters are associated with their class?
          // Because to generics with the same name aren't assignable with each other
          (e) => AstType.fromTypeAnnotation(
            e,
            tryParseUnresolvedType: tryParseUnresolvedType,
          ),
        )
        .toList(growable: false);
  }

  static List<AstType> _parseTypeParameters(
    TypeParameterList? typeParameters, {
    required TryParseUnresolvedType? tryParseUnresolvedType,
  }) {
    if (typeParameters == null) return const [];

    return typeParameters.typeParameters
        // TODO pass the tryParseUnresolvedType
        .map(_TypeParameterAstType.new)
        .toList(growable: false);
  }

  // TODO add a way to implement a deep == check for types such that:
  // List<int> uses a simple ListEquality
  // List<Object?> uses a DeepCollectionEquality due to items possibly being collections
  // MyClass uses ==
  // and so on

  String encode();

  @mustBeOverridden
  @override
  bool operator ==(Object other);

  @mustBeOverridden
  @override
  int get hashCode;
}

sealed class ResolvedAstType implements AstType {
  @mustBeOverridden
  @override
  bool operator ==(Object other);

  @mustBeOverridden
  @override
  int get hashCode;
}

abstract class CustomResolvedAstType extends ResolvedAstType {
  @mustBeOverridden
  @override
  bool operator ==(Object other);

  @mustBeOverridden
  @override
  int get hashCode;
}

class _TypeParameterAstType extends ResolvedAstType {
  _TypeParameterAstType(this.type);

  final TypeParameter type;

  // TODO is there ever a case where we _don't_ want a toSource()?
  // TODO what about generics?
  @override
  String encode() => type.toSource();
}

@internal
class NamedAstType extends ResolvedAstType {
  NamedAstType(this.type, this.typeArguments)
      : assert(
          type.type != null && type.type is! InvalidType,
          'The type must be resolved.',
        ),
        assert(
          (type.typeArguments == null && typeArguments.isEmpty) ||
              (type.typeArguments?.arguments.length == typeArguments.length),
          'The type arguments must match the type annotation.',
        );

  final NamedType type;
  final List<AstType> typeArguments;

  // TODO is there ever a case where we _don't_ want a toSource()?
  // TODO what about generics?
  @override
  String encode() => type.toSource();
}

final class UnresolvedAstType implements AstType {
  UnresolvedAstType(this._type, this.typeArguments);

  final TypeAnnotation _type;
  final List<AstType> typeArguments;

  @override
  String encode() => _type.toSource();

  @override
  bool operator ==(Object other) {
    if (other is! UnresolvedAstType) return false;

    // TODO handle comments in the source (such as inside generics)
    // TODO handle classes with the same name but from different places
    // TODO handle generics
    // TODO handle same source in different librairies
    return encode() == other.encode();
  }

  @override
  int get hashCode => encode().hashCode;
}
