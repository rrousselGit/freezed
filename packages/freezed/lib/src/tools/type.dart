import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';

import 'imports.dart';

extension DartTypeX on DartType {
  bool get isDynamic2 {
    return this is DynamicType || this is InvalidType;
  }

  bool get isNullable {
    if (isDynamic2 || nullabilitySuffix == NullabilitySuffix.question) {
      return true;
    }

    final that = this;
    if (that is TypeParameterType) return that.bound.isNullable;

    return false;
  }
}

/// Returns the [Element] for a given [DartType]
///
/// this is usually type.element, except if it is a typedef then it is
/// type.alias.element
Element? _getElementForType(DartType type) {
  if (type is InterfaceType) {
    return type.element;
  }
  if (type is FunctionType) {
    return type.alias?.element;
  }
  return null;
}

/// Renders a type based on its string + potential import alias
String resolveFullTypeStringFrom(
  LibraryElement originLibrary,
  DartType type,
) {
  final owner = originLibrary.units
      .expand((e) => e.libraryImportPrefixes)
      .firstWhereOrNull(
    (e) {
      return e.imports.any((l) {
        return l.importedLibrary!.anyTransitiveExport((library) {
          return library.id == _getElementForType(type)?.library?.id;
        });
      });
    },
  );

  String? displayType = type.getDisplayString();

  // The parameter is a typedef in the form of
  // SomeTypedef typedef
  //
  // In this case the analyzer would expand that typedef using getDisplayString
  // For example for:
  //
  // typedef SomeTypedef = Function(String);
  //
  // it would generate:
  // 'dynamic Function(String)'
  //
  // Instead of 'SomeTypedef'
  if (type is FunctionType && type.alias?.element != null) {
    displayType = type.alias!.element.name;
    if (type.alias!.typeArguments.isNotEmpty) {
      displayType += '<${type.alias!.typeArguments.join(', ')}>';
    }
    if (type.nullabilitySuffix == NullabilitySuffix.question) {
      displayType += '?';
    }
  }

  // The parameter is a Interface with a Type Argument that is not yet generated
  // In this case analyzer would set its type to InvalidType
  //
  // For example for:
  // List<ToBeGenerated> values,
  //
  // it would generate:  List<InvalidType>
  // instead of          List<dynamic>
  //
  // This a regression in analyzer 5.13.0
  if (type is InterfaceType &&
      type.typeArguments.any((e) => e is InvalidType)) {
    final dynamicType = type.element.library.typeProvider.dynamicType;
    var modified = type;
    modified.typeArguments
      ..replaceWhere(
        (t) => t is InvalidType,
        dynamicType,
      );
    displayType = modified.getDisplayString();
  }

  if (owner != null) {
    return '${owner.name}.$displayType';
  }

  return displayType;
}

extension ReplaceWhereExtension<T> on List<T> {
  void replaceWhere(bool Function(T element) test, T replacement) {
    for (var index = 0; index < length; index++) {
      if (test(this[index])) {
        this[index] = replacement;
      }
    }
  }
}
