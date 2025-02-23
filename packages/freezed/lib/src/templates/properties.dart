import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:freezed/src/ast.dart';
import 'package:freezed/src/templates/parameter_template.dart';
import 'package:freezed/src/tools/type.dart';
import 'package:source_gen/source_gen.dart';

import 'concrete_template.dart';
import 'prototypes.dart';

class Property {
  Property({
    required String? type,
    required this.name,
    required this.decorators,
    required this.defaultValueSource,
    required this.hasJsonKey,
    required this.doc,
    required this.isSynthetic,
    required this.isFinal,
    required this.isNullable,
    required this.isDartList,
    required this.isDartMap,
    required this.isDartSet,
    required this.isPossiblyDartCollection,
  }) : type = type ?? 'dynamic';

  Property.fromParameter(
    Parameter p, {
    required bool isSynthetic,
  }) : this(
          decorators: p.decorators,
          name: p.name,
          isFinal: p.isFinal,
          doc: p.doc,
          type: p.type,
          defaultValueSource: p.defaultValueSource,
          isSynthetic: isSynthetic,
          isNullable: p.isNullable,
          isDartList: p.isDartList,
          isDartMap: p.isDartMap,
          isDartSet: p.isDartSet,
          isPossiblyDartCollection: p.isPossiblyDartCollection,
          hasJsonKey: false,
        );

  static Property fromFormalParameter(
    FormalParameter parameter, {
    required bool addImplicitFinal,
    required bool isSynthetic,
  }) {
    final element = parameter.declaredElement!;

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
      isNullable: element.type.isNullable,
      isDartList: element.type.isDartCoreList,
      isDartMap: element.type.isDartCoreMap,
      isDartSet: element.type.isDartCoreSet,
      isFinal: addImplicitFinal || element.isFinal,
      isSynthetic: isSynthetic,
      doc: parameter.documentation ?? '',
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
  final bool isSynthetic;
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
    ParameterElement? parameterElement,
  }) {
    return Property(
      type: type ?? this.type,
      name: name ?? this.name,
      isSynthetic: isSynthetic,
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
  String toString({bool shouldOverride = false}) {
    final finalDecorators = [if (shouldOverride) '@override', ...decorators];
    return '$doc${finalDecorators.join()} $type get $name$body';
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

    return _isDartCollectionType ||
        isDynamic2 ||
        isDartCoreObject ||
        this is TypeParameterType ||
        (interface != null &&
            interface.allSupertypes.any((e) => e._isDartCollectionType));
  }

  /// Whether this type is a [List], [Map], [Set] or [Iterable].
  bool get _isDartCollectionType {
    return isDartCoreMap ||
        isDartCoreIterable ||
        isDartCoreSet ||
        isDartCoreList;
  }
}

extension on Object? {
  T? safeCast<T>() {
    final that = this;
    if (that is T) return that;
    return null;
  }
}
