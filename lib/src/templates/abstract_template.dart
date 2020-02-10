import 'package:analyzer/dart/element/element.dart';
import 'package:meta/meta.dart';

import 'parameter_template.dart';
import 'prototypes.dart';

class Abstract {
  Abstract({
    @required this.name,
    @required this.interface,
    @required this.typeParameters,
    @required this.properties,
    @required this.hasJson,
    @required this.allConstructors,
  });

  final String name;
  final String interface;
  final List<Getter> properties;
  final List<TypeParameterElement> typeParameters;
  final List<ConstructorElement> allConstructors;
  final bool hasJson;

  @override
  String toString() {
    return '''
abstract class $name${GenericsDefinitionTemplate(typeParameters)} {
${properties.join()}

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
    if (!hasJson) return '';

    return 'Map<String, dynamic> toJson();';
  }

  String get copyWithPrototype {
    if (properties.isEmpty) return '';
    final parameters = properties.map((p) {
      return '${p.type} ${p.name}';
    }).join(',');

    return '''
$interface${GenericsParameterTemplate(typeParameters)} copyWith({
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
    return '${mapPrototype(allConstructors, typeParameters)};';
  }

  String get maybeMap {
    if (allConstructors.length < 2) return '';
    return '${maybeMapPrototype(allConstructors, typeParameters)};';
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
