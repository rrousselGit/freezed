import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import '../utils.dart';
import 'concrete_template.dart';
import 'prototypes.dart';

const privConstUsedErrorString =
    'It seems like you constructed your class using `MyClass._()`. '
    'This constructor is only meant to be used by freezed '
    'and you are not supposed to need it nor use it.'
    '\\nPlease check the documentation here for more informations: '
    'https://github.com/rrousselGit/freezed#custom-getters-and-methods';

const privConstUsedErrorVarName = '_privateConstructorUsedError';

class Property {
  Property({
    required String? type,
    required this.name,
    required this.decorators,
    required this.defaultValueSource,
    required this.hasJsonKey,
    required this.doc,
    required this.isPossiblyDartCollection,
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
      defaultValueSource: defaultValue,
      hasJsonKey: element.hasJsonKey,
      isPossiblyDartCollection: element.type.isPossiblyDartCollection,
    );
  }

  final String type;
  final String name;
  final List<String> decorators;
  final String? defaultValueSource;
  final bool hasJsonKey;
  final String doc;
  final bool isPossiblyDartCollection;

  @override
  String toString() {
    return '$doc${decorators.join()} final $type $name;';
  }

  Getter get getter => Getter(
        name: name,
        type: type,
        decorators: decorators,
        doc: doc,
        isPossiblyDartCollection: isPossiblyDartCollection,
      );
}

class Getter {
  Getter({
    required String? type,
    required this.name,
    required this.decorators,
    required this.doc,
    required this.isPossiblyDartCollection,
  }) : type = type ?? 'dynamic';

  final String type;
  final String name;
  final List<String> decorators;
  final String doc;
  final bool isPossiblyDartCollection;

  @override
  String toString({
    bool throwUnimplementError = false,
  }) {
    if (throwUnimplementError) {
      return '$doc${decorators.join()} $type get $name => '
          'throw $privConstUsedErrorVarName;';
    }
    return '$doc${decorators.join()} $type get $name;';
  }
}

extension PropertiesAsGetters on List<Property> {
  List<Getter> asGetters() {
    return map((p) => p.getter).toList();
  }
}

extension IsDartCollection on DartType {
  /// Whether this type can potentially contain a [List], [Map], [Set] or [Iterable].
  ///
  /// This includes types such as [dynamic], [Object] and generics
  bool get isPossiblyDartCollection {
    return isDartCoreMap ||
        isDartCoreIterable ||
        isDartCoreSet ||
        isDartCoreList ||
        isDynamic ||
        isDartCoreObject ||
        this is TypeParameterType;
  }
}
