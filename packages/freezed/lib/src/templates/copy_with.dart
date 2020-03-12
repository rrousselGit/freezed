import 'package:freezed/src/templates/concrete_template.dart';
import 'package:freezed/src/templates/parameter_template.dart';
import 'package:meta/meta.dart';

class CopyWith {
  CopyWith({
    @required this.clonedClassName,
    @required this.genericsDefinition,
    @required this.genericsParameter,
    @required this.clonneableProperty,
    this.superClass,
  });

  static String interfaceNameFrom(String name) {
    if (name.startsWith('_')) {
      return '_\$${name.substring(1)}CopyWith';
    }
    return '\$${name}CopyWith';
  }

  final String clonedClassName;
  final GenericsDefinitionTemplate genericsDefinition;
  final GenericsParameterTemplate genericsParameter;
  final List<Property> clonneableProperty;
  final String superClass;

  String get interface {
    if (clonneableProperty.isEmpty) return '';

    var implements =
        superClass == null ? '' : 'implements $superClass$genericsParameter';
    return '''
abstract class $_className$genericsDefinition $implements {
${_copyWithPrototype('call', trailing: ';')}
}''';
  }

  String _copyWithPrototype(String methodName, {String trailing = ''}) {
    if (clonneableProperty.isEmpty) return '';

    final parameters = clonneableProperty.map((p) {
      return '${p.decorators.join()} ${p.type} ${p.name}';
    }).join(',');

    return _maybeOverride('''
$clonedClassName$genericsParameter $methodName({
$parameters
})$trailing
''');
  }

  String get abstractMethod {
    if (clonneableProperty.isEmpty) return '';
    return _maybeOverride(
      '$_className$genericsParameter get copyWith;',
    );
  }

  String get concreteMethod {
    if (clonneableProperty.isEmpty) return '';
    return '''
@override
$_className$genericsParameter get copyWith => _\$$_className$genericsParameter(this);
''';
  }

  String concreteImpl(ParametersTemplate parametersTemplate) {
    if (clonneableProperty.isEmpty) return '';
    return '''
class _\$$_className$genericsDefinition implements $_className$genericsParameter {
  _\$$_className(this._value);

final $clonedClassName$genericsParameter _value;

${_copyWithMethod(parametersTemplate)}
}''';
  }

  String _copyWithMethod(ParametersTemplate parametersTemplate) {
    if (clonneableProperty.isEmpty) return '';

    final parameters = clonneableProperty.map((p) {
      return 'Object ${p.name} = freezed,';
    }).join();

    String parameterToValue(Parameter p) {
      var ternary = '${p.name} == freezed ? _value.${p.name} : ${p.name}';
      if (p.type != 'Object') {
        ternary = '$ternary as ${p.type}';
      }
      return '$ternary,';
    }

    final constructorParameters = StringBuffer()
      ..writeAll(
        [
          ...parametersTemplate.requiredPositionalParameters,
          ...parametersTemplate.optionalPositionalParameters,
        ].map<String>(parameterToValue),
      )
      ..writeAll(
        parametersTemplate.namedParameters.map<String>(
          (p) {
            return '${p.name}: ${parameterToValue(p)}';
          },
        ),
      );

    return '''
@override
$clonedClassName$genericsParameter call({$parameters}) {
  return $clonedClassName$genericsParameter(
$constructorParameters
  );
}
''';
  }

  String _maybeOverride(String res) {
    return superClass != null ? '@override $res' : res;
  }

  String get _className => interfaceNameFrom(clonedClassName);
}
