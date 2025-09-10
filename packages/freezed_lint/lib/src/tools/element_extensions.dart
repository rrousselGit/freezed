import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/type.dart';

extension DartTypeExt on DartType {
  bool hasName(String name) => getDisplayString() == name;
}

extension ClassElementExt on ClassElement2 {
  String? constToken() {
    if (constructors2.any((c) => c.isConst)) return 'const ';
    return null;
  }
}
