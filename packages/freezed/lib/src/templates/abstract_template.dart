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
        .expand((e) {
          return <ClassMember?>[
            e.unimplementedGetter,
            if (!e.isFinal &&
                // Don't add a setter for a field where the setters type is not
                // a subtype of the getters type.
                !(e.commonSupertype != null &&
                    e.commonSubtype != e.commonSupertype))
              e.unimplementedSetter,
          ];
        })
        .whereType<ClassMember>()
        .map((e) => e.toString())
        .join();

    return '''
/// @nodoc
mixin _\$${data.name}${data.genericsDefinitionTemplate} {

$abstractProperties
$_when
$_whenOrNull
$_maybeWhen
$_map
$_mapOrNull
$_maybeMap
$_toJson
${copyWith?.abstractCopyWithGetter ?? ''}
}

${copyWith?.interface ?? ''}

${copyWith?.commonContreteImpl ?? ''}
''';
  }

  String get _toJsonParams => toJsonParameters(
      data.genericsParameterTemplate, data.genericArgumentFactories);
  String get _toJson {
    if (!data.generateToJson) return '';
    return 'Map<String, dynamic> toJson($_toJsonParams)'
        ' => throw $privConstUsedErrorVarName;';
  }

  String get _when {
    if (!data.when.when) return '';
    return '${whenPrototype(data.constructors)} => throw $privConstUsedErrorVarName;';
  }

  String get _whenOrNull {
    if (!data.when.whenOrNull) return '';
    return '${whenOrNullPrototype(data.constructors)} => throw $privConstUsedErrorVarName;';
  }

  String get _maybeWhen {
    if (!data.when.maybeWhen) return '';
    return '${maybeWhenPrototype(data.constructors)} => throw $privConstUsedErrorVarName;';
  }

  String get _map {
    if (!data.map.map) return '';
    return '${mapPrototype(data.constructors, data.genericsParameterTemplate)} => throw $privConstUsedErrorVarName;';
  }

  String get _mapOrNull {
    if (!data.map.mapOrNull) return '';
    return '${mapOrNullPrototype(data.constructors, data.genericsParameterTemplate)} => throw $privConstUsedErrorVarName;';
  }

  String get _maybeMap {
    if (!data.map.maybeMap) return '';
    return '${maybeMapPrototype(data.constructors, data.genericsParameterTemplate)} => throw $privConstUsedErrorVarName;';
  }
}
