import 'package:freezed/src/templates/parameter_template.dart';
import 'package:freezed/src/templates/properties.dart';
import 'package:freezed/src/tools/type.dart';

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
    required this.parents,
    this.parent,
  });

  static String interfaceNameFrom(String name) {
    if (name.startsWith('_')) {
      return '_\$${name.substring(1)}CopyWith';
    }
    return '\$${name}CopyWith';
  }

  String _copyWithDocs(String name) {
    return '''
/// Create a copy of $name
/// with the given fields replaced by the non-null parameter values.''';
  }

  final String clonedClassName;
  final GenericsDefinitionTemplate genericsDefinition;
  final GenericsParameterTemplate genericsParameter;
  final List<Property> cloneableProperties;
  final List<Property> readableProperties;
  final List<DeepCloneableProperty> deepCloneableProperties;
  final CopyWith? parent;
  final Set<Class> parents;
  final Class data;

  /// When collections are wrapped in an UnmodifiableView, this bool determines
  /// if the raw collection can be accessed instead.
  bool get _canAccessRawCollection => parent != null;

  String get interface => _deepCopyInterface(appendGenericToFactory: false);

  String get commonInterface =>
      _deepCopyInterface(appendGenericToFactory: true);

  String _deepCopyInterface({required bool appendGenericToFactory}) {
    var implements = [
      if (parent != null)
        '${parent!._abstractClassName}${genericsParameter.append('\$Res')}',
      for (final parent in parents)
        '${interfaceNameFrom(parent.name)}${genericsParameter.append('\$Res')}',
    ].join(', ');
    if (implements.isNotEmpty) implements = 'implements $implements';

    var body = '';
    var leading = '';
    if (cloneableProperties.isNotEmpty) {
      leading = 'abstract mixin ';
      body =
          '''
  factory $_abstractClassName($clonedClassName$genericsParameter value, \$Res Function($clonedClassName$genericsParameter) _then) = $_implClassName;
${_copyWithPrototype('call')}

${_abstractDeepCopyMethods().join()}
''';
    } else {
      // Constructor for deep-copy, for the sake of cross-library deep-copy support
      body =
          '$_abstractClassName($clonedClassName$genericsParameter _, \$Res Function($clonedClassName$genericsParameter) __);';
    }

    return '''
/// @nodoc
${leading}class $_abstractClassName${genericsDefinition.append('\$Res')} $implements {
$body
}''';
  }

  String copyWithGetter({required bool needsCast}) {
    if (cloneableProperties.isEmpty) return '';

    final cast = needsCast ? ' as $clonedClassName$genericsParameter' : '';
    return _maybeOverride(
      doc:
          '''
${_copyWithDocs(data.name)}
''',
      '''
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$_abstractClassName${genericsParameter.append('$clonedClassName$genericsParameter')} get copyWith => $_implClassName${genericsParameter.append('$clonedClassName$genericsParameter')}(this$cast, _\$identity);
''',
    );
  }

  String get commonConcreteImpl {
    if (cloneableProperties.isEmpty) return '';
    var copyWith = '';

    if (cloneableProperties.isNotEmpty || data.copyWithTarget != null) {
      final prototype = _concreteCopyWithPrototype(
        properties: cloneableProperties,
        methodName: 'call',
      );

      String body;
      if (data.copyWithTarget case final target?) {
        body = _copyWithMethodBody(
          parametersTemplate: target.parameters,
          returnType: switch (target.name) {
            final name? => '${data.name}.$name',
            null => data.name,
          },
        );
      } else {
        body = _copyWithMethodBody(
          parametersTemplate: ParametersTemplate(
            const [],
            namedParameters: cloneableProperties.map((e) {
              return Parameter(
                decorators: e.decorators,
                name: e.name,
                isFinal: false,
                showDefaultValue: false,
                isRequired: false,
                defaultValueSource: '',
                type: e.type,
                typeDisplayString: e.typeDisplayString,
                doc: e.doc,
                parameterElement: null,
              );
            }).toList(),
          ),
          returnType: '_self.copyWith',
        );
      }

      copyWith = '@pragma(\'vm:prefer-inline\') @override $prototype $body';
    }

    return '''
/// @nodoc
class $_implClassName${genericsDefinition.append('\$Res')}
    implements $_abstractClassName${genericsParameter.append('\$Res')} {
  $_implClassName(this._self, this._then);

  final $clonedClassName$genericsParameter _self;
  final \$Res Function($clonedClassName$genericsParameter) _then;

${_copyWithDocs(data.name)}
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
class $_implClassName${genericsDefinition.append('\$Res')}
    implements $_abstractClassName${genericsParameter.append('\$Res')} {
  $_implClassName(this._self, this._then);

  final $clonedClassName$genericsParameter _self;
  final \$Res Function($clonedClassName$genericsParameter) _then;

${_copyWithMethod(parametersTemplate)}

${_deepCopyMethods(isConcrete: true).join()}
}''';
  }

  Iterable<String> _abstractDeepCopyMethods() sync* {
    for (final deepCloneableProperty in deepCloneableProperties) {
      var leading = '';
      if (parent != null &&
          parent!.deepCloneableProperties.any(
            (c) => c.name == deepCloneableProperty.name,
          )) {
        leading = '@override ';
      }

      final nullabilitySuffix = deepCloneableProperty.nullable ? '?' : '';

      yield '$leading${_clonerInterfaceFor(deepCloneableProperty)}$nullabilitySuffix get ${deepCloneableProperty.name};';
    }
  }

  String _copyWithPrototype(String methodName) {
    if (cloneableProperties.isEmpty) return '';

    return _copyWithPrototypeFor(
      methodName: methodName,
      properties: cloneableProperties,
    );
  }

  String _concreteCopyWithPrototype({
    required List<Property> properties,
    required String methodName,
  }) {
    final parameters = properties.map((p) {
      return 'Object? ${p.name} = ${_defaultValue(isNullable: p.type.isNullable)},';
    }).join();

    return '\$Res $methodName({$parameters})';
  }

  String _copyWithPrototypeFor({
    required String methodName,
    required List<Property> properties,
  }) {
    final parameters = properties
        .map((p) {
          return '${p.decorators.join()} ${p.typeDisplayString} ${p.name}';
        })
        .join(',');

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

    return _maybeOverride(
      doc:
          '''
${_copyWithDocs(data.name)}
''',
      '@pragma(\'vm:prefer-inline\') $prototype $body',
    );
  }

  String _ignoreLints(
    String s, [
    List<String> lints = const ['cast_nullable_to_non_nullable'],
  ]) =>
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
    String accessor = '_self',
    required ParametersTemplate parametersTemplate,
    required String returnType,
    String returnCast = '',
  }) {
    String thisPropertyFor({
      required Property propertyGetterForCopyWithParameter,
      required Parameter to,
    }) {
      var propertyName = to.name;
      if (_canAccessRawCollection &&
          (to.type.isDartCoreList ||
              to.type.isDartCoreMap ||
              to.type.isDartCoreSet) &&
          data.options.asUnmodifiableCollections) {
        propertyName = '_$propertyName';
      }

      var cast = '';
      if (propertyGetterForCopyWithParameter.type != to.type) cast = '!';

      return '$accessor.$propertyName$cast';
    }

    String parameterAssignmentFor(Parameter p) {
      var result = '${p.name} ';
      if (!p.type.isDartCoreObject) {
        result += _ignoreLints('as ${p.typeDisplayString}');
      }

      return result;
    }

    String parameterToValue(Parameter p) {
      final propertyGetterForCopyWithParameter = <Property>[]
          .followedBy(readableProperties)
          // Read this.p before cloneable properties, as they might have a different nullability
          .followedBy(cloneableProperties)
          .firstWhere((element) => element.name == p.name);

      final condition =
          '${_defaultValue(isNullable: p.type.isNullable)} == ${p.name}';

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
    for (final cloneableProperty in deepCloneableProperties) {
      final earlyReturn = cloneableProperty.nullable
          ? '''
  if (_self.${cloneableProperty.name} == null) {
    return null;
  }
'''
          : '';

      final nullabilitySuffix = cloneableProperty.nullable ? '!' : '';

      final returnType = cloneableProperty.nullable
          ? '${_clonerInterfaceFor(cloneableProperty)}?'
          : '${_clonerInterfaceFor(cloneableProperty)}';

      yield '''
${_copyWithDocs(data.name)}
@override
@pragma('vm:prefer-inline')
$returnType get ${cloneableProperty.name} {
  $earlyReturn
  return ${_clonerInterfaceFor(cloneableProperty)}(_self.${cloneableProperty.name}$nullabilitySuffix, (value) {
    return _then(_self.copyWith(${cloneableProperty.name}: value));
  });
}''';
    }
  }

  String _clonerInterfaceFor(DeepCloneableProperty cloneableProperty) {
    final name = interfaceNameFrom(cloneableProperty.typeName);
    return '$name${cloneableProperty.genericParameters.append('\$Res')}';
  }

  String _maybeOverride(String res, {String doc = ''}) {
    return parent != null && parent!.cloneableProperties.isNotEmpty
        ? '$doc@override $res'
        : '$doc$res';
  }

  String get _abstractClassName => interfaceNameFrom(clonedClassName);
}
