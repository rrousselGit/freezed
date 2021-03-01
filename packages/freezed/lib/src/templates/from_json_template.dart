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

  bool get _hasGenericArgumentFactories =>
      constructors.any((cons) => cons.decorators
          .where((dec) => dec.startsWith('@JsonSerializable'))
          .any((dec) => dec.contains('genericArgumentFactories: true')));

  @override
  String toString() {
    String content;

    final genericArgs = _hasGenericArgumentFactories
        ? genericParameters.typeParameters
            .map((type) => ', $type Function(Object? json) fromJson$type')
            .join()
        : '';

    final genericArgsNames = _hasGenericArgumentFactories
        ? genericParameters.typeParameters
            .map((type) => ', fromJson$type')
            .join()
        : '';

    if (constructors.length == 1) {
      content =
          'return ${constructors.first.redirectedName}$genericParameters.fromJson(json$genericArgsNames);';
    } else {
      final cases = constructors.map((constructor) {
        final caseName = constructor.unionValue;
        final concreteName = constructor.redirectedName;

        return '''
        case '$caseName':
          return $concreteName$genericParameters.fromJson(json$genericArgsNames);
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
$name$genericParameters _\$${name}FromJson$genericDefinitions(Map<String, dynamic> json$genericArgs) {
$content
}
''';
  }
}
