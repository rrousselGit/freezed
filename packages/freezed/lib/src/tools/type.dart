import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';

import 'imports.dart';

/// Renders a type based on its string + potential import alias
String resolveFullTypeStringFrom(
  LibraryElement originLibrary,
  DartType type, {
  required bool withNullability,
}) {
  final owner = originLibrary.prefixes.firstWhereOrNull(
    (e) {
      if (type.element!.library!.isInSdk) return false;

      final librariesForPrefix = e.library.getImportsWithPrefix(e);

      return librariesForPrefix.any((l) {
        return l.importedLibrary!.anyTransitiveExport((library) {
          return library.id == type.element!.library!.id;
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
  if(type is FunctionType && type.alias?.element != null)  {
    displayType = type.alias!.element.name;
  }

  if (owner != null) {
    return '${owner.name}.$displayType';
  }

  return displayType;
}
