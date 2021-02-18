// @dart=2.9

import 'package:freezed/src/models.dart';
import 'package:meta/meta.dart';

import 'copy_with.dart';
import 'parameter_template.dart';
import 'properties.dart';
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
    @required this.shouldUseExtends,
  });

  final String name;
  final List<Getter> abstractProperties;
  final GenericsParameterTemplate genericsParameter;
  final GenericsDefinitionTemplate genericsDefinition;
  final List<ConstructorDetails> allConstructors;
  final bool shouldGenerateJson;
  final CopyWith copyWith;
  final bool shouldUseExtends;

  @override
  String toString() {
    return '''
/// @nodoc
abstract class _\$$name$genericsDefinition {
$_constructor

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

  String get _constructor {
    final constructor = allConstructors.privateConstructor;
    if (constructor == null || !shouldUseExtends) return '';
    return '${constructor.isConst ? 'const ' : ''}$name._();';
  }

  String get _when {
    if (!allConstructors.shouldGenerateUnions) return '';
    return '${whenPrototype(allConstructors)};';
  }

  String get _maybeWhen {
    if (!allConstructors.shouldGenerateUnions) return '';
    return '${maybeWhenPrototype(allConstructors)};';
  }

  String get _map {
    if (!allConstructors.shouldGenerateUnions) return '';
    return '${mapPrototype(allConstructors, genericsParameter)};';
  }

  String get _maybeMap {
    if (!allConstructors.shouldGenerateUnions) return '';
    return '${maybeMapPrototype(allConstructors, genericsParameter)};';
  }
}

extension on List<ConstructorDetails> {
  ConstructorDetails get privateConstructor {
    for (final c in this) if (c.name == '_') return c;
    return null;
  }
}
