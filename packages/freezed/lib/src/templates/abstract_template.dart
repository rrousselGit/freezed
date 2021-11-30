import 'package:freezed/src/models.dart';

import 'copy_with.dart';
import 'parameter_template.dart';
import 'properties.dart';
import 'prototypes.dart';

class Abstract {
  Abstract({
    required this.name,
    required this.genericsParameter,
    required this.genericsDefinition,
    required this.abstractProperties,
    required this.shouldGenerateJson,
    required this.allConstructors,
    required this.copyWith,
    required this.shouldGenerateMaybeMap,
    required this.shouldGenerateMaybeWhen,
  });

  final String name;
  final List<Getter> abstractProperties;
  final GenericsParameterTemplate genericsParameter;
  final GenericsDefinitionTemplate genericsDefinition;
  final List<ConstructorDetails> allConstructors;
  final bool shouldGenerateJson;
  final CopyWith copyWith;
  final bool shouldGenerateMaybeMap;
  final bool shouldGenerateMaybeWhen;

  @override
  String toString() {
    return '''
/// @nodoc
mixin _\$$name$genericsDefinition {

${abstractProperties.map((e) => e.toString(throwUnimplementError: true)).join()}

$_when
$_whenOrNull
$_maybeWhen
$_map
$_mapOrNull
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
    return 'Map<String, dynamic> toJson() => throw $privConstUsedErrorVarName;';
  }

  String get _when {
    if (!allConstructors.shouldGenerateUnions) return '';
    return '${whenPrototype(allConstructors)} => throw $privConstUsedErrorVarName;';
  }

  String get _whenOrNull {
    if (!allConstructors.shouldGenerateUnions) return '';
    return '${whenOrNullPrototype(allConstructors)} => throw $privConstUsedErrorVarName;';
  }

  String get _maybeWhen {
    if (!allConstructors.shouldGenerateUnions) return '';
    if (!shouldGenerateMaybeWhen) return '';
    return '${maybeWhenPrototype(allConstructors)} => throw $privConstUsedErrorVarName;';
  }

  String get _map {
    if (!allConstructors.shouldGenerateUnions) return '';
    return '${mapPrototype(allConstructors, genericsParameter)} => throw $privConstUsedErrorVarName;';
  }

  String get _mapOrNull {
    if (!allConstructors.shouldGenerateUnions) return '';
    return '${mapOrNullPrototype(allConstructors, genericsParameter)} => throw $privConstUsedErrorVarName;';
  }

  String get _maybeMap {
    if (!allConstructors.shouldGenerateUnions) return '';
    if (!shouldGenerateMaybeMap) return '';
    return '${maybeMapPrototype(allConstructors, genericsParameter)} => throw $privConstUsedErrorVarName;';
  }
}
