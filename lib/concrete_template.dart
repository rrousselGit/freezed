import 'package:immutable/parameter_template.dart';

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
class _\$Object$interface {
  const _\$Object$interface();
}

const _\$default$interface = _\$Object$interface();

class $name implements $interface {
  const $name($constructorParameters);

${properties.join()}

$toStringMethod

$operatorEqualMethod

$hashCodeMethod

$toJSONMethod

$copyWithMethod
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

  String get copyWithMethod {
    final defaultVar = '_\$default$interface';
    final parameters = properties.map((p) {
      return 'Object ${p.name} = $defaultVar,';
    }).join();

    final constructorParameters = StringBuffer();

    String parameterToValue(Parameter p) {
      var ternary = '${p.name} == $defaultVar ? this.${p.name} : ${p.name}';
      if (p.type != 'Object') {
        ternary = '$ternary as ${p.type}';
      }
      return '$ternary,';
    }

    constructorParameters
      ..writeAll(
        [
          ...this.constructorParameters.positionalParameters,
          ...this.constructorParameters.optionalPositionalParameters
        ].map<String>(parameterToValue),
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
$interface copyWith({
$parameters
}) {
  return $interface(
$constructorParameters
  );
}
''';
  }

  String get toJSONMethod {
    final properties = this.properties.map((p) {
      return "'${p.name}': ${p.name},";
    }).join();

    return '''
Map<String, dynamic> toJSON() {
  return <String, dynamic>{
$properties
  };
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
}
