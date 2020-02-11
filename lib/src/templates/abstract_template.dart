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
abstract class _\$$name$genericsDefinition {
${abstractProperties.join()}

$copyWithPrototype

$when

$maybeWhen

$map

$maybeMap

$toJson
}
''';
  }

  String get toJson {
    if (!shouldGenerateJson) return '';

    return 'Map<String, dynamic> toJson();';
  }

  String get copyWithPrototype {
    if (abstractProperties.isEmpty) return '';
    final parameters = abstractProperties.map((p) {
      return '${p.type} ${p.name}';
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

class Getter {
  final String type;
  final String name;

  Getter({this.type, this.name});

  @override
  String toString() {
    return '${type ?? 'dynamic'} get $name;';
  }
}

extension PropertiesAsGetters on List<Property> {
  List<Getter> asGetters() {
    return map((p) => p.getter).toList();
  }
}
