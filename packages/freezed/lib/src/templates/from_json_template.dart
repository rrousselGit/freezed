import 'package:freezed/src/templates/parameter_template.dart';

import '../models.dart';

class FromJson {
  FromJson({
    required this.name,
    required this.unionKey,
    required this.constructors,
    required this.genericParameters,
    required this.genericDefinitions,
  });

  final String name;
  final String unionKey;
  final List<ConstructorDetails> constructors;
  final GenericsParameterTemplate genericParameters;
  final GenericsDefinitionTemplate genericDefinitions;

  @override
  String toString() {
    String content;

    if (constructors.length == 1) {
      content =
          'return ${constructors.first.redirectedName}$genericParameters.fromJson(json);';
    } else {
      final cases = constructors
          .where((element) => !element.isFallback)
          .map((constructor) {
        final caseName = constructor.unionValue;
        final concreteName = constructor.redirectedName;

        return '''
        case '$caseName':
          return $concreteName$genericParameters.fromJson(json);
        ''';
      }).join();

      var defaultCase = 'throw FallThroughError();';
      if (constructors.any((element) => element.isFallback)) {
        final fallbackConstructor =
            constructors.singleWhere((element) => element.isFallback);
        defaultCase =
  // TODO(rrousselGit): update logic once https://github.com/rrousselGit/freezed/pull/370 lands
            'return ${fallbackConstructor.redirectedName}$genericParameters.fromJson(json);';
      }

      content = '''
        switch (json['$unionKey'] as String) {
          $cases
          default:
            $defaultCase
        }
      ''';
    }

    return '''
$name$genericParameters _\$${name}FromJson$genericDefinitions(Map<String, dynamic> json) {
$content
}
''';
  }
}
