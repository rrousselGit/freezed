import '../models.dart';
import 'parameter_template.dart';

class TearOff {
  TearOff({
    required this.name,
    required this.serializable,
    required this.genericsParameter,
    required this.genericsDefinition,
    required this.allConstructors,
  });

  final String name;
  final bool serializable;
  final GenericsParameterTemplate genericsParameter;
  final GenericsDefinitionTemplate genericsDefinition;
  final List<ConstructorDetails> allConstructors;

  @override
  String toString() {
    String outputName;
    if (name.startsWith('_')) {
      outputName = '_\$${name.substring(1)}';
    } else {
      outputName = '\$$name';
    }

    return '''
/// @nodoc
class _\$${name}TearOff {
  const _\$${name}TearOff();

${tearOffs.join()}
}

/// @nodoc
const $outputName = _\$${name}TearOff();
''';
  }

  Iterable<String> get tearOffs sync* {
    for (final targetConstructor in allConstructors) {
      final ctorName =
          targetConstructor.isDefault ? 'call' : targetConstructor.name;

      final parameters = StringBuffer();
      for (final positional
          in targetConstructor.parameters.allPositionalParameters) {
        parameters
          ..write(positional.name)
          ..write(',');
      }
      for (final named in targetConstructor.parameters.namedParameters) {
        parameters
          ..write(named.name)
          ..write(':')
          ..write(named.name)
          ..write(',');
      }

      var prefix = '';
      if (targetConstructor.isConst &&
          genericsParameter.typeParameters.isEmpty &&
          targetConstructor.parameters.allParameters.isEmpty) {
        prefix = 'const ';
      }

      yield '''
${targetConstructor.redirectedName}$genericsParameter $ctorName$genericsDefinition(${targetConstructor.parameters.asExpanded(showDefaultValue: true)}) {
  return $prefix ${targetConstructor.redirectedName}$genericsParameter($parameters);
}
''';
    }

    if (serializable) {
      yield '''
$name$genericsParameter fromJson$genericsDefinition(Map<String, Object?> json) {
  return $name$genericsParameter.fromJson(json);
}
''';
    }
  }
}
