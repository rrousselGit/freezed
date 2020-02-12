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
    @required this.commonProperties,
  });

  final String name;
  final List<Getter> abstractProperties;
  final GenericsParameterTemplate genericsParameter;
  final GenericsDefinitionTemplate genericsDefinition;
  final List<ConstructorDetails> allConstructors;
  final bool shouldGenerateJson;
  final List<Property> commonProperties;

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
$copyAs
}
''';
  }

  String get copyAs {
    final res = StringBuffer();
    for (final constructor in allConstructors) {
      var parameter = constructor.impliedProperties.map((property) {
        return Parameter(
          decorators: property.decorators,
          isRequired: commonProperties.every((commonProperty) => commonProperty.name != property.name),
          name: property.name,
          type: property.type,
        );
      }).join(',');
      if (parameter.isNotEmpty) {
        parameter = '{$parameter}';
      }

      res.write('''
${constructor.redirectedName}$genericsParameter ${constructor.copyAsName}($parameter);
''');
    }
    return res.toString();
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
