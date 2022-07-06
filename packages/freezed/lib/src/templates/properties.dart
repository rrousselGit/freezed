import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
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
    '\\nPlease check the documentation here for more information: '
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
    required this.isFinal,
    required this.isNullable,
    required this.isDartList,
    required this.isDartMap,
    required this.isDartSet,
    required this.isPossiblyDartCollection,
  }) : type = type ?? 'dynamic';

  static Future<Property> fromParameter(
    ParameterElement element,
    BuildStep buildStep, {
    required bool addImplicitFinal,
  }) async {
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
      isNullable: element.type.nullabilitySuffix == NullabilitySuffix.question,
      isDartList: element.type.isDartCoreList,
      isDartMap: element.type.isDartCoreMap,
      isDartSet: element.type.isDartCoreSet,
      isFinal: addImplicitFinal || element.isFinal,
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
  final bool isNullable;
  final bool isDartList;
  final bool isDartMap;
  final bool isDartSet;
  final bool isFinal;
  final List<String> decorators;
  final String? defaultValueSource;
  final bool hasJsonKey;
  final String doc;
  final bool isPossiblyDartCollection;

  @override
  String toString() {
    final leading = isFinal ? 'final ' : '';
    return '$doc${decorators.join()} $leading $type $name;';
  }

  Getter get unimplementedGetter => Getter(
        name: name,
        type: type,
        decorators: decorators,
        doc: doc,
        body: ' => throw $privConstUsedErrorVarName;',
      );

  Getter get abstractGetter => Getter(
        name: name,
        type: type,
        decorators: decorators,
        doc: doc,
        body: ';',
      );

  Getter asGetter(String body) => Getter(
        name: name,
        type: type,
        decorators: decorators,
        doc: doc,
        body: body,
      );

  Setter get unimplementedSetter => Setter(
        name: name,
        type: type,
        decorators: decorators,
        doc: doc,
        body: ' => throw $privConstUsedErrorVarName;',
      );

  Setter get abstractSetter => Setter(
        name: name,
        type: type,
        decorators: decorators,
        doc: doc,
        body: ';',
      );

  Property copyWith({
    String? type,
    String? name,
    bool? isNullable,
    bool? isDartList,
    bool? isDartMap,
    bool? isDartSet,
    bool? isFinal,
    List<String>? decorators,
    String? defaultValueSource,
    bool? hasJsonKey,
    String? doc,
    bool? isPossiblyDartCollection,
  }) {
    return Property(
      type: type ?? this.type,
      name: name ?? this.name,
      isNullable: isNullable ?? this.isNullable,
      decorators: decorators ?? this.decorators,
      defaultValueSource: defaultValueSource ?? this.defaultValueSource,
      hasJsonKey: hasJsonKey ?? this.hasJsonKey,
      doc: doc ?? this.doc,
      isFinal: isFinal ?? this.isFinal,
      isDartList: isDartList ?? this.isDartList,
      isDartMap: isDartMap ?? this.isDartMap,
      isDartSet: isDartSet ?? this.isDartSet,
      isPossiblyDartCollection:
          isPossiblyDartCollection ?? this.isPossiblyDartCollection,
    );
  }
}

class Getter {
  Getter({
    required String? type,
    required this.name,
    required this.decorators,
    required this.doc,
    required this.body,
  }) : type = type ?? 'dynamic';

  final String type;
  final String name;
  final List<String> decorators;
  final String doc;
  final String body;

  @override
  String toString() {
    return '$doc${decorators.join()} $type get $name$body';
  }
}

class Setter {
  Setter({
    required String? type,
    required this.name,
    required this.decorators,
    required this.doc,
    required this.body,
  }) : type = type ?? 'dynamic';

  final String type;
  final String name;
  final List<String> decorators;
  final String doc;
  final String body;

  @override
  String toString() {
    return '$doc${decorators.join()} set $name($type value)$body';
  }
}

extension IsDartCollection on DartType {
  /// Whether this type can potentially contain a [List], [Map], [Set] or [Iterable].
  ///
  /// This includes types such as [dynamic], [Object] and generics
  bool get isPossiblyDartCollection {
    final interface = safeCast<InterfaceType>();

    return isDartCoreMap ||
        isDartCoreIterable ||
        isDartCoreSet ||
        isDartCoreList ||
        isDynamic ||
        isDartCoreObject ||
        this is TypeParameterType ||
        (interface != null &&
            interface.allSupertypes.any((e) => e.isPossiblyDartCollection));
  }
}

extension on Object? {
  T? safeCast<T>() {
    final that = this;
    if (that is T) return that;
    return null;
  }
}
