import 'package:analyzer/dart/element/element.dart';

extension LibraryHasImport on LibraryElement {
  LibraryElement? findTransitiveExportWhere(
    bool Function(LibraryElement library) visitor,
  ) {
    if (visitor(this)) return this;

    final visitedLibraries = <LibraryElement>{};
    LibraryElement? visitLibrary(LibraryElement library) {
      if (!visitedLibraries.add(library)) return null;

      if (visitor(library)) return library;

      for (final export in library.exportedLibraries) {
        final result = visitLibrary(export);
        if (result != null) return result;
      }

      return null;
    }

    for (final import in exportedLibraries) {
      final result = visitLibrary(import);
      if (result != null) return result;
    }

    return null;
  }

  bool anyTransitiveExport(bool Function(LibraryElement library) visitor) {
    return findTransitiveExportWhere(visitor) != null;
  }
}
