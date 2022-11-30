import 'package:freezed/src/templates/parameter_template.dart';
import 'package:freezed/src/templates/properties.dart';

import '../models.dart';

class CopyWith {
  CopyWith({
    required this.clonedClassName,
    required this.genericsDefinition,
    required this.genericsParameter,
    required this.cloneableProperties,
    required this.readableProperties,
    required this.deepCloneableProperties,
    required this.data,
    this.parent,
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
  final List<Property> cloneableProperties;
  final List<Property> readableProperties;
  final List<DeepCloneableProperty> deepCloneableProperties;
  final CopyWith? parent;
  final Data data;

  /// When collections are wrapped in an UnmodifiableView, this bool determines
  /// if the raw collection can be accessed instead.
  bool get canAccessRawCollection => parent != null;

  String get interface => _deepCopyInterface(appendGenericToFactory: false);
  String get commonInterface =>
      _deepCopyInterface(appendGenericToFactory: true);

  String _deepCopyInterface({required bool appendGenericToFactory}) {
    var implements = _hasSuperClass
        ? 'implements ${parent!._abstractClassName}${genericsParameter.append('\$Res')}'
        : '';
    var implGenerics = genericsParameter.append('\$Res');
    if (appendGenericToFactory) {
      implGenerics = implGenerics.append('$clonedClassName$genericsParameter');
    }
    return '''
/// @nodoc
abstract class $_abstractClassName${genericsDefinition.append('\$Res')} $implements {
  factory $_abstractClassName($clonedClassName$genericsParameter value, \$Res Function($clonedClassName$genericsParameter) then) = $_implClassName$implGenerics;
${_copyWithPrototype('call')}

${_abstractDeepCopyMethods().join()}
}''';
  }

  String get abstractCopyWithGetter {
    if (cloneableProperties.isEmpty) return '';

    return _maybeOverride(
      '''
@JsonKey(ignore: true)
$_abstractClassName${genericsParameter.append('$clonedClassName$genericsParameter')} get copyWith => throw $privConstUsedErrorVarName;
''',
    );
  }

  String get concreteCopyWithGetter {
    if (cloneableProperties.isEmpty) return '';
    return '''
@JsonKey(ignore: true)
@override
@pragma('vm:prefer-inline')
$_abstractClassName${genericsParameter.append('$clonedClassName$genericsParameter')} get copyWith => $_implClassName${genericsParameter.append('$clonedClassName$genericsParameter')}(this, _\$identity);
''';
  }

  String get commonConcreteImpl {
    var copyWith = '';

    if (cloneableProperties.isNotEmpty) {
      final prototype = _concreteCopyWithPrototype(
        properties: cloneableProperties,
        methodName: 'call',
      );

      final body = _copyWithMethodBody(
        parametersTemplate: ParametersTemplate(
          const [],
          namedParameters: cloneableProperties.map((e) {
            return Parameter(
              decorators: e.decorators,
              name: e.name,
              isNullable: e.isNullable,
              isFinal: false,
              isDartList: false,
              isDartMap: false,
              isDartSet: false,
              showDefaultValue: false,
              isRequired: false,
              defaultValueSource: '',
              type: e.type,
              doc: e.doc,
              isPossiblyDartCollection: e.isPossiblyDartCollection,
              parameterElement: null,
            );
          }).toList(),
        ),
        returnType: '_value.copyWith',
        returnCast: 'as \$Val',
      );

      copyWith = '@pragma(\'vm:prefer-inline\') @override $prototype $body';
    }

    return '''
/// @nodoc
class $_implClassName${genericsDefinition.append('\$Res').append('\$Val extends $clonedClassName$genericsParameter')} implements $_abstractClassName${genericsParameter.append('\$Res')} {
  $_implClassName(this._value, this._then);

  // ignore: unused_field
  final \$Val _value;
  // ignore: unused_field
  final \$Res Function(\$Val) _then;

$copyWith
${_deepCopyMethods(isConcrete: false).join()}
}
''';
  }

  /// The implementation of the callable class that contains both the copyWith
  /// and the cloneable properties.
  String concreteImpl(ParametersTemplate parametersTemplate) {
    return '''
/// @nodoc
class $_implClassName${genericsDefinition.append('\$Res')} extends ${parent!._implClassName}${genericsParameter.append('\$Res').append('$clonedClassName$genericsParameter')} implements $_abstractClassName${genericsParameter.append('\$Res')} {
  $_implClassName($clonedClassName$genericsParameter _value, \$Res Function($clonedClassName$genericsParameter) _then)
      : super(_value, _then);


${_copyWithMethod(parametersTemplate)}

${_deepCopyMethods(isConcrete: true).join()}
}''';
  }

  bool get _hasSuperClass {
    return parent != null && parent!.cloneableProperties.isNotEmpty;
  }

  Iterable<String> _abstractDeepCopyMethods() sync* {
    for (final deepCloneableProperty in deepCloneableProperties) {
      var leading = '';
      if (_hasSuperClass &&
          parent!.deepCloneableProperties
              .any((c) => c.name == deepCloneableProperty.name)) {
        leading = '@override ';
      }

      final nullabilitySuffix = deepCloneableProperty.nullable ? '?' : '';

      yield '$leading${_clonerInterfaceFor(deepCloneableProperty)}$nullabilitySuffix get ${deepCloneableProperty.name};';
    }
  }

  String _copyWithPrototype(String methodName) {
    if (cloneableProperties.isEmpty) return '';

    return _copyWithProtypeFor(
      methodName: methodName,
      properties: cloneableProperties,
    );
  }

  String _concreteCopyWithPrototype({
    required List<Property> properties,
    required String methodName,
  }) {
    final parameters = properties.map((p) {
      return 'Object? ${p.name} = ${_defaultValue(isNullable: p.isNullable)},';
    }).join();

    return '\$Res $methodName({$parameters})';
  }

  String _copyWithProtypeFor({
    required String methodName,
    required List<Property> properties,
  }) {
    final parameters = properties.map((p) {
      return '${p.decorators.join()} ${p.type} ${p.name}';
    }).join(',');

    return _maybeOverride('''
@useResult
\$Res $methodName({
$parameters
});
''');
  }

  String _copyWithMethod(ParametersTemplate parametersTemplate) {
    if (cloneableProperties.isEmpty) return '';

    final prototype = _concreteCopyWithPrototype(
      properties: cloneableProperties,
      methodName: 'call',
    );

    final body = _copyWithMethodBody(
      parametersTemplate: parametersTemplate,
      returnType: '$clonedClassName$genericsParameter',
    );

    return '@pragma(\'vm:prefer-inline\') @override $prototype $body';
  }

  String _ignoreLints(String s,
          [List<String> lints = const ['cast_nullable_to_non_nullable']]) =>
      '''
// ignore: ${lints.join(', ')}
$s''';

  String _defaultValue({required bool isNullable}) {
    if (isNullable) {
      return 'freezed';
    } else {
      return 'null';
    }
  }

  String _copyWithMethodBody({
    String accessor = '_value',
    required ParametersTemplate parametersTemplate,
    required String returnType,
    String returnCast = '',
  }) {
    String thisPropertyFor({
      required Property propertyGetterForCopyWithParameter,
      required Parameter to,
    }) {
      var propertyName = to.name;
      if (canAccessRawCollection &&
          (to.isDartList || to.isDartMap || to.isDartSet) &&
          data.makeCollectionsImmutable) {
        propertyName = '_$propertyName';
      }

      var cast = '';
      if (propertyGetterForCopyWithParameter.type != to.type) cast = '!';

      return '$accessor.$propertyName$cast';
    }

    String parameterAssignmentFor(Parameter p) {
      var result = '${p.name} ';
      if (p.type != 'Object?' && p.type != 'Object' && p.type != null) {
        result += _ignoreLints('as ${p.type}');
      }

      return result;
    }

    String parameterToValue(Parameter p) {
      final propertyGetterForCopyWithParameter =
          readableProperties.firstWhere((element) => element.name == p.name);

      final condition =
          '${_defaultValue(isNullable: p.isNullable)} == ${p.name}';

      final thisProperty = thisPropertyFor(
        propertyGetterForCopyWithParameter: propertyGetterForCopyWithParameter,
        to: p,
      );

      return '$condition ? $thisProperty : ${parameterAssignmentFor(p)},';
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
          (p) => '${p.name}: ${parameterToValue(p)}',
        ),
      );

    return '''{
  return _then($returnType(
$constructorParameters
  )$returnCast);
}''';
  }

  String get _implClassName => '_${_abstractClassName}Impl';

  Iterable<String> _deepCopyMethods({required bool isConcrete}) sync* {
    final toGenerateProperties = parent == null
        ? deepCloneableProperties
        : deepCloneableProperties.where((property) {
            return !parent!.deepCloneableProperties
                .any((p) => p.name == property.name);
          });

    for (final cloneableProperty in toGenerateProperties) {
      final earlyReturn = cloneableProperty.nullable
          ? '''
  if (_value.${cloneableProperty.name} == null) {
    return null;
  }
'''
          : '';

      final nullabilitySuffix = cloneableProperty.nullable ? '!' : '';

      final returnType = cloneableProperty.nullable
          ? '${_clonerInterfaceFor(cloneableProperty)}?'
          : '${_clonerInterfaceFor(cloneableProperty)}';

      final cast = isConcrete ? '' : 'as \$Val';

      yield '''
@override
@pragma('vm:prefer-inline')
$returnType get ${cloneableProperty.name} {
  $earlyReturn
  return ${_clonerInterfaceFor(cloneableProperty)}(_value.${cloneableProperty.name}$nullabilitySuffix, (value) {
    return _then(_value.copyWith(${cloneableProperty.name}: value) $cast);
  });
}''';
    }
  }

  String _clonerInterfaceFor(DeepCloneableProperty cloneableProperty) {
    final name = interfaceNameFrom(cloneableProperty.typeName);
    return '$name${cloneableProperty.genericParameters.append('\$Res')}';
  }

  String _maybeOverride(String res) {
    return _hasSuperClass ? '@override $res' : res;
  }

  String get _abstractClassName => interfaceNameFrom(clonedClassName);
}
