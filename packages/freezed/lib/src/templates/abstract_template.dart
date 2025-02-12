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

  final Data data;
  final CopyWith? copyWith;
  final List<Property> commonProperties;

  @override
  String toString() {
    final abstractProperties = commonProperties
        .expand((e) => [
              e.unimplementedGetter,
              if (!e.isFinal) e.unimplementedSetter,
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
      data.genericsParameterTemplate, data.genericArgumentFactories);
  String get _toJson {
    if (!data.generateToJson) return '';
    return '/// Serializes this ${data.name} to a JSON map.\n'
        'Map<String, dynamic> toJson($_toJsonParams)'
        ' => throw $privConstUsedErrorVarName;';
  }
}
