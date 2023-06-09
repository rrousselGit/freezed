import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/type_system.dart';
import 'package:meta/meta.dart';

sealed class AstType {
  factory AstType.fromTypeAnnotation(
    TypeAnnotation type,
  ) {
    switch (type) {
      case NamedType():
        final typeArgs = type.typeArguments?.arguments
            .map(AstType.fromTypeAnnotation)
            .toList(growable: false);

        return _NamedCustomType(type);
      case GenericFunctionType():
        final typeArgs = type.typeParameters?.typeParameters
            .map(_TypeParameterType.new)
            .toList(growable: false);
        // TODO
        throw UnimplementedError();
      case RecordTypeAnnotation():
        // TODO
        throw UnimplementedError();
      default:
        throw UnsupportedError('Unknown type annotation: ${type.type}');
    }
  }

  factory AstType._fromDartType(
    DartType type, {
    TypeAnnotation? typeAnnotation,
    required TypeSystem typeSystem,
  }) = _TypeFromDartType;

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

sealed class ResolvedAstType implements AstType {}

abstract class CustomResolvedCustomDartType extends ResolvedAstType {}

final class UnresolvedAstType implements AstType {
  UnresolvedAstType(this._type);
  // TODO do not consider freezed classes as unresolved.

  final TypeAnnotation _type;

  @override
  String encode() => _type.toSource();

  @override
  bool operator ==(Object other) {
    if (other is! _TypeFromDartType) return false;

    // TODO handle comments in the source (such as inside generics)
    // TODO handle classes with the same name but from different places
    // TODO handle generics
    // TODO handle same source in different librairies
    return encode() == other.encode();
  }

  @override
  int get hashCode => encode().hashCode;
}

class _TypeParameterType extends ResolvedAstType {
  _TypeParameterType(this.type);

  final TypeParameter type;

  // TODO is there ever a case where we _don't_ want a toSource()?
  // TODO what about generics?
  @override
  String encode() => type.toSource();
}

class _NamedCustomType extends ResolvedAstType {
  _NamedCustomType(this.type);

  final NamedType type;

  // TODO is there ever a case where we _don't_ want a toSource()?
  // TODO what about generics?
  @override
  String encode() => type.toSource();
}

class _TypeFromDartType extends ResolvedAstType {
  _TypeFromDartType(
    this.type, {
    this.typeAnnotation,
    required this.typeSystem,
  });

  final TypeSystem typeSystem;
  final DartType type;
  final TypeAnnotation? typeAnnotation;

  @override
  String encode() {
    // TODO be careful when writing the type, as it might be coming from an
    // import with a type alias.
    return typeAnnotation?.toSource() ??
        type.getDisplayString(withNullability: true);
  }
}
