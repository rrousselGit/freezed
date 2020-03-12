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
        superClass == null ? '' : 'implements $superClass$genericsParameter';
    return '''
abstract class $_className$genericsDefinition $implements {
${_copyWithPrototype('call')}

${_abstractDeepCopyMethods().join()}
}''';
  }

  Iterable<String> _abstractDeepCopyMethods() sync* {
    for (final cloneableProperty in cloneableProperties) {
      yield _copyWithProtypeFor(
        returnType: clonedClassName,
        methodName: cloneableProperty.name,
        properties: cloneableProperty.associatedData.commonProperties,
      );
    }
  }

  String _copyWithPrototype(String methodName) {
    if (allProperties.isEmpty) return '';

    return _maybeOverride(_copyWithProtypeFor(
      returnType: '$clonedClassName$genericsParameter',
      methodName: methodName,
      properties: allProperties,
    ));
  }

  String _copyWithProtypeFor({
    @required String returnType,
    @required String methodName,
    @required List<Property> properties,
  }) {
    final parameters = properties.map((p) {
      return '${p.decorators.join()} ${p.type} ${p.name}';
    }).join(',');

    return _maybeOverride('''
$returnType $methodName({
$parameters
});
''');
  }

  String get abstractCopyWithGetter {
    if (allProperties.isEmpty) return '';
    return _maybeOverride(
      '$_className$genericsParameter get copyWith;',
    );
  }

  String get concreteCopyWithGetter {
    if (allProperties.isEmpty) return '';
    return '''
@override
$_className$genericsParameter get copyWith => _\$$_className$genericsParameter(this);
''';
  }

  String _copyWithMethod(ParametersTemplate parametersTemplate) {
    if (allProperties.isEmpty) return '';

    final prototype = _concreteCopyWithPrototype(
      properties: allProperties,
      returnType: '$clonedClassName$genericsParameter',
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
  return $returnType(
$constructorParameters
  );
}''';
  }

  String _concreteCopyWithPrototype({
    @required List<Property> properties,
    @required String returnType,
    @required String methodName,
  }) {
    final parameters = properties.map((p) {
      return 'Object ${p.name} = freezed,';
    }).join();

    return '$returnType $methodName({$parameters})';
  }

  /// The implementation of the callable class that contains both the copyWith
  /// and the cloneable properties.
  String concreteImpl(ParametersTemplate parametersTemplate) {
    if (allProperties.isEmpty) return '';
    return '''
class _\$$_className$genericsDefinition implements $_className$genericsParameter {
  _\$$_className(this._value);

final $clonedClassName$genericsParameter _value;

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
        returnType: clonedClassName,
        methodName: cloneableProperty.name,
        properties: cloneableProperty.associatedData.commonProperties,
      );
      yield '''
@override $prototype {
  return $clonedClassName($constructorParameters);
}''';
    }
  }

  String _maybeOverride(String res) {
    return superClass != null ? '@override $res' : res;
  }

  String get _className => interfaceNameFrom(clonedClassName);
}
