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
    final that = this;
    if (that is TypeParameterType) {
      return that.bound.isNullable;
    }
    return isDynamic2 || nullabilitySuffix == NullabilitySuffix.question;
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
  DartType type, {
  required bool withNullability,
}) {
  final owner = originLibrary.prefixes.firstWhereOrNull(
    (e) {
      return e.imports.any((l) {
        return l.importedLibrary!.anyTransitiveExport((library) {
          return library.id == _getElementForType(type)?.library?.id;
        });
      });
    },
  );

  String? displayType = type.getDisplayString(withNullability: withNullability);

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

  if (displayType.contains('InvalidType')) {
    displayType = displayType.replaceAll('InvalidType', 'dynamic');
  }

  if (owner != null) {
    return '${owner.name}.$displayType';
  }

  return displayType;
}
