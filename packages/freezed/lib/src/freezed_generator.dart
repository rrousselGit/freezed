import 'package:analyzer/dart/ast/ast.dart';
import 'package:collection/collection.dart';
import 'package:freezed/src/templates/copy_with.dart';
import 'package:freezed/src/templates/pattern_template.dart';
import 'package:freezed/src/tools/type.dart';
import 'package:freezed_annotation/freezed_annotation.dart' show Freezed;
import 'package:meta/meta.dart';

import 'models.dart';
import 'parse_generator.dart';
import 'templates/abstract_template.dart';
import 'templates/concrete_template.dart';
import 'templates/from_json_template.dart';

extension StringX on String {
  String get public {
    if (startsWith('_')) return substring(1);
    return this;
  }
}

@immutable
class FreezedGenerator extends ParserGenerator<Freezed> {
  FreezedGenerator(this._buildYamlConfigs, {required this.format});

  final Freezed _buildYamlConfigs;
  final bool format;

  Iterable<DeepCloneableProperty> _getCommonDeepCloneableProperties(
    List<ConstructorDetails> constructors,
    PropertyList commonProperties,
  ) sync* {
    for (final commonProperty in commonProperties.cloneableProperties) {
      final commonGetter = commonProperties.readableProperties.firstWhereOrNull(
        (e) => e.name == commonProperty.name,
      );
      final deepCopyProperty = constructors.firstOrNull?.deepCloneableProperties
          .firstWhereOrNull((e) => e.name == commonProperty.name);

      if (deepCopyProperty == null || commonGetter == null) continue;

      yield deepCopyProperty.copyWith(
        nullable:
            deepCopyProperty.nullable ||
            commonProperty.type.isNullable ||
            commonGetter.type.isNullable,
      );
    }
  }

  Iterable<Object> _generateForAll(Library globalData) sync* {
    yield r'T _$identity<T>(T value) => value;';
  }

  @override
  Iterable<Object> generateAll(
    List<CompilationUnit> units,
    List<AnnotationMeta> annotations,
  ) sync* {
    if (annotations.isEmpty) return;

    if (!format) yield '// dart format off';

    final library = Library.from(units);
    for (final value in _generateForAll(library)) {
      yield value;
    }

    final userDefinedClasses = Class.parseAll(
      units,
      annotations,
      library,
      globalConfigs: _buildYamlConfigs,
    );

    for (final data in userDefinedClasses) {
      for (final value in _generateForData(library, data)) {
        yield value;
      }
    }

    if (!format) yield '// dart format on';
  }

  Iterable<Object> _generateForData(Library globalData, Class data) sync* {
    if (data.options.fromJson) yield FromJson(data);

    final commonCopyWith = data.options.annotation.copyWith ?? true
        ? CopyWith(
            parents: data.parents,
            clonedClassName: data.name,
            readableProperties: data.properties.readableProperties,
            cloneableProperties: data.properties.cloneableProperties,
            deepCloneableProperties: _getCommonDeepCloneableProperties(
              data.constructors,
              data.properties,
            ).toList(),
            genericsDefinition: data.genericsDefinitionTemplate,
            genericsParameter: data.genericsParameterTemplate,
            data: data,
          )
        : null;

    yield Abstract(
      data: data,
      copyWith: commonCopyWith,
      commonProperties: data.properties.readableProperties,
      globalData: globalData,
    );

    yield patterns(data);

    for (final constructor in data.constructors) {
      yield Concrete(
        data: data,
        constructor: constructor,
        commonProperties: data.properties.readableProperties,
        globalData: globalData,
        copyWith:
            data.options.annotation.copyWith ??
                constructor.parameters.allParameters.isNotEmpty
            ? CopyWith(
                parents: {},
                clonedClassName: constructor.redirectedName,
                cloneableProperties: constructor.properties.toList(),
                readableProperties: constructor.properties
                    .where((e) => e.isSynthetic)
                    .toList(),
                deepCloneableProperties: constructor.deepCloneableProperties,
                genericsDefinition: data.genericsDefinitionTemplate,
                genericsParameter: data.genericsParameterTemplate,
                data: data,
                parent: commonCopyWith,
              )
            : null,
      );
    }
  }
}

String? parseLateGetterSource(String source) {
  var parenthesis = 0;

  for (var i = 0; i < source.length; i++) {
    final char = source[i];
    switch (char) {
      case '(':
        parenthesis++;
        break;
      case ')':
        parenthesis--;
        break;
      case ';':
        if (parenthesis == 0) {
          final reg = RegExp(r'^[\s\t\n]*=>[\s\t\n]*(.+)', dotAll: true);
          return reg.firstMatch(source.substring(0, i))?.group(1);
        }
        break;
      default:
        break;
    }
  }
  return null;
}
