import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';

/// Renders a type based on its string + potential import alias
String resolveFullTypeStringFrom(
  LibraryElement originLibrary,
  DartType type, {
  required bool withNullability,
}) {
  final owner = originLibrary.prefixes.firstWhereOrNull(
    (e) => type.element!.isAccessibleIn(e.enclosingElement),
  );

  if (owner != null) {
    return '${owner.name}.${type.getDisplayString(withNullability: withNullability)}';
  }

  return type.getDisplayString(withNullability: withNullability);
}
