import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:freezed/src/freezed_generator.dart';
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
  final Class data;
  final Library globalData;
  final CopyWith? copyWith;

  late final bool _hasUnionKeyProperty =
      (data.options.toJson || data.options.fromJson) &&
          data.constructors.length > 1 &&
          constructor.impliedProperties
              .every((e) => e.name != data.options.annotation.unionKey);

  @override
  String toString() {
    final jsonSerializable = _jsonSerializable();

    return '''
${copyWith?.interface ?? ''}
${copyWith?.concreteImpl(constructor.parameters) ?? ''}

/// @nodoc
$jsonSerializable
${constructor.decorators.join('\n')}
class ${constructor.redirectedName}${data.genericsDefinitionTemplate} $_concreteSuper {
  $_concreteConstructor
  $_concreteFromJsonConstructor

$_properties

${copyWith?.concreteCopyWithGetter ?? ''}
$_toJson
$_debugFillProperties
$_operatorEqualMethod
$_hashCodeMethod
$_toStringMethod
}
''';
  }

  String _jsonSerializable() {
    var jsonSerializable = '';
    if (!constructor.hasJsonSerializable) {
      if (data.options.fromJson || data.options.toJson) {
        final params = [
          if (data.options.toJson == false) 'createToJson: false',
          if (data.options.fromJson == false) 'createFactory: false',
          if (data.genericsParameterTemplate.typeParameters.isNotEmpty &&
              data.options.genericArgumentFactories == true)
            'genericArgumentFactories: true',
        ].join(',');

        jsonSerializable = '@JsonSerializable($params)';
      }
    }
    return jsonSerializable;
  }

  String get _concreteConstructor {
    final superConstructor = _superConstructor;

    final trailingStrings = <String>[
      if (constructor.asserts.isNotEmpty)
        ...constructor.asserts.map((a) => a.toString()),
      if (data.options.asUnmodifiableCollections)
        ...constructor.impliedProperties
            .where((e) => e.isDartList || e.isDartMap || e.isDartSet)
            .map((e) => '_${e.name} = ${e.name}'),
      if (_hasUnionKeyProperty)
        "\$type = \$type ?? '${constructor.unionValue}'",
      if (superConstructor.isNotEmpty) superConstructor,
    ];

    var parameters = constructor.parameters.mapParameters((p) {
      if (data.options.asUnmodifiableCollections &&
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

    return '$_isConst ${constructor.redirectedName}($parameters)$trailing;';
  }

  String get _superConstructor {
    if (!data.shouldUseExtends) return '';
    return 'super._()';
  }

  String get _concreteSuper {
    final interfaces = <String, List<String>>{
      if (data.shouldUseExtends)
        'extends': ['${data.name}${data.genericsParameterTemplate}'],
      'with': [
        if (globalData.hasDiagnostics && data.options.asString)
          'DiagnosticableTreeMixin',
        ...constructor.withDecorators.map((e) => e.type),
      ],
      'implements': [
        if (!data.shouldUseExtends)
          '${data.name}${data.genericsParameterTemplate}',
        ...constructor.implementsDecorators.map((e) => e.type),
      ],
    };

    return interfaces.entries
        .where((e) => e.value.isNotEmpty)
        .map((e) => '${e.key} ${e.value.join(', ')}')
        .join(' ');
  }

  String get _properties {
    final classProperties = constructor.impliedProperties.expand((p) {
      final annotatedProperty = p.copyWith(
        decorators: [
          if (commonProperties.any((element) => element.name == p.name))
            '@override',
          if (p.defaultValueSource != null && !p.hasJsonKey) '@JsonKey()',
          ...p.decorators,
        ],
      );

      if (data.options.asUnmodifiableCollections) {
        String? viewType;

        if (p.isDartList) {
          viewType = 'EqualUnmodifiableListView';
        } else if (p.isDartMap) {
          viewType = 'EqualUnmodifiableMapView';
        } else if (p.isDartSet) {
          viewType = 'EqualUnmodifiableSetView';
        }

        if (viewType != null) {
          // If the collection is already unmodifiable, we don't want to wrap
          // it in an unmodifiable view again.
          final isAlreadyUnmodifiableCheck =
              'if (_${p.name} is $viewType) return _${p.name};';

          return [
            p.copyWith(name: '_${p.name}', decorators: const []),
            if (p.isNullable) annotatedProperty.asGetter(''' {
  final value = _${p.name};
  if (value == null) return null;
  $isAlreadyUnmodifiableCheck
  // ignore: implicit_dynamic_type
  return $viewType(value);
}
''') else annotatedProperty.asGetter(''' {
  $isAlreadyUnmodifiableCheck
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

@JsonKey(name: '${data.options.annotation.unionKey}')
final String \$type;
''';
    }

    return classProperties.join('\n');
  }

  String get _isConst {
    return constructor.isConst ? 'const' : '';
  }

  String get _fromJsonArgs => fromJsonArguments(
        data.genericsParameterTemplate,
        data.options.genericArgumentFactories,
      );

  String get _fromJsonParams => fromJsonParameters(
      data.genericsParameterTemplate, data.options.genericArgumentFactories);

  String get _concreteFromJsonConstructor {
    if (!data.options.fromJson) return '';
    return 'factory ${constructor.redirectedName}.fromJson(Map<String, dynamic> json$_fromJsonParams)'
        ' => _\$${constructor.redirectedName.public}FromJson(json$_fromJsonArgs);';
  }

  String get _toJsonParams => toJsonParameters(
      data.genericsParameterTemplate, data.options.genericArgumentFactories);

  String get _toJsonArgs => toJsonArguments(
      data.genericsParameterTemplate, data.options.genericArgumentFactories);

  String get _toJson {
    if (!data.options.toJson) return '';

    return '''
@override
Map<String, dynamic> toJson($_toJsonParams) {
  return _\$${constructor.redirectedName.public}ToJson${data.genericsParameterTemplate}(this, $_toJsonArgs);
}''';
  }

  String get _debugFillProperties {
    if (!globalData.hasDiagnostics || !data.options.asString) return '';

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

  String get _toStringMethod {
    if (!data.options.asString) return '';

    final parameters = globalData.hasDiagnostics
        ? '{ DiagnosticLevel minLevel = DiagnosticLevel.info }'
        : '';

    final properties = [
      for (final p in constructor.impliedProperties)
        '${p.name.replaceAll(r'$', r'\$')}: ${wrapClassField(p.name)}',
    ];

    return '''
@override
String toString($parameters) {
  return '${constructor.escapedName}(${properties.join(', ')})';
}
''';
  }

  String get _operatorEqualMethod {
    if (!data.options.equal) return '';

    final comparisons = [
      'other.runtimeType == runtimeType',
      'other is ${constructor.redirectedName}${data.genericsParameterTemplate}',
      ...constructor.impliedProperties.map((p) {
        var name = p.name;
        if (p.isPossiblyDartCollection) {
          if (data.options.asUnmodifiableCollections &&
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
bool operator ==(Object other) {
  return identical(this, other) || (${comparisons.join('&&')});
}
''';
  }

  String get _hashCodeMethod {
    if (!data.options.equal) return '';

    final jsonKey = data.options.fromJson || data.options.toJson
        ? '@JsonKey(includeFromJson: false, includeToJson: false)'
        : '';

    final hashedProperties = [
      'runtimeType',
      for (final property in constructor.impliedProperties)
        if (property.isPossiblyDartCollection)
          if (data.options.asUnmodifiableCollections &&
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

        var needsConstModifier = !declaration.type.isDartCoreString &&
            !res.trimLeft().startsWith('const') &&
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
  String? type = element.type.getDisplayString();

  if ((type.contains('dynamic') || type.contains('InvalidType')) &&
      element.nameOffset > 0) {
    final source =
        element.source!.contents.data.substring(0, element.nameOffset);
    final eleType = element.type;
    if (eleType.isDynamic2) {
      final match = RegExp(r'([$\w]+\??)\s+$').firstMatch(source);
      return match?.group(1);
    } else if (eleType is InterfaceType) {
      final match = RegExp(r'([$\w]+<.+?>\??)\s+$').firstMatch(source);
      return match?.group(1) ?? type;
    }
  }

  return resolveFullTypeStringFrom(
    element.library!,
    element.type,
  );
}
