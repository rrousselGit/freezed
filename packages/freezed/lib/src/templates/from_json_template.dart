import 'package:analyzer_buffer/analyzer_buffer.dart';
import 'package:collection/collection.dart';
import 'package:freezed/src/freezed_generator.dart';
import 'package:source_gen/source_gen.dart';

import '../models.dart';
import '../parse_generator.dart';
import 'prototypes.dart';

class FromJson implements Template {
  FromJson(this.clazz);

  final Class clazz;

  @override
  void generate(AnalyzerBuffer buffer) {
    // For manual classes, we don't handle from/toJson. This is because parts
    // cannot add annotations on user's behalf.
    if (clazz.constructors.isEmpty) return;

    final conflictCtor = clazz.constructors
        .where((c) => c.redirectedName.public == clazz.name.public)
        .firstOrNull;

    if (conflictCtor != null) {
      if (clazz.constructors.length == 1) return;

      throw InvalidGenerationSourceError('''
Could not generate _\$${clazz.name}FromJson because both ${clazz.name} and ${conflictCtor.redirectedName} would want to generate it.
Rename one or the other, such that they don't conflict.
''');
    }

    String content;

    if (clazz.constructors.length == 1) {
      content = '''
    return ${clazz.constructors.first.redirectedName}${clazz.genericsParameterTemplate}.fromJson(
      json${fromJsonArguments(clazz.genericsParameterTemplate, clazz.options.genericArgumentFactories)}
    );''';
    } else {
      final cases =
          clazz.constructors.where((element) => !element.isFallback).map((
        constructor,
      ) {
        final caseName = constructor.unionValue;
        final concreteName = constructor.redirectedName;

        return '''
        case '$caseName':
          return $concreteName${clazz.genericsParameterTemplate}.fromJson(
            json${fromJsonArguments(clazz.genericsParameterTemplate, clazz.options.genericArgumentFactories)}
          );
        ''';
      }).join();

      // TODO(rrousselGit): update logic once https://github.com/rrousselGit/freezed/pull/370 lands
      var defaultCase = '''
throw CheckedFromJsonException(
  json,
  \'${clazz.options.annotation.unionKey}\',
  \'${clazz.name}\',
  \'Invalid union type "\${json[\'${clazz.options.annotation.unionKey}\']}"!\'
);''';
      final fallbackConstructor = clazz.constructors.singleWhereOrNull(
        (element) => element.isFallback,
      );
      if (fallbackConstructor != null) {
        defaultCase = '''
return ${fallbackConstructor.redirectedName}${clazz.genericsParameterTemplate}.fromJson(
  json${fromJsonArguments(clazz.genericsParameterTemplate, clazz.options.genericArgumentFactories)}
);''';
      }

      content = '''
        switch (json['${clazz.options.annotation.unionKey}']) {
          $cases
          default:
            $defaultCase
        }
      ''';
    }

    buffer.write('''
${clazz.name}${clazz.genericsParameterTemplate} _\$${clazz.name.public}FromJson${clazz.genericsDefinitionTemplate}(
  Map<String, dynamic> json${fromJsonParameters(clazz.genericsParameterTemplate, clazz.options.genericArgumentFactories)}
) {
$content
}
''');
  }
}
