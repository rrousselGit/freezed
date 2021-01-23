// @dart=2.9

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
    // based on importedLibraries in
    // analyzer-0.39.4/lib/src/dart/element/element.dart:5321
    final libraries = <_LibraryWithVisibility>{};
    for (final import in root.imports) {
      final library = import.importedLibrary;
      if (library != null) {
        libraries.add(_LibraryWithVisibility.root(library, import.combinators));
      }
    }

    return libraries.any((lib) => _doesExportRecursively(
          library: lib,
          where: where,
          whereLibrary: whereLibrary,
        ));
  }

  bool _doesExportRecursively({
    @required _LibraryWithVisibility library,
    @required ExportPredicate where,
    LibraryPredicate whereLibrary,
  }) {
    if (library.isRelevant(whereLibrary)) {
      if (library.exportedTopLevelElements.any(where)) {
        return true;
      }
    }

    return library.exportedLibraries.any((export) {
      return export.isRelevant(whereLibrary) &&
          _doesExportRecursively(
            library: export,
            where: where,
            whereLibrary: whereLibrary,
          );
    });
  }
}

/// this is a simple approach and it might not
/// consider every possible show/hide case
/// but it works for now
class _LibraryWithVisibility {
  final LibraryElement library;
  final Set<String> hidden;
  final Set<String> shown;

  _LibraryWithVisibility(
    this.library,
    Set<String> parentHidden,
    Set<String> parentShown,
    Iterable<NamespaceCombinator> combinators,
  )   : hidden = parentHidden.union(combinators.hidden),
        shown = parentShown.union(combinators.shown);

  _LibraryWithVisibility.root(
    LibraryElement library,
    Iterable<NamespaceCombinator> combinators,
  ) : this(library, {}, {}, combinators);

  bool isRelevant(LibraryPredicate whereLibrary) =>
      whereLibrary?.call(library) ?? true;

  Iterable<Element> get exportedTopLevelElements =>
      library.topLevelElements.where(_isExported);

  bool _isExported(Element element) {
    if (hidden.isEmpty && shown.isEmpty) {
      return true;
    } else if (shown.isNotEmpty) {
      return shown.contains(element.name);
    } else {
      return !hidden.contains(element.name);
    }
  }

  /// based on exportedLibraries in
  /// analyzer-0.39.4/lib/src/dart/element/element.dart:5230
  List<_LibraryWithVisibility> get exportedLibraries {
    final libraries = <_LibraryWithVisibility>{};
    for (final export in library.exports) {
      final library = export.exportedLibrary;
      if (library != null) {
        libraries.add(_LibraryWithVisibility(
          library,
          hidden,
          shown,
          export.combinators,
        ));
      }
    }
    return libraries.toList(growable: false);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _LibraryWithVisibility &&
          runtimeType == other.runtimeType &&
          library == other.library;

  @override
  int get hashCode => library.hashCode;
}

extension on Iterable<NamespaceCombinator> {
  Set<String> get hidden =>
      whereType<HideElementCombinator>().expand((e) => e.hiddenNames).toSet();

  Set<String> get shown =>
      whereType<ShowElementCombinator>().expand((e) => e.shownNames).toSet();
}
