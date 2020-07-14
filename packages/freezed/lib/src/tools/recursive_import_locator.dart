import 'package:analyzer/dart/element/element.dart';
import 'package:meta/meta.dart';

typedef ExportPredicate = bool Function(Element);
typedef LibraryPredicate = bool Function(LibraryElement);

ExportPredicate isClass(String className) {
  return (element) => element is ClassElement && element.name == className;
}

ExportPredicate isWithin(String libraryRootName) {
  return (element) =>
      element.librarySource.fullName.startsWith('/$libraryRootName/');
}

class RecursiveImportLocator {
  const RecursiveImportLocator();

  bool hasImport({
    @required LibraryElement root,
    @required ExportPredicate where,
    LibraryPredicate whereLibrary,
  }) {
    return root.importedLibraries.any((lib) => _doesExportRecursively(
          library: lib,
          where: where,
          whereLibrary: whereLibrary,
        ));
  }

  bool _doesExportRecursively({
    @required LibraryElement library,
    @required ExportPredicate where,
    LibraryPredicate whereLibrary,
  }) {
    assert(library != null);
    assert(where != null);

    if (whereLibrary?.call(library) ?? true) {
      if (library.topLevelElements.any(where)) {
        return true;
      }
    }

    return library.exportedLibraries.any((export) {
      final shouldContinueRecursion = whereLibrary?.call(export) ?? true;

      if (shouldContinueRecursion) {
        return shouldContinueRecursion &&
            _doesExportRecursively(
              library: export,
              where: where,
              whereLibrary: whereLibrary,
            );
      } else {
        return false;
      }
    });
  }
}
