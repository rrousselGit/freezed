import 'package:freezed/src/freezed_generator.dart';
import 'package:freezed/src/models.dart';

import 'concrete_template.dart';
import 'copy_with.dart';
import 'properties.dart';

class Abstract {
  Abstract({
    required this.data,
    required this.copyWith,
    required this.commonProperties,
    required this.globalData,
  });

  final Class data;
  final CopyWith? copyWith;
  final List<Property> commonProperties;
  final Library globalData;

  @override
  String toString() {
    final abstractProperties = commonProperties
        .where((e) => e.isSynthetic)
        .expand((e) => [e.abstractGetter, if (!e.isFinal) e.abstractSetter])
        .join();

    var interfaces = [
      if (globalData.hasDiagnostics && data.options.asString)
        'DiagnosticableTreeMixin',
    ].join();
    if (interfaces.isNotEmpty) interfaces = ' implements $interfaces';

    return '''
/// @nodoc
mixin _\$${data.name.public}${data.genericsDefinitionTemplate}$interfaces {

$abstractProperties
${copyWith?.copyWithGetter(needsCast: true) ?? ''}
${methods(data, globalData, properties: commonProperties, name: data.name, escapedName: data.escapedName, source: Source.mixin)}
}

${copyWith?.commonInterface ?? ''}
${copyWith?.commonConcreteImpl ?? ''}
''';
  }
}
