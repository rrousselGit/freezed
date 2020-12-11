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
      final cases = constructors.map((constructor) {
        final caseName = constructor.isDefault ? 'default' : constructor.name;
        final concreteName = constructor.redirectedName;

        return '''
        case '$caseName':
          return $concreteName$genericParameters.fromJson(json);
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
$name$genericParameters _\$${name}FromJson$genericDefinitions(Map<String, dynamic> json) {
$content
}
''';
  }
}
