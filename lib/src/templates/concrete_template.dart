import 'package:analyzer/dart/element/element.dart';
import 'package:freezed/src/freezed_generator.dart';
import 'package:meta/meta.dart';

import 'parameter_template.dart';
import 'prototypes.dart';

class Concrete {
  Concrete({
    @required this.constructor,
    @required this.genericsDefinition,
    @required this.genericsParameter,
    @required this.allConstructors,
    @required this.hasDiagnosticable,
    @required this.shouldGenerateJson,
    @required this.commonProperties,
    @required this.name,
  });

  final ConstructorDetails constructor;
  final List<ConstructorDetails> allConstructors;
  final GenericsDefinitionTemplate genericsDefinition;
  final GenericsParameterTemplate genericsParameter;
  final List<Property> commonProperties;
  final bool hasDiagnosticable;
  final bool shouldGenerateJson;
  final String name;

  String get concreteName {
    return '_\$${constructor.redirectedName}';
  }

  @override
  String toString() {
    return '''
${shouldGenerateJson ? '@JsonSerializable()' : ''}
class $concreteName$genericsDefinition $diagnosticable implements ${constructor.redirectedName}$genericsParameter {
  const $concreteName(${constructor.parameters.asThis()});

  $concreteFromJsonConstructor

${constructor.impliedProperties.map((p) => '@override $p').join()}

$toStringMethod

$debugFillProperties

$operatorEqualMethod

$hashCodeMethod

$copyWithMethod

$when

$maybeWhen

$map

$maybeMap

$toJson
}

abstract class ${constructor.redirectedName}$genericsDefinition implements $name$genericsParameter {
  const factory ${constructor.redirectedName}(${constructor.parameters.asExpandedDefinition}) = $concreteName$genericsParameter;

  $redirectedFromJsonConstructor

$abstractProperties

$copyWithPrototype
}
''';
  }

  String get redirectedFromJsonConstructor {
    if (!shouldGenerateJson) return '';
    return 'factory ${constructor.redirectedName}.fromJson(Map<String, dynamic> json) = $concreteName.fromJson;';
  }

  String get concreteFromJsonConstructor {
    if (!shouldGenerateJson) return '';
    return 'factory $concreteName.fromJson(Map<String, dynamic> json) => _\$${concreteName}FromJson(json);';
  }

  String get toJson {
    if (!shouldGenerateJson) return '';

    final addRuntimeType = allConstructors.length > 1
        ? "..['runtimeType'] = '${constructor.isDefault ? 'default' : constructor.name}'"
        : '';

    return '''
@override
Map<String, dynamic> toJson() {
  return _\$${concreteName}ToJson(this)$addRuntimeType;
}''';
  }

  String get debugFillProperties {
    if (!hasDiagnosticable) return '';

    final diagnostics =
        constructor.impliedProperties.map((e) => "..add(DiagnosticsProperty('${e.name}', ${e.name}))").join();

    return '''
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  super.debugFillProperties(properties);
  properties
    ..add(DiagnosticsProperty('type', '${constructor.fullName}'))
    $diagnostics;
}
''';
  }

  String get diagnosticable {
    if (!hasDiagnosticable) return '';

    return 'with DiagnosticableTreeMixin';
  }

  String get maybeMap {
    if (allConstructors.length < 2) return '';

    return '''
@override
${maybeMapPrototype(allConstructors, genericsParameter)} {
  assert(orElse != null);
  if (${constructor.callbackName} != null) {
    return ${constructor.callbackName}(this);
  }
  return orElse();
}''';
  }

  String get map {
    if (allConstructors.length < 2) return '';

    final asserts = [for (final ctor in allConstructors) 'assert(${ctor.callbackName} != null);'];

    return '''
@override
${mapPrototype(allConstructors, genericsParameter)} {
  ${asserts.join()}
  return ${constructor.callbackName}(this);
}''';
  }

  String get maybeWhen {
    if (allConstructors.length < 2) return '';

    return '''
@override
${maybeWhenPrototype(allConstructors)} {
  assert(orElse != null);
  if (${constructor.callbackName} != null) {
    return ${constructor.callbackName}(${constructor.impliedProperties.map((e) => e.name).join(',')});
  }
  return orElse();
}''';
  }

  String get when {
    if (allConstructors.length < 2) return '';

    final asserts = [for (final ctor in allConstructors) 'assert(${ctor.callbackName} != null);'];

    return '''
@override
${whenPrototype(allConstructors)} {
  ${asserts.join()}
  return ${constructor.callbackName}(${constructor.impliedProperties.map((e) => e.name).join(',')});
}''';
  }

  String get abstractProperties {
    return constructor.impliedProperties.map((p) {
      if (commonProperties.any((element) => element.name == p.name)) {
        return '@override ${p.getter}';
      } else {
        return '${p.getter}';
      }
    }).join();
  }

  String get toStringMethod {
    final parameters = hasDiagnosticable ? '{ DiagnosticLevel minLevel = DiagnosticLevel.debug }' : '';

    final properties = constructor.impliedProperties.map((p) {
      return '${p.name}: \$${p.name}';
    });

    return '''
@override
String toString($parameters) {
  return '${constructor.fullName}(${properties.join(', ')})';
}
''';
  }

  String get copyWithPrototype {
    if (constructor.impliedProperties.isEmpty) return '';

    final parameters = constructor.impliedProperties.map((p) {
      return '${p.decorators.join()} ${p.type} ${p.name}';
    }).join(',');

    final result = '''
${constructor.redirectedName}$genericsParameter copyWith({
$parameters
});
''';

    if (commonProperties.isNotEmpty) {
      return '@override $result';
    } else {
      return result;
    }
  }

  String get copyWithMethod {
    if (constructor.impliedProperties.isEmpty) return '';

    final parameters = constructor.impliedProperties.map((p) {
      return 'Object ${p.name} = immutable,';
    }).join();

    final constructorParameters = StringBuffer();

    String parameterToValue(Parameter p) {
      var ternary = '${p.name} == immutable ? this.${p.name} : ${p.name}';
      if (p.type != 'Object') {
        ternary = '$ternary as ${p.type}';
      }
      return '$ternary,';
    }

    constructorParameters
      ..writeAll(
        [
          ...constructor.parameters.positionalParameters,
          ...constructor.parameters.optionalPositionalParameters,
        ].map<String>(parameterToValue),
      )
      ..writeAll(
        constructor.parameters.namedParameters.map<String>(
          (p) {
            return '${p.name}: ${parameterToValue(p)}';
          },
        ),
      );

    return '''
@override
$concreteName$genericsParameter copyWith({$parameters}) {
  return $concreteName$genericsParameter(
$constructorParameters
  );
}
''';
  }

  String get operatorEqualMethod {
    final properties = constructor.impliedProperties.map((p) {
      return '(identical(other.${p.name}, ${p.name}) || other.${p.name} == ${p.name})';
    });

    return '''
@override
bool operator ==(dynamic other) {
  return other is ${['${constructor.redirectedName}$genericsParameter', ...properties].join('&&')};
}
''';
  }

  String get hashCodeMethod {
    var hashCodeImpl =
        'runtimeType.hashCode ${constructor.impliedProperties.map((p) => '^ ${p.name}.hashCode').join()}';

    return '''
@override
int get hashCode => $hashCodeImpl;
''';
  }
}

class Property {
  final String type;
  final String name;
  final List<String> decorators;

  Property({
    @required this.type,
    @required this.name,
    @required this.decorators,
  });

  factory Property.fromParameter(ParameterElement element) {
    return Property(
      name: element.name,
      type: element.type?.getDisplayString(),
      decorators: parseDecorators(element.metadata),
    );
  }

  @override
  String toString() {
    return '${decorators.join()} final ${type ?? 'dynamic'} $name;';
  }

  Getter get getter => Getter(name: name, type: type, decorators: decorators);
}

class Getter {
  final String type;
  final String name;
  final List<String> decorators;

  Getter({@required this.type, @required this.name, @required this.decorators});

  @override
  String toString() {
    return '${decorators.join()} ${type ?? 'dynamic'} get $name;';
  }
}

extension PropertiesAsGetters on List<Property> {
  List<Getter> asGetters() {
    return map((p) => p.getter).toList();
  }
}
