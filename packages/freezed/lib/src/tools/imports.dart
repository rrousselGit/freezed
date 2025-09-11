import 'package:analyzer/dart/element/element2.dart';

extension LibraryHasImport on LibraryElement2 {
  LibraryElement2? findTransitiveExportWhere(
    bool Function(LibraryElement2 library) visitor,
  ) {
    if (visitor(this)) return this;

    final visitedLibraries = <LibraryElement2>{};
    LibraryElement2? visitLibrary(LibraryElement2 library) {
      if (!visitedLibraries.add(library)) return null;

      if (visitor(library)) return library;

      for (final export in library.exportedLibraries2) {
        final result = visitLibrary(export);
        if (result != null) return result;
      }

      return null;
    }

    for (final import in exportedLibraries2) {
      final result = visitLibrary(import);
      if (result != null) return result;
    }

    return null;
  }

  bool anyTransitiveExport(bool Function(LibraryElement2 library) visitor) {
    return findTransitiveExportWhere(visitor) != null;
  }
}
