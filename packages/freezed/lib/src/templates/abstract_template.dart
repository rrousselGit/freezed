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

$when
$maybeWhen
$map
$maybeMap
$toJson
$copyWithGetter
}

$abstractCopyWith
''';
  }

  String get toJson {
    if (!shouldGenerateJson) return '';

    return 'Map<String, dynamic> toJson();';
  }

  String get copyWithGetter {
    if (abstractProperties.isEmpty) return '';
    return '$copyWithInterface$genericsParameter get copyWith;';
  }

  String get abstractCopyWith {
    if (abstractProperties.isEmpty) return '';
    return '''
abstract class $copyWithInterface$genericsDefinition {
$copyWithPrototype
}''';
  }

  String get copyWithInterface => '\$${name}CopyWith';

  String get copyWithPrototype {
    if (abstractProperties.isEmpty) return '';
    final parameters = abstractProperties.map((p) {
      return '${p.decorators.join()} ${p.type} ${p.name}';
    }).join(',');

    return '''
$name$genericsParameter call({
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
