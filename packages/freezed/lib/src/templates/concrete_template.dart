import 'package:analyzer/dart/element/element.dart';
import 'package:freezed/src/models.dart';
import 'package:freezed/src/templates/properties.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'copy_with.dart';
import 'parameter_template.dart';
import 'prototypes.dart';

class Concrete {
  Concrete({
    required this.constructor,
    required this.genericsDefinition,
    required this.genericsParameter,
    required this.allConstructors,
    required this.hasDiagnosticable,
    required this.shouldGenerateJson,
    required this.commonProperties,
    required this.name,
    required this.unionKey,
    required this.copyWith,
    required this.shouldUseExtends,
  });

  final ConstructorDetails constructor;
  final List<ConstructorDetails> allConstructors;
  final GenericsDefinitionTemplate genericsDefinition;
  final GenericsParameterTemplate genericsParameter;
  final List<Property> commonProperties;
  final bool hasDiagnosticable;
  final bool shouldGenerateJson;
  final String name;
  final String unionKey;
  final CopyWith copyWith;
  final bool shouldUseExtends;

  String get concreteName {
    return '_\$${constructor.redirectedName}';
  }

  String get nonPrivateConcreteName {
    return '\$${constructor.redirectedName}';
  }

  @override
  String toString() {
    final asserts = constructor.asserts.join(',');
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

/// @nodoc
${shouldGenerateJson && !constructor.hasJsonSerializable ? '@JsonSerializable()' : ''}
${constructor.decorators.join('\n')}
class $concreteName$genericsDefinition $_concreteSuper {
  $_isConst $concreteName(${constructor.parameters.asThis()})$trailing;

  $_concreteFromJsonConstructor

$_properties

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
  $_isConst factory ${constructor.redirectedName}(${constructor.parameters.asExpandedDefinition}) = $concreteName$genericsParameter;
  $_privateConcreteConstructor

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

  String get _isConst {
    return constructor.isConst ? 'const' : '';
  }

  String get _redirectedFromJsonConstructor {
    if (!shouldGenerateJson) return '';
    return 'factory ${constructor.redirectedName}.fromJson(Map<String, dynamic> json) = $concreteName$genericsParameter.fromJson;';
  }

  String get _concreteFromJsonConstructor {
    if (!shouldGenerateJson) return '';
    return 'factory $concreteName.fromJson(Map<String, dynamic> json) => _\$${nonPrivateConcreteName}FromJson(json);';
  }

  String get _toJson {
    if (!shouldGenerateJson) return '';

    final addRuntimeType = allConstructors.length > 1
        ? "..['$unionKey'] = '${constructor.unionValue}'"
        : '';

    return '''
@override
Map<String, dynamic> toJson() {
  return _\$${nonPrivateConcreteName}ToJson(this)$addRuntimeType;
}''';
  }

  String get _debugFillProperties {
    if (!hasDiagnosticable) return '';

    final diagnostics = [
      for (final e in constructor.impliedProperties)
        "..add(DiagnosticsProperty('${e.name}', ${e.name}))",
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
  if (${constructor.callbackName} != null) {
    return ${constructor.callbackName}(this);
  }
  return orElse();
}''';
  }

  String get _map {
    if (!allConstructors.shouldGenerateUnions) return '';

    return '''
@override
${mapPrototype(allConstructors, genericsParameter)} {
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
  if (${constructor.callbackName} != null) {
    return ${constructor.callbackName}($callbackParameters);
  }
  return orElse();
}''';
  }

  String get _when {
    if (!allConstructors.shouldGenerateUnions) return '';

    var callbackParameters = constructor.impliedProperties.map((e) {
      if (allConstructors.any((c) => c.callbackName == e.name)) {
        return 'this.${e.name}';
      }
      return e.name;
    }).join(',');

    return '''
@override
${whenPrototype(allConstructors)} {
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
      for (final p in constructor.impliedProperties) '${p.name}: \$${p.name}',
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
    if (element.type.element != null &&
        element.type.isDynamic &&
        element.type.element!.isSynthetic) {
      final match = RegExp(r'(\w+\??)\s+$').firstMatch(source);
      type = match?.group(1);
    } else if (element.type.element != null) {
      final match = RegExp(r'(\w+<.+?>\??)\s+$').firstMatch(source);
      type = match?.group(1) ?? type;
    }
  }
  return type;
}
