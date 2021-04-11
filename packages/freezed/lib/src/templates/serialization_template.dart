import '../models.dart';
import 'parameter_template.dart';
import 'properties.dart';

class Serialization {
  Serialization({
    required this.name,
    required this.unionKey,
    required this.genericParameters,
    required this.genericDefinitions,
    required this.hasGenericArgumentFactories,
    required this.shouldGenerateJson,
    required this.allConstructors,
  });

  final String name;
  final String unionKey;
  final bool hasGenericArgumentFactories;
  final bool shouldGenerateJson;
  final GenericsParameterTemplate genericParameters;
  final GenericsDefinitionTemplate genericDefinitions;
  final List<ConstructorDetails> allConstructors;

  String get _genericToJsonArgs => hasGenericArgumentFactories
      ? genericParameters.typeParameters.map((type) {
          return 'Object Function($type value) toJson$type';
        }).join(', ')
      : '';

  String get _genericToJsonArgsNames => hasGenericArgumentFactories
      ? genericParameters.typeParameters.map((type) => ', toJson$type').join()
      : '';

  String get _genericFromJsonArgs => hasGenericArgumentFactories
      ? genericParameters.typeParameters.map((type) {
          return ', $type Function(Object? json) fromJson$type';
        }).join()
      : '';

  String get _genericFromJsonArgsNames => hasGenericArgumentFactories
      ? genericParameters.typeParameters.map((type) => ', fromJson$type').join()
      : '';

  String get abstractToJson {
    if (!shouldGenerateJson) return '';

    return 'Map<String, dynamic> toJson($_genericToJsonArgs) => throw $privConstUsedErrorVarName;';
  }

  String jsonAnnotationForConstructor(
    ConstructorDetails constructor,
    GenericsDefinitionTemplate genericsDefinition,
  ) {
    if (!shouldGenerateJson || constructor.hasJsonSerializable) return '';

    return hasGenericArgumentFactories &&
            genericDefinitions.typeParameters.isNotEmpty
        ? '@JsonSerializable(genericArgumentFactories: true)'
        : '@JsonSerializable()';
  }

  String concreteFromJsonRedirectedConstructor(
    String concreteName,
    String redirectNamme,
  ) {
    if (!shouldGenerateJson) return '';

    return 'factory $redirectNamme.fromJson(Map<String, dynamic> json$_genericFromJsonArgs) = $concreteName$genericParameters.fromJson;';
  }

  String concreteFromJsonConstructor(String concreteName) {
    if (!shouldGenerateJson) return '';

    return 'factory $concreteName.fromJson(Map<String, dynamic> json$_genericFromJsonArgs) => _\$${concreteName}FromJson(json$_genericFromJsonArgsNames);';
  }

  String concreteToJson(ConstructorDetails constructor, String concreteName) {
    if (!shouldGenerateJson) return '';

    final addRuntimeType = allConstructors.length > 1
        ? "..['$unionKey'] = '${constructor.unionValue}'"
        : '';

    return '''
@override
Map<String, dynamic> toJson($_genericToJsonArgs) {
  return _\$${concreteName}ToJson(this$_genericToJsonArgsNames)$addRuntimeType;
}''';
  }

  String tearOffFromJson(
    String name,
    GenericsDefinitionTemplate genericsDefinition,
  ) {
    return '''
$name$genericParameters fromJson$genericsDefinition(Map<String, Object> json$_genericFromJsonArgs) {
  return $name$genericParameters.fromJson(json$_genericFromJsonArgsNames);
}
''';
  }

  String get fromJson {
    String content;

    if (allConstructors.length == 1) {
      content =
          'return ${allConstructors.first.redirectedName}$genericParameters.fromJson(json$_genericFromJsonArgsNames);';
    } else {
      final cases = allConstructors.map((constructor) {
        final caseName = constructor.unionValue;
        final concreteName = constructor.redirectedName;

        return '''
        case '$caseName':
          return $concreteName$genericParameters.fromJson(json$_genericFromJsonArgsNames);
        ''';
      }).join();

      content = '''
        switch (json['$unionKey'] as String) {
          $cases
          default:
            throw FallThroughError();
        }
      ''';
    }

    return '''
$name$genericParameters _\$${name}FromJson$genericDefinitions(Map<String, dynamic> json$_genericFromJsonArgs) {
$content
}
''';
  }
}
