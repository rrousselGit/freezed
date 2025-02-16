import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:collection/collection.dart';
import 'package:freezed/src/templates/copy_with.dart';
import 'package:freezed/src/templates/properties.dart';
import 'package:freezed/src/tools/type.dart';
import 'package:freezed_annotation/freezed_annotation.dart' show Freezed;
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

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

class CommonProperties {
  /// Properties that have a getter in the abstract class
  final List<Property> readableProperties = [];

  /// Properties that are visible on `copyWith`
  final List<Property> cloneableProperties = [];
}

@immutable
class FreezedGenerator extends ParserGenerator<Freezed> {
  FreezedGenerator(this._buildYamlConfigs);

  final Freezed _buildYamlConfigs;

  Data parseDeclaration(
    LibraryData globalData,
    Declaration declaration,
    DartObject annotation,
  ) {
    if (declaration is! ClassDeclaration) {
      throw InvalidGenerationSourceError(
        '@freezed can only be applied on classes.',
        element: declaration.declaredElement,
      );
    }

    final configs = ClassConfig.from(
      annotation,
      declaration,
      _buildYamlConfigs,
      library: globalData,
    );

    final constructors = ConstructorDetails.parseAll(
      declaration,
      configs,
      globalConfigs: _buildYamlConfigs,
    );

    return Data.from(
      declaration,
      configs,
      constructors: constructors,
    );
  }

  CommonProperties _commonParametersBetweenAllConstructors(
    List<ConstructorDetails> constructorsNeedsGeneration,
  ) {
    final result = CommonProperties();
    if (constructorsNeedsGeneration.length == 1) {
      result.readableProperties.addAll(
        constructorsNeedsGeneration.first.parameters.allParameters
            .map(Property.fromParameter),
      );
      result.cloneableProperties.addAll(result.readableProperties);
      return result;
    }

    parameterLoop:
    for (final parameter
        in constructorsNeedsGeneration.first.parameters.allParameters) {
      final library = parameter.parameterElement!.library!;

      var commonTypeBetweenAllUnionConstructors =
          parameter.parameterElement!.type;

      for (final constructor in constructorsNeedsGeneration) {
        final matchingParameter = constructor.parameters.allParameters
            .firstWhereOrNull((p) => p.name == parameter.name);
        // The property is not present in one of the union cases, so shouldn't
        // be present in the abstract class.
        if (matchingParameter == null) continue parameterLoop;

        commonTypeBetweenAllUnionConstructors =
            library.typeSystem.leastUpperBound(
          commonTypeBetweenAllUnionConstructors,
          matchingParameter.parameterElement!.type,
        );
      }

      final matchingParameters = constructorsNeedsGeneration
          .expand((element) => element.parameters.allParameters)
          .where((element) => element.name == parameter.name)
          .toList();

      final isFinal = matchingParameters.any(
        (element) =>
            element.isFinal ||
            element.parameterElement?.type !=
                commonTypeBetweenAllUnionConstructors,
      );

      final nonNullableCommonType = library.typeSystem
          .promoteToNonNull(commonTypeBetweenAllUnionConstructors);

      final didDowncast = matchingParameters.any(
        (element) =>
            element.parameterElement?.type !=
            commonTypeBetweenAllUnionConstructors,
      );
      final didNonNullDowncast = matchingParameters.any(
        (element) =>
            element.parameterElement?.type !=
                commonTypeBetweenAllUnionConstructors &&
            element.parameterElement?.type != nonNullableCommonType,
      );
      final didNullDowncast = !didNonNullDowncast && didDowncast;

      final commonTypeString = resolveFullTypeStringFrom(
        library,
        commonTypeBetweenAllUnionConstructors,
      );

      final commonProperty = Property(
        isFinal: isFinal,
        type: commonTypeString,
        isNullable: commonTypeBetweenAllUnionConstructors.isNullable,
        isDartList: commonTypeBetweenAllUnionConstructors.isDartCoreList,
        isDartMap: commonTypeBetweenAllUnionConstructors.isDartCoreMap,
        isDartSet: commonTypeBetweenAllUnionConstructors.isDartCoreSet,
        isPossiblyDartCollection:
            commonTypeBetweenAllUnionConstructors.isPossiblyDartCollection,
        name: parameter.name,
        decorators: parameter.decorators,
        defaultValueSource: parameter.defaultValueSource,
        doc: parameter.doc,
        // TODO support JsonKey
        hasJsonKey: false,
      );

      result.readableProperties.add(commonProperty);

      // For {int a, int b, int c} | {int a, int? b, double c}, allows:
      // copyWith({int a, int b})
      // - int? b is not allowed because `null` is not compatible with the
      //   first union case.
      // - num c is not allowed because num is not assignable int/double
      if (!didNonNullDowncast) {
        final copyWithType = didNullDowncast
            ? nonNullableCommonType
            : commonTypeBetweenAllUnionConstructors;

        result.cloneableProperties.add(
          Property(
            isFinal: isFinal,
            type: resolveFullTypeStringFrom(
              library,
              copyWithType,
            ),
            isNullable: copyWithType.isNullable,
            isDartList: copyWithType.isDartCoreList,
            isDartMap: copyWithType.isDartCoreMap,
            isDartSet: copyWithType.isDartCoreSet,
            isPossiblyDartCollection: copyWithType.isPossiblyDartCollection,
            name: parameter.name,
            decorators: parameter.decorators,
            defaultValueSource: parameter.defaultValueSource,
            doc: parameter.doc,
            // TODO support JsonKey
            hasJsonKey: false,
          ),
        );
      }
    }

    return result;
  }

  Iterable<DeepCloneableProperty> _getCommonDeepCloneableProperties(
    List<ConstructorDetails> constructors,
    CommonProperties commonProperties,
  ) sync* {
    for (final commonProperty in commonProperties.cloneableProperties) {
      final commonGetter = commonProperties.readableProperties
          .firstWhereOrNull((e) => e.name == commonProperty.name);
      final deepCopyProperty = constructors.first.cloneableProperties
          .firstWhereOrNull((e) => e.name == commonProperty.name);

      if (deepCopyProperty == null || commonGetter == null) continue;

      yield deepCopyProperty.copyWith(
        nullable: deepCopyProperty.nullable ||
            commonProperty.isNullable ||
            commonGetter.isNullable,
      );
    }
  }

  Iterable<Object> generateForAll(LibraryData globalData) sync* {
    yield r'T _$identity<T>(T value) => value;';
  }

  @override
  Iterable<Object> generateAll(
    List<CompilationUnit> units,
    List<AnnotationMeta> annotations,
  ) sync* {
    if (annotations.isEmpty) return;

    final library = LibraryData.from(units);
    for (final value in generateForAll(library)) {
      yield value;
    }

    final datas = annotations.map(
      (e) => parseDeclaration(library, e.declaration, e.annotation),
    );

    for (final data in datas) {
      for (final value in generateForData(library, data)) {
        yield value;
      }
    }
  }

  Iterable<Object> generateForData(
    LibraryData globalData,
    Data data,
  ) sync* {
    if (data.options.fromJson) {
      yield FromJson(
        name: data.name,
        unionKey: data.options.unionKey,
        constructors: data.constructors,
        genericParameters: data.genericsParameterTemplate,
        genericDefinitions: data.genericsDefinitionTemplate,
        genericArgumentFactories: data.genericArgumentFactories,
      );
    }

    final commonProperties =
        _commonParametersBetweenAllConstructors(data.constructors);

    final commonCopyWith = !data.options.copyWith
        ? null
        : CopyWith(
            clonedClassName: data.name,
            readableProperties: commonProperties.readableProperties,
            cloneableProperties: commonProperties.cloneableProperties,
            deepCloneableProperties: _getCommonDeepCloneableProperties(
              data.constructors,
              commonProperties,
            ).toList(),
            genericsDefinition: data.genericsDefinitionTemplate,
            genericsParameter: data.genericsParameterTemplate,
            data: data,
          );

    yield Abstract(
      data: data,
      copyWith: commonCopyWith,
      commonProperties: commonProperties.readableProperties,
    );

    for (final constructor in data.constructors) {
      yield Concrete(
        data: data,
        constructor: constructor,
        commonProperties: commonProperties.readableProperties,
        globalData: globalData,
        copyWith: !data.options.copyWith
            ? null
            : CopyWith(
                clonedClassName: '_\$${constructor.redirectedName.public}Impl',
                cloneableProperties: constructor.impliedProperties,
                readableProperties: constructor.impliedProperties,
                deepCloneableProperties: constructor.cloneableProperties,
                genericsDefinition: data.genericsDefinitionTemplate,
                genericsParameter: data.genericsParameterTemplate,
                data: data,
                parent: commonCopyWith,
              ),
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
