import 'package:freezed/src/freezed_generator.dart';
import 'package:freezed/src/models.dart';

import 'copy_with.dart';
import 'properties.dart';
import 'prototypes.dart';

class Abstract {
  Abstract({
    required this.data,
    required this.copyWith,
    required this.commonProperties,
  });

  final Class data;
  final CopyWith? copyWith;
  final List<Property> commonProperties;

  @override
  String toString() {
    final abstractProperties = commonProperties
        .expand((e) => [
              e.abstractGetter,
              if (!e.isFinal) e.abstractSetter,
            ])
        .join();

    return '''
/// @nodoc
mixin _\$${data.name.public}${data.genericsDefinitionTemplate} {

$abstractProperties
$_toJson
${copyWith?.abstractCopyWithGetter ?? ''}
}

${copyWith?.commonInterface ?? ''}
${copyWith?.commonConcreteImpl ?? ''}
''';
  }

  String get _toJsonParams => toJsonParameters(
        data.genericsParameterTemplate,
        data.options.genericArgumentFactories,
      );
  String get _toJson {
    if (!data.options.toJson) return '';

    return '''
  /// Serializes this ${data.name} to a JSON map.
  Map<String, dynamic> toJson($_toJsonParams);
''';
  }
}
