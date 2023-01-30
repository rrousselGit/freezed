import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

extension DartTypeExt on DartType {
  bool hasName(String name) {
    return getDisplayString(withNullability: false) == name;
  }
}

extension ClassElementExt on ClassElement {
  String? constToken() {
    if (constructors.any((c) => c.isConst)) return 'const ';
    return null;
  }
}
