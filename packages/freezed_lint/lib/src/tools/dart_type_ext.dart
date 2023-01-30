import 'package:analyzer/dart/element/type.dart';

extension DartTypeExt on DartType {
  bool hasName(String name) {
    return getDisplayString(withNullability: false) == name;
  }
}
