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
    required this.type,
    required this.typeDisplayString,
    required this.name,
    required this.decorators,
    required this.defaultValueSource,
    required this.hasJsonKey,
    required this.doc,
    required this.isSynthetic,
    required this.isFinal,
  });

  Property.fromParameter(Parameter p, {required bool isSynthetic})
    : this(
        decorators: p.decorators,
        name: p.name,
        isFinal: p.isFinal,
        doc: p.doc,
        type: p.type,
        typeDisplayString: p.typeDisplayString,
        defaultValueSource: p.defaultValueSource,
        isSynthetic: isSynthetic,
        hasJsonKey: false,
      );

  static Property fromFormalParameter(
    FormalParameter parameter, {
    required bool addImplicitFinal,
    required bool isSynthetic,
  }) {
    final element = parameter.declaredFragment!.element;

    final defaultValue = element.defaultValue;
    if (defaultValue != null &&
        (element.isRequired || element.isRequiredPositional)) {
      throw InvalidGenerationSourceError(
        '@Default cannot be used on non-optional parameters',
        element: element,
      );
    }

    return Property(
      name: element.name!,
      isFinal: addImplicitFinal || element.isFinal,
      isSynthetic: isSynthetic,
      doc: parameter.documentation ?? '',
      type: element.type,
      typeDisplayString: parseTypeSource(parameter),
      decorators: parseDecorators(element.metadata.annotations),
      defaultValueSource: defaultValue,
      hasJsonKey: element.hasJsonKey,
    );
  }

  final DartType type;
  final String typeDisplayString;
  final String name;
  final bool isFinal;
  final bool isSynthetic;
  final List<String> decorators;
  final String? defaultValueSource;
  final bool hasJsonKey;
  final String doc;

  @override
  String toString() {
    final leading = isFinal ? 'final ' : '';
    return '$doc${decorators.join()} $leading $typeDisplayString $name;';
  }

  Getter get abstractGetter => Getter(
    name: name,
    type: typeDisplayString,
    decorators: decorators,
    doc: doc,
    body: ';',
  );

  Getter asGetter(String body) => Getter(
    name: name,
    type: typeDisplayString,
    decorators: decorators,
    doc: doc,
    body: body,
  );

  Setter get abstractSetter => Setter(
    name: name,
    type: typeDisplayString,
    decorators: decorators,
    doc: doc,
    body: ';',
  );

  Property copyWith({
    DartType? type,
    String? typeDisplayString,
    String? name,
    bool? isFinal,
    List<String>? decorators,
    String? defaultValueSource,
    bool? hasJsonKey,
    String? doc,
    bool? isPossiblyDartCollection,
    TypeParameterElement? parameterElement,
  }) {
    return Property(
      type: type ?? this.type,
      typeDisplayString: typeDisplayString ?? this.typeDisplayString,
      name: name ?? this.name,
      isSynthetic: isSynthetic,
      decorators: decorators ?? this.decorators,
      defaultValueSource: defaultValueSource ?? this.defaultValueSource,
      hasJsonKey: hasJsonKey ?? this.hasJsonKey,
      doc: doc ?? this.doc,
      isFinal: isFinal ?? this.isFinal,
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
