import 'package:analyzer/dart/element/element.dart';
import 'package:freezed/src/freezed_generator.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';
import 'package:freezed_annotation/freezed_annotation.dart' as annotations;

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
  $isConst $concreteName(${constructor.parameters.asThis()})$asserts;

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
$copyAs
}

abstract class ${constructor.redirectedName}$genericsDefinition implements $name$genericsParameter {
  $isConst factory ${constructor.redirectedName}(${constructor.parameters.asExpandedDefinition}) = $concreteName$genericsParameter;

  $redirectedFromJsonConstructor

$abstractProperties
$copyWithPrototype
$copyAsPrototype
}
''';
  }

  String get asserts {
    final nonNullableProperties = constructor.impliedProperties.where((p) => !p.nullable).toList();
    if (nonNullableProperties.isEmpty) return '';
    return ': ${nonNullableProperties.map((e) => 'assert(${e.name} != null)').join(',')}';
  }

  String get isConst {
    return constructor.isConst ? 'const' : '';
  }

  String get copyAs {
    final res = StringBuffer();
    for (final targetConstructor in allConstructors) {
      var copyAsParameters = targetConstructor.impliedProperties.map((property) {
        final isRequired = targetConstructor.isPropertyWithNamedRequired(property.name);
        return Parameter(
          decorators: const [],
          isRequired: isRequired,
          name: property.name,
          defaultValue: isRequired ? null : 'immutable',
          type: isRequired ? property.type : 'Object',
        );
      });

      final constructorParameters = StringBuffer();
      for (final e in copyAsParameters) {
        var param = StringBuffer();
        if (targetConstructor.parameters.namedParameters.any((element) => e.name == element.name)) {
          param.write('${e.name}: ');
        }

        final targetProperty = targetConstructor.parameterWithName(e.name);
        final hasMatchingLocalProperty = constructor.hasMatchingPropertyWith(name: e.name, type: e.type);
        if (e.isRequired) {
          param.write('${e.name} as ${targetProperty.type}');
        } else if (hasMatchingLocalProperty) {
          param.write('${e.name} == immutable ? this.${e.name} : ${e.name} as ${targetProperty.type}');
        } else {
          param.clear();
        }

        if (param.isNotEmpty) constructorParameters..write(param)..write(',');
      }

      res.write('''
@override
${targetConstructor.redirectedName}$genericsParameter ${targetConstructor.copyAsName}(${copyAsParameters.isNotEmpty ? '{${copyAsParameters.join(',')}}' : ''}) {
  return ${targetConstructor.redirectedName}$genericsParameter($constructorParameters);
}
''');
    }
    return res.toString();
  }

  String get copyAsPrototype {
    final res = StringBuffer();
    for (final constructor in allConstructors) {
      var parameter = constructor.impliedProperties.map((property) {
        return Parameter(
          decorators: property.decorators,
          isRequired:
              this.constructor.impliedProperties.every((commonProperty) => commonProperty.name != property.name),
          name: property.name,
          type: property.type,
        );
      }).join(',');
      if (parameter.isNotEmpty) {
        parameter = '{$parameter}';
      }

      res.write('''
@override
${constructor.redirectedName}$genericsParameter ${constructor.copyAsName}($parameter);
''');
    }
    return res.toString();
  }

  String get redirectedFromJsonConstructor {
    if (!shouldGenerateJson) return '';
    return 'factory ${constructor.redirectedName}.fromJson(Map<String, dynamic> json) = $concreteName$genericsParameter.fromJson;';
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

    var callbackParameters = constructor.impliedProperties.map((e) {
      if (allConstructors.any((c) => c.callbackName == e.name)) {
        return 'this.${e.name}';
      }
      return e.name;
    }).join(',');

    return '''
@override
${maybeWhenPrototype(allConstructors)} {
  assert(orElse != null);
  if (${constructor.callbackName} != null) {
    return ${constructor.callbackName}($callbackParameters);
  }
  return orElse();
}''';
  }

  String get when {
    if (allConstructors.length < 2) return '';

    final asserts = [for (final ctor in allConstructors) 'assert(${ctor.callbackName} != null);'];

    var callbackParameters = constructor.impliedProperties.map((e) {
      if (allConstructors.any((c) => c.callbackName == e.name)) {
        return 'this.${e.name}';
      }
      return e.name;
    }).join(',');

    return '''
@override
${whenPrototype(allConstructors)} {
  ${asserts.join()}
  return ${constructor.callbackName}($callbackParameters);
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
    final parameters = hasDiagnosticable ? '{ DiagnosticLevel minLevel = DiagnosticLevel.info }' : '';

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
      return 'Object ${p.name} = freezed,';
    }).join();

    final constructorParameters = StringBuffer();

    String parameterToValue(Parameter p) {
      var ternary = '${p.name} == freezed ? this.${p.name} : ${p.name}';
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

    final asserts =
        constructor.impliedProperties.where((p) => !p.nullable).map((e) => 'assert(${e.name} != null);').join();

    return '''
@override
$concreteName$genericsParameter copyWith({$parameters}) {
  $asserts
  return $concreteName$genericsParameter(
$constructorParameters
  );
}
''';
  }

  String get operatorEqualMethod {
    final properties = constructor.impliedProperties.map((p) {
      return '(identical(other.${p.name}, ${p.name}) || const DeepCollectionEquality().equals(other.${p.name}, ${p.name}))';
    });

    return '''
@override
bool operator ==(dynamic other) {
  return identical(this, other) || (other is ${[
      '${constructor.redirectedName}$genericsParameter',
      ...properties
    ].join('&&')});
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

extension on Element {
  bool get hasNullable {
    return TypeChecker.fromRuntime(annotations.nullable.runtimeType).hasAnnotationOf(this, throwOnUnresolved: false);
  }
}

extension IsNullable on ParameterElement {
  bool get isNullable => isOptionalPositional || hasNullable || (isNamed && !hasRequired);
}

class Property {
  final String type;
  final String name;
  final List<String> decorators;
  final bool nullable;

  Property({
    @required this.type,
    @required this.name,
    @required this.decorators,
    @required this.nullable,
  });

  factory Property.fromParameter(ParameterElement element) {
    return Property(
      name: element.name,
      type: element.type?.getDisplayString(),
      decorators: parseDecorators(element.metadata),
      nullable: element.isNullable,
    );
  }

  @override
  String toString() {
    return '${decorators.join()} final ${type ?? 'dynamic'} $name;';
  }

  Getter get getter => Getter(name: name, type: type, decorators: decorators, nullable: nullable);
}

class Getter {
  final String type;
  final String name;
  final List<String> decorators;
  final bool nullable;

  Getter({
    @required this.type,
    @required this.name,
    @required this.decorators,
    @required this.nullable,
  });

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
