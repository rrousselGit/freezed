import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

extension DartTypeExt on DartType {
  bool hasName(String name) => getDisplayString() == name;
}

extension ClassElementExt on ClassElement {
  String? constToken() {
    if (!constructors.any((c) => c.isConst)) return null;

    // A const constructor can only call a const super constructor.
    final superConstructor = supertype?.element.unnamedConstructor;
    if (superConstructor != null && !superConstructor.isConst) return null;

    return 'const ';
  }
}
