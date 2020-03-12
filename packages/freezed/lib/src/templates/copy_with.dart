import 'package:freezed/src/templates/concrete_template.dart';
import 'package:freezed/src/templates/parameter_template.dart';
import 'package:meta/meta.dart';

import '../freezed_generator.dart';

class CopyWith {
  CopyWith({
    @required this.clonedClassName,
    @required this.genericsDefinition,
    @required this.genericsParameter,
    @required this.allProperties,
    @required this.cloneableProperties,
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
  final List<Property> allProperties;
  final List<CloneableProperty> cloneableProperties;
  final String superClass;

  String get interface {
    if (allProperties.isEmpty) return '';

    var implements =
        superClass == null ? '' : 'implements $superClass${genericsParameter.append('\$Res')}';
    return '''
abstract class $_className${genericsDefinition.append('\$Res')} $implements {
${_copyWithPrototype('call')}

${_abstractDeepCopyMethods().join()}
}''';
  }

  Iterable<String> _abstractDeepCopyMethods() sync* {
    for (final cloneableProperty in cloneableProperties) {
      yield _copyWithProtypeFor(
        methodName: cloneableProperty.name,
        properties: cloneableProperty.associatedData.commonProperties,
      );
    }
  }

  String _copyWithPrototype(String methodName) {
    if (allProperties.isEmpty) return '';

    return _maybeOverride(_copyWithProtypeFor(
      methodName: methodName,
      properties: allProperties,
    ));
  }

  String _copyWithProtypeFor({
    @required String methodName,
    @required List<Property> properties,
  }) {
    final parameters = properties.map((p) {
      return '${p.decorators.join()} ${p.type} ${p.name}';
    }).join(',');

    return _maybeOverride('''
\$Res $methodName({
$parameters
});
''');
  }

  String get abstractCopyWithGetter {
    if (allProperties.isEmpty) return '';
    return _maybeOverride(
      '$_className${genericsParameter.append(clonedClassName)} get copyWith;',
    );
  }

  String get concreteCopyWithGetter {
    if (allProperties.isEmpty) return '';
    return '''
@override
$_className${genericsParameter.append(clonedClassName)} get copyWith => _\$$_className${genericsParameter.append(clonedClassName)}(this, _\$identity);
''';
  }

  String _copyWithMethod(ParametersTemplate parametersTemplate) {
    if (allProperties.isEmpty) return '';

    final prototype = _concreteCopyWithPrototype(
      properties: allProperties,
      methodName: 'call',
    );

    final body = _copyWithMethodBody(
      parametersTemplate: parametersTemplate,
      returnType: '$clonedClassName$genericsParameter',
    );

    return '@override $prototype $body';
  }

  String _copyWithMethodBody({
    String accessor = '_value',
    @required ParametersTemplate parametersTemplate,
    @required String returnType,
  }) {
    String parameterToValue(Parameter p) {
      var ternary = '${p.name} == freezed ? $accessor.${p.name} : ${p.name}';
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

    return '''{
  return _then($returnType(
$constructorParameters
  ));
}''';
  }

  String _concreteCopyWithPrototype({
    @required List<Property> properties,
    @required String methodName,
  }) {
    final parameters = properties.map((p) {
      return 'Object ${p.name} = freezed,';
    }).join();

    return '\$Res $methodName({$parameters})';
  }

  /// The implementation of the callable class that contains both the copyWith
  /// and the cloneable properties.
  String concreteImpl(ParametersTemplate parametersTemplate) {
    if (allProperties.isEmpty) return '';
    return '''
class _\$$_className${genericsDefinition.append('\$Res')} implements $_className${genericsParameter.append('\$Res')} {
  _\$$_className(this._value, this._then);

final $clonedClassName$genericsParameter _value;
final \$Res Function($clonedClassName$genericsParameter) _then;

${_copyWithMethod(parametersTemplate)}

${_deepCopyMethods(parametersTemplate).join()}
}''';
  }

  Iterable<String> _deepCopyMethods(
    ParametersTemplate parametersTemplate,
  ) sync* {
    for (final cloneableProperty in cloneableProperties) {
      String parameterToValue(Parameter p) {
        if (p.name == cloneableProperty.name) {
          String parameterToValue(Parameter p) {
            var ternary =
                '${p.name} == freezed ? _value.${cloneableProperty.name}.${p.name} : ${p.name}';
            if (p.type != 'Object') {
              ternary = '$ternary as ${p.type}';
            }
            return '$ternary,';
          }

          final constructorParameters = StringBuffer()
            ..writeAll(
              [
                ...cloneableProperty.associatedData.constructors.first
                    .parameters.requiredPositionalParameters,
                ...cloneableProperty.associatedData.constructors.first
                    .parameters.optionalPositionalParameters,
              ].map<String>(parameterToValue),
            )
            ..writeAll(
              cloneableProperty
                  .associatedData.constructors.first.parameters.namedParameters
                  .map<String>(
                (p) {
                  return '${p.name}: ${parameterToValue(p)}';
                },
              ),
            );

          return '${cloneableProperty.type}($constructorParameters),';
        } else {
          return '_value.${p.name},';
        }
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

      final prototype = _concreteCopyWithPrototype(
        methodName: cloneableProperty.name,
        properties: cloneableProperty.associatedData.commonProperties,
      );
      yield '''
@override $prototype {
  return _then($clonedClassName($constructorParameters),);
}''';
    }
  }

  String _maybeOverride(String res) {
    return superClass != null ? '@override $res' : res;
  }

  String get _className => interfaceNameFrom(clonedClassName);
}
