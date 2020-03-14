import 'package:freezed/src/freezed_generator.dart';
import 'package:freezed/src/templates/concrete_template.dart';
import 'package:meta/meta.dart';
import 'copy_with.dart';
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
    @required this.copyWith,
  });

  final String name;
  final List<Getter> abstractProperties;
  final GenericsParameterTemplate genericsParameter;
  final GenericsDefinitionTemplate genericsDefinition;
  final List<ConstructorDetails> allConstructors;
  final bool shouldGenerateJson;
  final CopyWith copyWith;

  @override
  String toString() {
    return '''
mixin _\$$name$genericsDefinition {
${abstractProperties.join()}

$_when
$_maybeWhen
$_map
$_maybeMap
$_toJson
${copyWith.abstractCopyWithGetter}
}

${copyWith.interface}

${copyWith.commonContreteImpl(abstractProperties)}
''';
  }

  String get _toJson {
    if (!shouldGenerateJson) return '';

    return 'Map<String, dynamic> toJson();';
  }

  String get _when {
    if (allConstructors.length < 2) return '';
    return '${whenPrototype(allConstructors)};';
  }

  String get _maybeWhen {
    if (allConstructors.length < 2) return '';
    return '${maybeWhenPrototype(allConstructors)};';
  }

  String get _map {
    if (allConstructors.length < 2) return '';
    return '${mapPrototype(allConstructors, genericsParameter)};';
  }

  String get _maybeMap {
    if (allConstructors.length < 2) return '';
    return '${maybeMapPrototype(allConstructors, genericsParameter)};';
  }
}
