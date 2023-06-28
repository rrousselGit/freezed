import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:source_gen/source_gen.dart';

extension DefaultUtils on Element {
  /// Returns the sources of the default value associated with a `@Default`,
  /// or `null` if no `@Default` are specified.
  String? computeDefaultValue() {
    const matcher = TypeChecker.fromRuntime(Default);

    for (final annotationElement in metadata) {
      final annotationValue = annotationElement.computeConstantValue();
      if (annotationValue == null) continue;

      final annotationType = annotationValue.type;
      if (annotationType == null) continue;

      final defaultValue = annotationValue.getField('defaultValue');
      if (defaultValue == null) continue;

      final defaultValueType = defaultValue.type;
      if (defaultValueType == null) continue;

      if (!matcher.isExactlyType(annotationType)) continue;

      final annotationSource = annotationElement.toSource();
      final defaultSource = annotationSource
          .substring(
            '@Default('.length,
            annotationSource.length - 1,
          )
          .trim();

      // TODO test all cases
      // TODO: throw if multiple default are used
      // TODO throw if @default annotation is used in a non-explicit way (ie "const value = Default('str'); .. @value")
      // TODO differentiate "failed to parse default" from "no default"

      late final bool needsConstModifier;
      switch (defaultValueType) {
        // TODO handle tabs and newlines
        case _ when defaultSource.startsWith(RegExp('const ')):
        case DartType(isDartCoreInt: true):
        case DartType(isDartCoreDouble: true):
        case DartType(isDartCoreNum: true):
        case DartType(isDartCoreString: true):
        case DartType(isDartCoreBool: true):
        case DartType(isDartCoreNull: true):
        case DartType(isDartCoreRecord: true):
        // case DartType(isDartCoreEnum: true):
        // TODO handle manual const Symbol() vs #symbol
        case DartType(isDartCoreSymbol: true):
        case DartType(isDartCoreType: true):
        // Exclude constructors and collection litterals
        case _
            when !defaultSource.contains('(') &&
                !defaultSource.contains('[') &&
                !defaultSource.contains('{'):
          // case DartType(isDartCoreFunction: true):
          needsConstModifier = false;
        default:
          needsConstModifier = true;
      }

      if (needsConstModifier) return 'const $defaultSource';
      return defaultSource;
    }
    return null;
  }
}
