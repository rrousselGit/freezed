import 'package:analyzer/dart/element/element.dart';

extension FreezedAnnotationChecker on Element {
  /// Whether this element is annotated with `@Freezed` (or one of its
  /// aliases, such as `@freezed`/`@unfreezed`) from `package:freezed_annotation`.
  bool get hasFreezedAnnotation {
    return metadata.annotations.any((annotation) {
      final element = annotation.computeConstantValue()?.type?.element;
      if (element is! ClassElement || element.name != 'Freezed') return false;

      final uri = element.library.uri;
      return uri.scheme == 'package' &&
          uri.pathSegments.firstOrNull == 'freezed_annotation';
    });
  }
}
