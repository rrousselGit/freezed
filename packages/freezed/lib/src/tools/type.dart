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

  if (owner != null) {
    return '${owner.name}.${type.getDisplayString(withNullability: withNullability)}';
  }

  return type.getDisplayString(withNullability: withNullability);
}
