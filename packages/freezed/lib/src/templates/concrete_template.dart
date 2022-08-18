import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:freezed/src/models.dart';
import 'package:freezed/src/templates/properties.dart';
import 'package:freezed/src/tools/type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'copy_with.dart';
import 'parameter_template.dart';
import 'prototypes.dart';

class Concrete {
  Concrete({
    required this.constructor,
    required this.data,
    required this.globalData,
    required this.commonProperties,
    required this.copyWith,
  });

  final ConstructorDetails constructor;
  final List<Property> commonProperties;
  final Data data;
  final GlobalData globalData;
  final CopyWith? copyWith;

  String get concreteName {
    return '_\$${constructor.redirectedName}';
  }

  String get nonPrivateConcreteName {
    return '\$${constructor.redirectedName}';
  }

  late final bool _hasUnionKeyProperty =
      (data.generateToJson || data.generateFromJson) &&
          data.constructors.length > 1 &&
          constructor.impliedProperties.every((e) => e.name != data.unionKey);

  @override
  String toString() {
    var jsonSerializable = '';
    if (!constructor.hasJsonSerializable) {
      if (data.generateFromJson || data.generateToJson) {
        final params = [
          if (data.generateToJson == false) 'createToJson: false',
          if (data.generateFromJson == false) 'createFactory: false',
          if (data.genericsParameterTemplate.typeParameters.isNotEmpty &&
              data.genericArgumentFactories == true)
            'genericArgumentFactories: true',
        ].join(',');

        jsonSerializable = '@JsonSerializable($params)';
      }
    }

    return '''
${copyWith?.interface ?? ''}

${copyWith?.concreteImpl(constructor.parameters) ?? ''}

/// @nodoc
$jsonSerializable
${constructor.decorators.join('\n')}
class $concreteName${data.genericsDefinitionTemplate} $_concreteSuper {
  $_concreteConstructor

  $_concreteFromJsonConstructor

$_properties

$_toStringMethod
$_debugFillProperties
$_operatorEqualMethod
$_hashCodeMethod
${copyWith?.concreteCopyWithGetter ?? ''}
$_when
$_whenOrNull
$_maybeWhen
$_map
$_mapOrNull
$_maybeMap
$_toJson
}


abstract class ${constructor.redirectedName}${data.genericsDefinitionTemplate} $_superKeyword ${data.name}${data.genericsParameterTemplate}$interfaces {
  $_isConst factory ${constructor.redirectedName}(${constructor.parameters.asExpandedDefinition}) = $concreteName${data.genericsParameterTemplate};
  $_privateConcreteConstructor

  $_redirectedFromJsonConstructor

$_abstractProperties
${copyWith?.abstractCopyWithGetter ?? ''}
}
''';
  }

  String get _concreteConstructor {
    final superConstructor = _superConstructor;

    final trailingStrings = <String>[
      if (constructor.asserts.isNotEmpty)
        ...constructor.asserts.map((a) => a.toString()),
      if (data.makeCollectionsImmutable)
        ...constructor.impliedProperties
            .where((e) => e.isDartList || e.isDartMap || e.isDartSet)
            .map((e) => '_${e.name} = ${e.name}'),
      if (_hasUnionKeyProperty)
        "\$type = \$type ?? '${constructor.unionValue}'",
      if (superConstructor.isNotEmpty) superConstructor,
    ];

    var parameters = constructor.parameters.mapParameters((p) {
      if (data.makeCollectionsImmutable &&
          (p.isDartList || p.isDartMap || p.isDartSet)) {
        return Parameter.fromParameter(p);
      }
      return LocalParameter.fromParameter(p);
    });

    if (_hasUnionKeyProperty) {
      final typeProperty = Parameter(
        type: 'String?',
        name: '\$type',
        isNullable: true,
        isFinal: true,
        isDartList: false,
        isDartSet: false,
        isDartMap: false,
        defaultValueSource: null,
        isRequired: false,
        decorators: [],
        doc: '',
        isPossiblyDartCollection: false,
        showDefaultValue: false,
        commonSupertype: null,
        commonSubtype: null,
        parameterElement: null,
      );

      parameters = ParametersTemplate(
        parameters.requiredPositionalParameters,
        optionalPositionalParameters: [
          ...parameters.optionalPositionalParameters,
          if (parameters.optionalPositionalParameters.isNotEmpty) typeProperty,
        ],
        namedParameters: [
          ...parameters.namedParameters,
          if (parameters.optionalPositionalParameters.isEmpty) typeProperty,
        ],
      );
    }

    var trailing = '';
    if (trailingStrings.isNotEmpty) {
      trailing = ': ${trailingStrings.join(',')}';
    }

    return '$_isConst $concreteName($parameters)$trailing;';
  }

  String get interfaces {
    if (constructor.withDecorators.isEmpty &&
        constructor.implementsDecorators.isEmpty) {
      return '';
    }

    final interfaces = [
      ...constructor.implementsDecorators,
      ...constructor.withDecorators,
    ].join(', ');

    final buffer = StringBuffer();

    if (interfaces.isNotEmpty) {
      if (data.shouldUseExtends) {
        buffer.write(' implements ');
      } else {
        buffer.write(', ');
      }
      buffer.write(interfaces);
    }

    return buffer.toString();
  }

  String get _superConstructor {
    if (!data.shouldUseExtends) return '';
    return 'super._()';
  }

  String get _privateConcreteConstructor {
    if (!data.shouldUseExtends) return '';

    return '$_isConst ${constructor.redirectedName}._(): super._();';
  }

  String get _superKeyword {
    return data.shouldUseExtends ? 'extends' : 'implements';
  }

  String get _concreteSuper {
    final mixins = [
      if (globalData.hasDiagnostics && data.generateToString)
        'DiagnosticableTreeMixin',
      ...constructor.withDecorators,
    ];
    final mixinsStr = mixins.isEmpty ? '' : ' with ${mixins.join(',')}';

    if (data.shouldUseExtends) {
      return 'extends ${constructor.redirectedName}${data.genericsParameterTemplate} $mixinsStr';
    } else {
      return '$mixinsStr implements ${constructor.redirectedName}${data.genericsParameterTemplate}';
    }
  }

  String get _properties {
    final classProperties = constructor.impliedProperties.expand((p) {
      final annotatedProperty = p.copyWith(
        decorators: [
          '@override',
          if (p.defaultValueSource != null && !p.hasJsonKey) '@JsonKey()',
          ...p.decorators,
        ],
      );

      if (data.makeCollectionsImmutable) {
        String? viewType;

        if (p.isDartList) {
          viewType = 'EqualUnmodifiableListView';
        } else if (p.isDartMap) {
          viewType = 'EqualUnmodifiableMapView';
        } else if (p.isDartSet) {
          viewType = 'EqualUnmodifiableSetView';
        }

        if (viewType != null) {
          return [
            p.copyWith(name: '_${p.name}', decorators: const []),
            if (p.isNullable) annotatedProperty.asGetter(''' {
  final value = _${p.name};
  if (value == null) return null;
  // ignore: implicit_dynamic_type
  return $viewType(value);
}
''') else annotatedProperty.asGetter(''' {
  // ignore: implicit_dynamic_type
  return $viewType(_${p.name});
}
'''),
          ];
        }
      }

      return [annotatedProperty];
    });

    if (_hasUnionKeyProperty) {
      return '''
${classProperties.join('\n')}

@JsonKey(name: '${data.unionKey}')
final String \$type;
''';
    }

    return classProperties.join('\n');
  }

  String get _isConst {
    return constructor.isConst ? 'const' : '';
  }

  String get _fromJsonArgs => fromJsonArguments(
      data.genericsParameterTemplate, data.genericArgumentFactories);

  String get _fromJsonParams => fromJsonParameters(
      data.genericsParameterTemplate, data.genericArgumentFactories);

  String get _redirectedFromJsonConstructor {
    if (!data.generateFromJson) return '';
    return 'factory ${constructor.redirectedName}.fromJson(Map<String, dynamic> json$_fromJsonParams)'
        ' = $concreteName${data.genericsParameterTemplate}.fromJson;';
  }

  String get _concreteFromJsonConstructor {
    if (!data.generateFromJson) return '';
    return 'factory $concreteName.fromJson(Map<String, dynamic> json$_fromJsonParams)'
        ' => _\$${nonPrivateConcreteName}FromJson(json$_fromJsonArgs);';
  }

  String get _toJsonParams => toJsonParameters(
      data.genericsParameterTemplate, data.genericArgumentFactories);

  String get _toJsonArgs => toJsonArguments(
      data.genericsParameterTemplate, data.genericArgumentFactories);

  String get _toJson {
    if (!data.generateToJson) return '';

    return '''
@override
Map<String, dynamic> toJson($_toJsonParams) {
  return _\$${nonPrivateConcreteName}ToJson${data.genericsParameterTemplate}(this, $_toJsonArgs);
}''';
  }

  String get _debugFillProperties {
    if (!globalData.hasDiagnostics || !data.generateToString) return '';

    final diagnostics = [
      for (final e in constructor.impliedProperties)
        "..add(DiagnosticsProperty('${e.name}', ${e.name}))",
    ].join();

    return '''
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  super.debugFillProperties(properties);
  properties
    ..add(DiagnosticsProperty('type', '${constructor.escapedName}'))
    $diagnostics;
}
''';
  }

  String get _maybeMap {
    if (!data.map.maybeMap) return '';

    return '''
@override
${maybeMapPrototype(data.constructors, data.genericsParameterTemplate)} {
  if (${constructor.callbackName} != null) {
    return ${constructor.callbackName}(this);
  }
  return orElse();
}''';
  }

  String get _map {
    if (!data.map.map) return '';

    return '''
@override
${mapPrototype(data.constructors, data.genericsParameterTemplate)} {
  return ${constructor.callbackName}(this);
}''';
  }

  String get _mapOrNull {
    if (!data.map.mapOrNull) return '';

    return '''
@override
${mapOrNullPrototype(data.constructors, data.genericsParameterTemplate)} {
  return ${constructor.callbackName}?.call(this);
}''';
  }

  String get _maybeWhen {
    if (!data.when.maybeWhen) return '';

    var callbackParameters = constructor.impliedProperties.map((e) {
      if (data.constructors.any((c) => c.callbackName == e.name)) {
        return 'this.${e.name}';
      }
      return e.name;
    }).join(',');

    return '''
@override
${maybeWhenPrototype(data.constructors)} {
  if (${constructor.callbackName} != null) {
    return ${constructor.callbackName}($callbackParameters);
  }
  return orElse();
}''';
  }

  String get _when {
    if (!data.when.when) return '';

    var callbackParameters = constructor.impliedProperties.map((e) {
      if (data.constructors.any((c) => c.callbackName == e.name)) {
        return 'this.${e.name}';
      }
      return e.name;
    }).join(',');

    return '''
@override
${whenPrototype(data.constructors)} {
  return ${constructor.callbackName}($callbackParameters);
}''';
  }

  String get _whenOrNull {
    if (!data.when.whenOrNull) return '';

    var callbackParameters = constructor.impliedProperties.map((e) {
      if (data.constructors.any((c) => c.callbackName == e.name)) {
        return 'this.${e.name}';
      }
      return e.name;
    }).join(',');

    return '''
@override
${whenOrNullPrototype(data.constructors)} {
  return ${constructor.callbackName}?.call($callbackParameters);
}''';
  }

  String get _abstractProperties {
    return constructor.impliedProperties.expand((p) {
      return [
        if (commonProperties.any((element) => element.name == p.name))
          '@override ${p.abstractGetter}'
        else
          '${p.abstractGetter}',
        if (!p.isFinal) p.abstractSetter,
      ];
    }).join();
  }

  String get _toStringMethod {
    if (!data.generateToString) return '';

    final parameters = globalData.hasDiagnostics
        ? '{ DiagnosticLevel minLevel = DiagnosticLevel.info }'
        : '';

    final properties = [
      for (final p in constructor.impliedProperties) '${p.name}: \$${p.name}',
    ];

    return '''
@override
String toString($parameters) {
  return '${constructor.escapedName}(${properties.join(', ')})';
}
''';
  }

  String get _operatorEqualMethod {
    if (!data.generateEqual) return '';

    final comparisons = [
      'other.runtimeType == runtimeType',
      'other is $concreteName${data.genericsParameterTemplate}',
      ...constructor.impliedProperties.map((p) {
        var name = p.name;
        if (p.isPossiblyDartCollection) {
          if (data.makeCollectionsImmutable &&
              (p.isDartList || p.isDartMap || p.isDartSet)) {
            name = '_$name';
          }
        }
        final target = p.name == 'other' ? 'this.' : '';

        if (p.isPossiblyDartCollection) {
          // no need to check `identical` as `DeepCollectionEquality` already does it
          return 'const DeepCollectionEquality().equals(other.$name, $target$name)';
        }
        return '(identical(other.${p.name}, $target$name) || other.$name == $target$name)';
      }),
    ];

    return '''
@override
bool operator ==(dynamic other) {
  return identical(this, other) || (${comparisons.join('&&')});
}
''';
  }

  String get _hashCodeMethod {
    if (!data.generateEqual) return '';

    final jsonKey = data.generateFromJson || data.generateToJson
        ? '@JsonKey(ignore: true)'
        : '';

    final hashedProperties = [
      'runtimeType',
      for (final property in constructor.impliedProperties)
        if (property.isPossiblyDartCollection)
          if (data.makeCollectionsImmutable &&
              (property.isDartList || property.isDartMap || property.isDartSet))
            'const DeepCollectionEquality().hash(_${property.name})'
          else
            'const DeepCollectionEquality().hash(${property.name})'
        else
          property.name,
    ];

    if (hashedProperties.length == 1) {
      return '''
$jsonKey
@override
int get hashCode => ${hashedProperties.first}.hashCode;
''';
    }
    if (hashedProperties.length >= 20) {
      return '''
$jsonKey
@override
int get hashCode => Object.hashAll([${hashedProperties.join(',')}]);
''';
    }

    return '''
$jsonKey
@override
int get hashCode => Object.hash(${hashedProperties.join(',')});
''';
  }
}

extension DefaultValue on ParameterElement {
  /// Returns the sources of the default value associated with a `@Default`,
  /// or `null` if no `@Default` are specified.
  String? get defaultValue {
    const matcher = TypeChecker.fromRuntime(Default);

    for (final meta in metadata) {
      final obj = meta.computeConstantValue()!;
      if (matcher.isExactlyType(obj.type!)) {
        final source = meta.toSource();
        final res = source.substring('@Default('.length, source.length - 1);

        var needsConstModifier = !res.trimLeft().startsWith('const') &&
            (res.contains('(') || res.contains('[') || res.contains('{'));

        if (needsConstModifier) {
          return 'const $res';
        } else {
          return res;
        }
      }
    }
    return null;
  }

  bool get hasJsonKey {
    return const TypeChecker.fromRuntime(JsonKey).hasAnnotationOf(this);
  }
}

String? parseTypeSource(VariableElement element) {
  String? type = element.type.getDisplayString(withNullability: true);

  if (type.contains('dynamic') && element.nameOffset > 0) {
    final source =
        element.source!.contents.data.substring(0, element.nameOffset);
    final eleType = element.type;
    if (eleType is DynamicType) {
      final match = RegExp(r'(\w+\??)\s+$').firstMatch(source);
      return match?.group(1);
    } else if (eleType is InterfaceType) {
      final match = RegExp(r'(\w+<.+?>\??)\s+$').firstMatch(source);
      return match?.group(1) ?? type;
    }
  }

  return resolveFullTypeStringFrom(
    element.library!,
    element.type,
    withNullability: true,
  );
}
