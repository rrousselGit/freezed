import 'package:analyzer/dart/element/element.dart';
import 'package:freezed/src/models.dart';
import 'package:freezed/src/templates/properties.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

import 'copy_with.dart';
import 'parameter_template.dart';
import 'prototypes.dart';

class Concrete {
  Concrete({
    @required this.constructor,
    @required this.genericsDefinition,
    @required this.genericsParameter,
    @required this.allConstructors,
    @required this.hasDiagnosticable,
    @required this.shouldGenerateJson,
    @required this.commonProperties,
    @required this.lateGetters,
    @required this.name,
    @required this.unionKey,
    @required this.copyWith,
    @required this.shouldUseExtends,
  });

  final ConstructorDetails constructor;
  final List<ConstructorDetails> allConstructors;
  final GenericsDefinitionTemplate genericsDefinition;
  final GenericsParameterTemplate genericsParameter;
  final List<Property> commonProperties;
  final bool hasDiagnosticable;
  final bool shouldGenerateJson;
  final List<LateGetter> lateGetters;
  final String name;
  final String unionKey;
  final CopyWith copyWith;
  final bool shouldUseExtends;

  String get concreteName {
    return '_\$${constructor.redirectedName}';
  }

  @override
  String toString() {
    final asserts = _asserts;
    final superConstructor = _superConstructor;

    var trailing = '';
    if (asserts.isNotEmpty || superConstructor.isNotEmpty) {
      trailing = ': ${[
        if (asserts.isNotEmpty) asserts,
        if (superConstructor.isNotEmpty) superConstructor
      ].join(',')}';
    }

    return '''
${copyWith.interface}

${copyWith.concreteImpl(constructor.parameters)}

${shouldGenerateJson && !constructor.hasJsonSerializable ? '@JsonSerializable()' : ''}
${constructor.decorators.join('\n')}
/// @nodoc
class $concreteName$genericsDefinition $_concreteSuper {
  $_isConst $concreteName(${constructor.parameters.asThis()})$trailing;

  $_concreteFromJsonConstructor

$_properties

${lateGetters.join()}

$_toStringMethod
$_debugFillProperties
$_operatorEqualMethod
$_hashCodeMethod
${copyWith.concreteCopyWithGetter}
$_when
$_maybeWhen
$_map
$_maybeMap
$_toJson
}


abstract class ${constructor.redirectedName}$genericsDefinition $_superKeyword $name$genericsParameter$interfaces {
  $_privateConcreteConstructor
  $_isConst factory ${constructor.redirectedName}(${constructor.parameters.asExpandedDefinition}) = $concreteName$genericsParameter;

  $_redirectedFromJsonConstructor

$_abstractProperties
${copyWith.abstractCopyWithGetter}
}
''';
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
      if (shouldUseExtends) {
        buffer.write(' implements ');
      } else {
        buffer.write(', ');
      }
      buffer.write(interfaces);
    }

    return buffer.toString();
  }

  String get _superConstructor {
    if (!shouldUseExtends) return '';
    return 'super._()';
  }

  String get _privateConcreteConstructor {
    if (!shouldUseExtends) return '';

    return '$_isConst ${constructor.redirectedName}._(): super._();';
  }

  String get _superKeyword {
    return shouldUseExtends ? 'extends' : 'implements';
  }

  String get _concreteSuper {
    final mixins = [
      if (hasDiagnosticable) 'DiagnosticableTreeMixin',
      ...constructor.withDecorators,
    ];
    final mixinsStr = mixins.isEmpty ? '' : ' with ${mixins.join(',')}';

    if (shouldUseExtends) {
      return 'extends ${constructor.redirectedName}$genericsParameter $mixinsStr';
    } else {
      return '$mixinsStr implements ${constructor.redirectedName}$genericsParameter';
    }
  }

  String get _properties {
    return constructor.impliedProperties.map((p) {
      var res = '@override $p';
      if (p.defaultValueSource != null && !p.hasJsonKey) {
        res = '@JsonKey(defaultValue: ${p.defaultValueSource}) $res';
      }
      return res;
    }).join();
  }

  String get _asserts {
    return [
      ...constructor.impliedProperties
          .where((p) => !p.nullable)
          .map((e) => 'assert(${e.name} != null)'),
      ...constructor.asserts,
    ].join(',');
  }

  String get _isConst {
    return constructor.isConst ? 'const' : '';
  }

  String get _redirectedFromJsonConstructor {
    if (!shouldGenerateJson) return '';
    return 'factory ${constructor.redirectedName}.fromJson(Map<String, dynamic> json) = $concreteName$genericsParameter.fromJson;';
  }

  String get _concreteFromJsonConstructor {
    if (!shouldGenerateJson) return '';
    return 'factory $concreteName.fromJson(Map<String, dynamic> json) => _\$${concreteName}FromJson(json);';
  }

  String get _toJson {
    if (!shouldGenerateJson) return '';

    final addRuntimeType = allConstructors.length > 1
        ? "..['$unionKey'] = '${constructor.isDefault ? 'default' : constructor.name}'"
        : '';

    return '''
@override
Map<String, dynamic> toJson() {
  return _\$${concreteName}ToJson(this)$addRuntimeType;
}''';
  }

  String get _debugFillProperties {
    if (!hasDiagnosticable) return '';

    final diagnostics = [
      ...constructor.impliedProperties
          .map((e) => "..add(DiagnosticsProperty('${e.name}', ${e.name}))"),
      ...lateGetters
          .map((e) => "..add(DiagnosticsProperty('${e.name}', ${e.name}))"),
    ].join();

    return '''
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  super.debugFillProperties(properties);
  properties
    ..add(DiagnosticsProperty('type', '${constructor.fullName}'))
    $diagnostics;
}
''';
  }

  String get _maybeMap {
    if (!allConstructors.shouldGenerateUnions) return '';

    return '''
@override
${maybeMapPrototype(allConstructors, genericsParameter)} {
  assert(orElse != null);
  if (${constructor.callbackName} != null) {
    return ${constructor.callbackName}(this);
  }
  return orElse();
}''';
  }

  String get _map {
    if (!allConstructors.shouldGenerateUnions) return '';

    final asserts = [
      for (final ctor in allConstructors)
        'assert(${ctor.callbackName} != null);'
    ];

    return '''
@override
${mapPrototype(allConstructors, genericsParameter)} {
  ${asserts.join()}
  return ${constructor.callbackName}(this);
}''';
  }

  String get _maybeWhen {
    if (!allConstructors.shouldGenerateUnions) return '';

    var callbackParameters = constructor.impliedProperties.map((e) {
      if (allConstructors.any((c) => c.callbackName == e.name)) {
        return 'this.${e.name}';
      }
      return e.name;
    }).join(',');

    return '''
@override
${maybeWhenPrototype(allConstructors)} {
  assert(orElse != null);
  if (${constructor.callbackName} != null) {
    return ${constructor.callbackName}($callbackParameters);
  }
  return orElse();
}''';
  }

  String get _when {
    if (!allConstructors.shouldGenerateUnions) return '';

    final asserts = [
      for (final ctor in allConstructors)
        'assert(${ctor.callbackName} != null);'
    ];

    var callbackParameters = constructor.impliedProperties.map((e) {
      if (allConstructors.any((c) => c.callbackName == e.name)) {
        return 'this.${e.name}';
      }
      return e.name;
    }).join(',');

    return '''
@override
${whenPrototype(allConstructors)} {
  ${asserts.join()}
  return ${constructor.callbackName}($callbackParameters);
}''';
  }

  String get _abstractProperties {
    return constructor.impliedProperties.map((p) {
      if (commonProperties.any((element) => element.name == p.name)) {
        return '@override ${p.getter}';
      } else {
        return '${p.getter}';
      }
    }).join();
  }

  String get _toStringMethod {
    if (!constructor.canOverrideToString) return '';

    final parameters = hasDiagnosticable
        ? '{ DiagnosticLevel minLevel = DiagnosticLevel.info }'
        : '';

    final properties = [
      ...constructor.impliedProperties.map((p) {
        return '${p.name}: \$${p.name}';
      }),
      ...lateGetters.map((p) {
        return '${p.name}: \$${p.name}';
      })
    ];

    return '''
@override
String toString($parameters) {
  return '${constructor.fullName}(${properties.join(', ')})';
}
''';
  }

  String get _operatorEqualMethod {
    final properties = constructor.impliedProperties.map((p) {
      final name = p.name == 'other' ? 'this.other' : p.name;
      return '(identical(other.${p.name}, $name) || const DeepCollectionEquality().equals(other.${p.name}, $name))';
    });

    return '''
@override
bool operator ==(dynamic other) {
  return identical(this, other) || (other is ${[
      '${constructor.redirectedName}$genericsParameter',
      ...properties
    ].join('&&')});
}
''';
  }

  String get _hashCodeMethod {
    var hashCodeImpl = constructor.impliedProperties.map((p) {
      return '^ const DeepCollectionEquality().hash(${p.name})';
    }).join();

    return '''
@override
int get hashCode => runtimeType.hashCode $hashCodeImpl;
''';
  }
}

extension on Element {
  bool get hasNullable {
    return TypeChecker.fromRuntime(nullable.runtimeType)
        .hasAnnotationOf(this, throwOnUnresolved: false);
  }
}

extension IsNullable on ParameterElement {
  bool get isNullable {
    return hasNullable || (_isOptional && defaultValue == null);
  }

  bool get _isOptional {
    return isOptionalPositional || (isNamed && !hasRequired);
  }
}

extension DefaultValue on ParameterElement {
  /// Returns the sources of the default value associated with a `@Default`,
  /// or `null` if no `@Default` are specified.
  String get defaultValue {
    const matcher = TypeChecker.fromRuntime(Default);

    for (final meta in metadata) {
      final obj = meta.computeConstantValue();
      if (matcher.isExactlyType(obj.type)) {
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

String parseTypeSource(VariableElement element) {
  var type = element.type?.getDisplayString(withNullability: false);

  if ((type == null || type.contains('dynamic')) && element.nameOffset > 0) {
    final source =
        element.source.contents.data.substring(0, element.nameOffset);
    if (element.type?.element != null &&
        element.type.isDynamic &&
        element.type.element.isSynthetic) {
      final match = RegExp(r'(\w+)\s+$').firstMatch(source);
      type = match?.group(1);
    } else if (element.type?.element != null) {
      final match = RegExp(r'(\w+<.+?>)\s+$').firstMatch(source);
      type = match?.group(1) ?? type;
    }
  }
  return type;
}
