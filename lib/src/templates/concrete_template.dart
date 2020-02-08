import 'package:analyzer/dart/element/element.dart';
import 'package:immutable/src/templates/prototypes.dart';
import 'package:meta/meta.dart';

import 'abstract_template.dart';
import 'parameter_template.dart';

class Concrete {
  Concrete({
    @required this.name,
    @required this.interface,
    @required this.allConstructors,
    @required this.constructorName,
    @required this.constructorParameters,
    @required this.properties,
    @required this.superProperties,
  });

  final String name;
  final String interface;
  final String constructorName;
  final ParametersTemplate constructorParameters;
  final List<Property> properties;
  final List<Property> superProperties;
  final List<ConstructorElement> allConstructors;

  @override
  String toString() {
    return '''
class _\$$name implements $name {
  const _\$$name($constructorParameters);

${properties.map((p) => '@override $p').join()}

$toStringMethod

$operatorEqualMethod

$hashCodeMethod

$copyWithMethod

$when

$maybeWhen
}

abstract class $name implements $interface {
  const factory $name(${constructorParameters.asExpandedDefinition}) = _\$$name;

$abstractProperties

$copyWithPrototype
}
''';
  }

  String get maybeWhen {
    if (allConstructors.length < 2) return '';

    final callbackName = constructorNameToCallbackName(constructorName);

    return '''
@override
${maybeWhenPrototype(allConstructors)} {
  assert(orElse != null);
  if ($callbackName != null) {
    return $callbackName(${properties.map((e) => e.name).join(',')});
  }
  return orElse();
}''';
  }

  String get when {
    if (allConstructors.length < 2) return '';
    final callbackName = constructorNameToCallbackName(constructorName);

    final asserts = [
      for (final ctor in allConstructors) 'assert(${constructorNameToCallbackName(ctor.name)} != null);'
    ];

    return '''
@override
${whenPrototype(allConstructors)} {
  ${asserts.join()}
  return $callbackName(${properties.map((e) => e.name).join(',')});
}''';
  }

  String get abstractProperties {
    return properties.map((p) {
      if (superProperties.any((element) => element.name == p.name))
        return '@override ${p.getter}';
      else
        return '${p.getter}';
    }).join();
  }

  String get toStringMethod {
    final properties = this.properties.map((p) {
      return '${p.name}: \$${p.name}';
    });
    final className = constructorName == null || constructorName.isEmpty ? interface : '$interface.$constructorName';

    return '''
@override
String toString() {
  return '$className(${properties.join(', ')})';
}
''';
  }

  String get copyWithPrototype {
    if (properties.isEmpty) return '';

    final parameters = properties.map((p) {
      return '${p.type} ${p.name}';
    }).join(',');

    final result = '''
$name copyWith({
$parameters
});
''';

    if (superProperties.isNotEmpty)
      return '@override $result';
    else
      return result;
  }

  String get copyWithMethod {
    if (properties.isEmpty) return '';

    final parameters = properties.map((p) {
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
        [...this.constructorParameters.positionalParameters, ...this.constructorParameters.optionalPositionalParameters]
            .map<String>(parameterToValue),
      )
      ..writeAll(
        this.constructorParameters.namedParameters.map<String>(
          (p) {
            return '${p.name}: ${parameterToValue(p)}';
          },
        ),
      );

    return '''
@override
_\$$name copyWith({$parameters}) {
  return _\$$name(
$constructorParameters
  );
}
''';
  }

  String get operatorEqualMethod {
    final properties = this.properties.map((p) {
      return 'other.${p.name} == ${p.name}';
    });

    return '''
@override
bool operator ==(dynamic other) {
  return other is ${[name, ...properties].join('&&')};
}
''';
  }

  String get hashCodeMethod {
    var hashCodeImpl = 'runtimeType.hashCode ${properties.map((p) => '^ ${p.name}.hashCode').join()}';

    return '''
@override
int get hashCode => $hashCodeImpl;
''';
  }
}

class Property {
  final String type;
  final String name;

  Property({this.type, this.name});

  @override
  String toString() {
    return 'final ${type ?? 'dynamic'} $name;';
  }

  Getter get getter => Getter(name: name, type: type);
}
