import 'abstract_template.dart';
import 'parameter_template.dart';

class Concrete {
  Concrete(
    this.name,
    this.interface,
    this.constructorParameters,
    this.properties,
  );

  final String name;
  final String interface;
  final ParametersTemplate constructorParameters;
  final List<Property> properties;

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
}

abstract class $name implements $interface {
  const factory $name(${constructorParameters.asExpandedDefinition}) = _\$$name;

$copyWithPrototype
}
''';
  }

  String get toStringMethod {
    final properties = this.properties.map((p) {
      return '${p.name}: \$${p.name}';
    });
    return '''
@override
String toString() {
  return '$interface(${properties.join(', ')})';
}
''';
  }

  String get copyWithPrototype {
    final parameters = properties.map((p) {
      return '${p.type} ${p.name}';
    }).join(',');

    return '''
@override
$name copyWith({
$parameters
});
''';
  }

  String get copyWithMethod {
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
_\$$name copyWith({
$parameters
}) {
  return _\$$name(
$constructorParameters
  );
}
''';
  }

  String get operatorEqualMethod {
    final properties = this.properties.map((p) {
      return 'other.${p.name} == ${p.name}';
    }).join('&&');

    return '''
@override
bool operator ==(dynamic other) {
  return other is $name && $properties;
}
''';
  }

  String get hashCodeMethod {
    return '''
@override
int get hashCode => ${properties.map((p) => '${p.name}.hashCode').join('^')};
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
