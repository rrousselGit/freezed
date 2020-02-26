import 'package:freezed/src/freezed_generator.dart';
import 'package:freezed/src/templates/concrete_template.dart';
import 'package:meta/meta.dart';
import 'parameter_template.dart';
import 'prototypes.dart';

class Abstract {
  Abstract({
    @required this.name,
    @required this.genericsParameter,
    @required this.genericsDefinition,
    @required this.abstractProperties,
    @required this.shouldGenerateJson,
    @required this.allConstructors,
  });

  final String name;
  final List<Getter> abstractProperties;
  final GenericsParameterTemplate genericsParameter;
  final GenericsDefinitionTemplate genericsDefinition;
  final List<ConstructorDetails> allConstructors;
  final bool shouldGenerateJson;

  @override
  String toString() {
    return '''
mixin _\$$name$genericsDefinition {
${abstractProperties.join()}

$copyWithPrototype

$when

$maybeWhen

$map

$maybeMap

$toJson
}

class _\$${name}TearOff {
  const _\$${name}TearOff();

${tearOffs.join()}
}

const \$$name = _\$${name}TearOff();
''';
  }


  Iterable<String> get tearOffs sync* {
    for (final targetConstructor in allConstructors) {
      final ctorName =
          targetConstructor.isDefault ? 'call' : targetConstructor.name;

      final parameters = StringBuffer();
      for (final positional
          in targetConstructor.parameters.allPositionalParameters) {
        parameters..write(positional.name)..write(',');
      }
      for (final named in targetConstructor.parameters.namedParameters) {
        parameters
          ..write(named.name)
          ..write(':')
          ..write(named.name)
          ..write(',');
      }

      var prefix = '';
      if (targetConstructor.isConst && genericsParameter.typeParameters.isEmpty && targetConstructor.parameters.allParameters.isEmpty) {
        prefix = 'const ';
      }

      yield '''
${targetConstructor.redirectedName}$genericsParameter $ctorName$genericsDefinition(${targetConstructor.parameters.asExpanded(showDefaultValue: true)}) {
  return $prefix ${targetConstructor.redirectedName}$genericsParameter($parameters);
}
''';
    }
  }

  String get toJson {
    if (!shouldGenerateJson) return '';

    return 'Map<String, dynamic> toJson();';
  }

  String get copyWithPrototype {
    if (abstractProperties.isEmpty) return '';
    final parameters = abstractProperties.map((p) {
      return '${p.decorators.join()} ${p.type} ${p.name}';
    }).join(',');

    return '''
$name$genericsParameter copyWith({
$parameters
});
''';
  }

  String get when {
    if (allConstructors.length < 2) return '';
    return '${whenPrototype(allConstructors)};';
  }

  String get maybeWhen {
    if (allConstructors.length < 2) return '';
    return '${maybeWhenPrototype(allConstructors)};';
  }

  String get map {
    if (allConstructors.length < 2) return '';
    return '${mapPrototype(allConstructors, genericsParameter)};';
  }

  String get maybeMap {
    if (allConstructors.length < 2) return '';
    return '${maybeMapPrototype(allConstructors, genericsParameter)};';
  }
}
