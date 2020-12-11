import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import '../utils.dart';
import 'concrete_template.dart';
import 'prototypes.dart';

class Property {
  Property({
    required String type,
    required this.name,
    required this.decorators,
    required this.nullable,
    required this.defaultValueSource,
    required this.hasJsonKey,
    required this.doc,
  }) : type = type ?? 'dynamic';

  static Future<Property> fromParameter(
    ParameterElement element,
    BuildStep buildStep,
  ) async {
    final defaultValue = element.defaultValue;
    if (defaultValue != null &&
        (element.hasRequired || element.isRequiredPositional)) {
      throw InvalidGenerationSourceError(
        '@Default cannot be used on non-optional parameters',
        element: element,
      );
    }

    return Property(
      name: element.name,
      doc: await documentationOfParameter(element, buildStep),
      type: parseTypeSource(element),
      decorators: parseDecorators(element.metadata),
      nullable: element.isNullable,
      defaultValueSource: defaultValue,
      hasJsonKey: element.hasJsonKey,
    );
  }

  final String type;
  final String name;
  final List<String> decorators;
  final bool nullable;
  final String? defaultValueSource;
  final bool hasJsonKey;
  final String doc;

  @override
  String toString() {
    return '$doc${decorators.join()} final $type $name;';
  }

  Getter get getter => Getter(
        name: name,
        type: type,
        decorators: decorators,
        nullable: nullable,
        doc: doc,
      );
}

class Getter {
  Getter({
    required String type,
    required this.name,
    required this.decorators,
    required this.nullable,
    required this.doc,
  }) : type = type ?? 'dynamic';

  final String type;
  final String name;
  final List<String> decorators;
  final bool nullable;
  final String doc;

  @override
  String toString() {
    return '$doc${decorators.join()} $type get $name;';
  }
}

extension PropertiesAsGetters on List<Property> {
  List<Getter> asGetters() {
    return map((p) => p.getter).toList();
  }
}

class LateGetter {
  final String type;
  final String name;
  final List<String> decorators;
  final String source;

  LateGetter({
    required this.type,
    required this.name,
    required this.decorators,
    required this.source,
  });

  @override
  String toString() {
    return '''
bool _did$name = false;
${type ?? 'dynamic'} _$name;

@override
${decorators.join()}
${type ?? 'dynamic'} get $name {
  if (_did$name == false) {
    _did$name = true;
    _$name = $source;
  }
  return _$name;
}''';
  }
}
