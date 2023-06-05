import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:freezed/src/freezed_ast/registry.dart';

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
  final CustomDartType type;
  final bool cloneable;
  final bool comparable;
  final bool isNamed;
  final bool isPositiona;
  final bool isRequired;
}

sealed class CustomDartType {
  factory CustomDartType.fromTypeAnnotation(
    TypeAnnotation type,
    FreezedTypeRegistry registry,
  ) {
    switch (type) {
      case NamedType():
        final typeArgs = type.typeArguments?.arguments
            .map((type) => CustomDartType.fromTypeAnnotation(type, registry))
            .toList(growable: false);

        return _NamedCustomType(type);
      case GenericFunctionType():
        final typeArgs = type.typeParameters?.typeParameters
            .map((type) => _TypeParameterType(type, registry))
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

  factory CustomDartType._fromDartType(
    DartType type, {
    TypeAnnotation? typeAnnotation,
  }) = _TypeFromDartType;

  bool get isPossiblyDartCollection;

  List<CustomDartType> get typeArguments;

  String encode();

  CustomDartType computeCommonType(CustomDartType other);
}

class _TypeParameterType implements CustomDartType {
  _TypeParameterType(this.type, this.bound);

  final TypeParameter type;
  final CustomDartType bound;
}

class _NamedCustomType implements CustomDartType {
  _NamedCustomType(this.type);
  final NamedType type;
}

class _FreezedType implements CustomDartType {
  @override
  bool operator ==(Object other) {
    if (other is! _TypeFromDartType) return false;
    // TODO handle classes with the same name but from different places
    // TODO handle generics
    return encode() == other.encode();
  }

  @override
  int get hashCode => encode().hashCode;
}

class _UnresolvedType implements CustomDartType {
  _UnresolvedType(this._type);
  // TODO do not consider freezed classes as unresolved.

  final TypeAnnotation _type;

  @override
  // TODO: implement isPossiblyDartCollection
  bool get isPossiblyDartCollection => throw UnimplementedError();

  @override
  CustomDartType computeCommonType(CustomDartType other) {
    if (other == this) return this;

    // The current type is not resolved, so there is no way to compute
    // a common type. At the same time, the current type and the input types
    // are not equal.
    // TODO use proper exception
    throw UnimplementedError();
  }

  @override
  String encode() => _type.toSource();

  @override
  bool operator ==(Object other) {
    if (other is! _TypeFromDartType) return false;

    // TODO handle comments in the source (such as inside generics)
    // TODO handle classes with the same name but from different places
    // TODO handle generics
    return encode() == other.encode();
  }

  @override
  int get hashCode => encode().hashCode;
}

class _TypeFromDartType implements CustomDartType {
  _TypeFromDartType(this._type, {this.typeAnnotation});

  final DartType _type;
  final TypeAnnotation? typeAnnotation;

  @override
  // TODO: implement isPossiblyDartCollection
  bool get isPossiblyDartCollection => throw UnimplementedError();

  @override
  String encode() {
    // TODO be careful when writing the type, as it might be coming from an
    // import with a type alias.
    return typeAnnotation?.toSource() ??
        _type.getDisplayString(withNullability: true);
  }

  @override
  CustomDartType computeCommonType(CustomDartType other) {
    switch (other) {
      case _UnresolvedType():
        // Contains generated types. Since the current type does not contain
        // generated types, then they are different.
        // TODO use proper exception
        throw UnimplementedError();
      case _TypeFromDartType():
        // No generated types in the DartType and it is fully resolved.
        final typeSystem = _type.element!.library!.typeSystem;
        final commonType = typeSystem.leastUpperBound(_type, other._type);

        return CustomDartType._fromDartType(commonType);
    }
  }

  @override
  bool operator ==(Object other) {
    if (other is! _TypeFromDartType) return false;

    // TODO handle classes with the same name but from different places
    // TODO handle generics
    return encode() == other.encode();
  }

  @override
  int get hashCode => encode().hashCode;
}

extension on TypeAnnotation {}

extension on DartType {
  /// Checks whether a type is "invalid" or has any invalid type arguments.
  ///
  /// This check is recursive, such that for:
  ///
  /// ```dart
  /// List<List<InvalidType>>
  /// ```
  ///
  /// then [hasInvalidTypes] will be true.
  bool get hasInvalidTypes {
    final that = this;
    switch (that) {
      case InvalidType():
        return true;
      case ParameterizedType():
        for (final typeArg in that.typeArguments) {
          final hasInvalidTypeArg = typeArg.hasInvalidTypes;
          if (hasInvalidTypeArg != true) return hasInvalidTypeArg;
        }
        return true;
      default:
        return true;
    }
  }

  bool get isPossiblyDartCollection => throw UnimplementedError(
      // TODO
      );
}
