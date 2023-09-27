import 'package:collection/collection.dart';
import 'package:freezed/src/freezed_generator.dart';
import 'package:freezed/src/templates/parameter_template.dart';

import '../models.dart';
import 'prototypes.dart';

class FromJson {
  FromJson({
    required this.name,
    required this.unionKey,
    required this.constructors,
    required this.genericParameters,
    required this.genericDefinitions,
    required this.genericArgumentFactories,
  });

  final String name;
  final String unionKey;
  final List<ConstructorDetails> constructors;
  final GenericsParameterTemplate genericParameters;
  final GenericsDefinitionTemplate genericDefinitions;
  final bool genericArgumentFactories;

  @override
  String toString() {
    String content;

    if (constructors.length == 1) {
      content =
          'return ${constructors.first.redirectedName}$genericParameters.fromJson(json${fromJsonArguments(genericParameters, genericArgumentFactories)});';
    } else {
      final cases = constructors
          .where((element) => !element.isFallback)
          .map((constructor) {
        final caseName = constructor.unionValue;
        final concreteName = constructor.redirectedName;

        return '''
        case '$caseName':
          return $concreteName$genericParameters.fromJson(json${fromJsonArguments(genericParameters, genericArgumentFactories)});
        ''';
      }).join();

      // TODO(rrousselGit): update logic once https://github.com/rrousselGit/freezed/pull/370 lands
      var defaultCase =
          'throw CheckedFromJsonException(json, \'$unionKey\', \'$name\', \'Invalid union type "\${json[\'$unionKey\']}"!\');';
      final fallbackConstructor =
          constructors.singleWhereOrNull((element) => element.isFallback);
      if (fallbackConstructor != null) {
        defaultCase =
            'return ${fallbackConstructor.redirectedName}$genericParameters.fromJson(json${fromJsonArguments(genericParameters, genericArgumentFactories)});';
      }

      content = '''
        switch (json['$unionKey']) {
          $cases
          default:
            $defaultCase
        }
      ''';
    }

    return '''
$name$genericParameters _\$${name.public}FromJson$genericDefinitions(Map<String, dynamic> json${fromJsonParameters(genericParameters, genericArgumentFactories)}) {
$content
}
''';
  }
}
