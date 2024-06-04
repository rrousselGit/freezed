// ignore_for_file: deprecated_member_use, unused_element

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:freezed/src/macros.dart';
import 'package:freezed/src/part_utils.dart';
import 'package:macros/macros.dart';
import 'package:meta/meta.dart';

/// An [UnmodifiableListView] which overrides ==
// ignore: invalid_internal_annotation
@internal
class EqualUnmodifiableListView<T> extends UnmodifiableListView<T> {
  /// An [UnmodifiableListView] which overrides ==
  EqualUnmodifiableListView(this._source) : super(_source);

  final Iterable<T> _source;

  @override
  bool operator ==(Object other) {
    return other is EqualUnmodifiableListView<T> &&
        other.runtimeType == runtimeType &&
        other._source == _source;
  }

  @override
  int get hashCode => Object.hash(runtimeType, _source);
}

/// An [UnmodifiableSetView] which overrides ==
// ignore: invalid_internal_annotation
@internal
class EqualUnmodifiableSetView<T> extends UnmodifiableSetView<T> {
  /// An [UnmodifiableSetView] which overrides ==
  EqualUnmodifiableSetView(this._source) : super(_source);

  final Set<T> _source;

  @override
  bool operator ==(Object other) {
    return other is EqualUnmodifiableSetView<T> &&
        other.runtimeType == runtimeType &&
        other._source == _source;
  }

  @override
  int get hashCode => Object.hash(runtimeType, _source);
}

/// An [UnmodifiableMapView] which overrides ==
// ignore: invalid_internal_annotation
@internal
class EqualUnmodifiableMapView<Key, Value>
    extends UnmodifiableMapView<Key, Value> {
  /// An [UnmodifiableMapView] which overrides ==
  EqualUnmodifiableMapView(this._source) : super(_source) {
    print('Hello world');
  }

  final Map<Key, Value> _source;

  @override
  bool operator ==(Object other) {
    return other is EqualUnmodifiableMapView<Key, Value> &&
        other.runtimeType == runtimeType &&
        other._source == _source;
  }

  @override
  int get hashCode => Object.hash(runtimeType, _source);
}

// ignore: invalid_internal_annotation
@internal
class Sentinel {
  const Sentinel();
}

// extension on DeclarationPhaseIntrospector {
//   Stream<ClassDeclaration> parents(ClassDeclaration clazz) async* {
//     final allClasses = await typesOf(clazz.library);

//     for (final possibleParent in allClasses.whereType<ClassDeclaration>()) {
//       if (clazz.isChildOf(possibleParent)) yield possibleParent;
//     }
//   }

//   Stream<ClassDeclaration> children(ClassDeclaration clazz) async* {
//     final allClasses = await typesOf(clazz.library);

//     for (final possibleChild in allClasses.whereType<ClassDeclaration>()) {
//       if (possibleChild.isChildOf(clazz)) yield possibleChild;
//     }
//   }
// }

extension on String {
  String get escaped => replaceAll(r'$', r'\$');
}

extension on ClassDeclaration {
  bool hasAnnotation(Identifier annotation) {
    return metadata.any((e) =>
        // TODO handle annotations called Freezed that aren't from the freezed package.
        e is ConstructorMetadataAnnotation &&
        e.type.identifier.name == annotation.name);
  }

  bool isChildOf(ClassDeclaration parent) {
    return superTypes.any((e) => e.identifier == parent.identifier);
  }

  Iterable<NamedTypeAnnotation> get superTypes sync* {
    yield* interfaces;
    yield* mixins;
    if (superclass != null) yield superclass!;
  }
}

class _FreezedField {
  _FreezedField({
    required this.type,
    required this.name,
    required this.isRequired,
    required this.isNamed,
    required this.isInherited,
    required this.needsDeclaration,
  });

  final TypeAnnotation type;
  final String name;
  final bool isNamed;
  final bool isRequired;
  final bool isInherited;
  final bool needsDeclaration;

  bool get isPositional => !isNamed;
  bool get isOptional => !isRequired;
}

/// A data-class macro.
///
/// **Warning**: Macros are still an experimental feature of Dart.
/// Lots of features are missing, so expect bugs.
///
/// This macro generates a `toString`, `copyWith`, `==`, and `hashCode`
/// implementation for a class.
///
/// **Note**:
/// `copyWith` supper` `class.copyWith(field: null)`. This
/// will clone the object with `field` set to `null`.
///
/// `hashCode`, `==` and `toString` won't be generated if the class
/// already possesses an implementation of those methods.
///
/// Two possible syntaxes are supported:
/// - Constructor-first.
///   You define a class with a constructor, and the macro will
///   generate fields for you.
///   This gives fine-grained control over positional vs named parameters.
///   It offers the ability to use asserts, `super`, ...
///   Although macros have still lots of things related to this that don't work.
///   So although the syntax is very flexible, lots of things are not supported yet.
///
/// - Field-first.
///   You define a class with fields, and the macro will generate a constructor for you.
///   This is the most stable syntax.
///   But it is less flexible, and not very dart-like.
///   If you want full control over constructors, you'll have to use the constructor-first syntax.
///
/// ## Constructor-first usage
///
/// To use the constructor-first syntax, define a class with a constructor,
/// but no fields:
///
/// ```dart
/// @Data()
/// class Example {
///   Example({required int foo, required String bar});
/// }
/// ```
///
/// The macro will generate the fields for you, along with
/// the various methods.
///
/// ```dart
/// void main() {
///   final example = Example(foo: 42, bar: '42');
///   print(example.foo); // 42
/// }
/// ```
///
/// ### Using named constructors.
///
/// Naturally, the macro expects that you use the default constructor.
/// If you wish to generate fields based on a named constructor instead,
/// specify `@Data(constructor: '<constructor name>')`.
///
/// ```dart
/// @Data(constructor: 'custom')
/// class Example {
///  Example.custom({required int foo, required String bar});
/// }
/// ```
///
/// ## Field-first usage
///
/// To use the field-first syntax, define a class with fields
/// but default constructor.
/// The macro will then generate a constructor for you, along
/// with the various methods.
///
/// ```dart
/// @Data()
/// class Example {
///  final int foo;
///  final String bar;
/// }
/// ```
///
/// Currently, all fields are "named" parameters, and they are optional if they are nullable.
///
/// ```dart
/// void main() {
///  final example = Example(foo: 42, bar: '42');
///  print(example.foo); // 42
/// }
/// ```
///
/// ### Specifying the constructor name
///
/// If you wish to generate a non-default constructor,
/// you can specify `@Data(constructor: '<constructor name>')`.
///
/// ```dart
/// @Data(constructor: 'custom')
/// class Example {
///   final int foo;
/// }
///
/// void main() {
///   final example = Example.custom(foo: 42);
/// }
/// ```
macro class Data implements ClassDeclarationsMacro {
  const Data({
    this.constructor,
    this.makeCollectionsUnmodifiable = true,
    this.superCtor,
  });

  /// The name of the constructor to use.
  ///
  /// If not provided, the default constructor will be used.
  final String? constructor;

  /// The name of the `super` constructor to call.
  ///
  /// Should not be provided if a constructor was manually defined.
  final String? superCtor;
  final bool makeCollectionsUnmodifiable;

  @override
  FutureOr<void> buildDeclarationsForClass(
    ClassDeclaration clazz,
    MemberDeclarationBuilder builder,
  ) async {
    final constructors = await builder.constructorsOf(clazz);
    final targetConstructor = constructors.firstWhereOrNull(
      (e) => e.identifier.name == (constructor ?? ''),
    );

    final fields = <_FreezedField>[];

    if (targetConstructor == null) {
      for (final field in await builder.fieldsOf(clazz)) {
        if (field.hasInitializer) continue;

        fields.add(
          _FreezedField(
            type: field.type,
            isNamed: true,
            name: field.identifier.name,
            isRequired: true,
            isInherited: false,
            needsDeclaration: false,
          ),
        );
      }

      // TODO once augmentation libraries work properly, automatically add fields coming from Freezed interfaces.
    } else {
      if (superCtor != null) {
        builder.report(
          Diagnostic(
            DiagnosticMessage(
              'Do not specify `superCtor` '
              'when defining a constructor',
            ),
            Severity.warning,
          ),
        );
      }

      for (final field in targetConstructor.parameters) {
        fields.add(
          _FreezedField(
            type: field.type,
            name: field.identifier.name,
            isNamed: field.isNamed,
            isRequired: field.isRequired,
            isInherited: false,
            needsDeclaration: true,
          ),
        );
      }
    }

    final targetSuperCtor = await _computeSuperCtor(clazz, builder);

    if (targetSuperCtor != null) {
      for (final field in targetSuperCtor.parameters) {
        fields.add(
          _FreezedField(
            type: field.type,
            name: field.identifier.name,
            isNamed: field.isNamed,
            isRequired: field.isRequired,
            isInherited: true,
            needsDeclaration: false,
          ),
        );
      }
    }

    builder.declareInLibrary(
      DeclarationCode.fromParts([
        'augment ',
        if (clazz.hasSealed) 'sealed ',
        'class ${clazz.identifier.name}',
        if (clazz.superclass case final superClass?) ...[
          ' extends ',
          superClass.code,
        ],
        ' {',
      ]),
    );

    await _generateConstructor(
      fields,
      builder,
      clazz,
      hasConstructor: targetConstructor != null,
      targetSuperCtor: targetSuperCtor,
    );
    await _generateFields(fields, builder, clazz);
    await _generateCopyWith(fields, builder, clazz);
    await _generateToString(fields, builder, clazz);

    if (!clazz.hasSealed) {
      // TODO generate equal/hash only if fields are final: https://github.com/dart-lang/sdk/issues/55764
      await _generateEqual(fields, builder, clazz);
      await _generateHash(fields, builder, clazz);
    }

    builder.declareInLibrary(
      DeclarationCode.fromParts([
        '}',
      ]),
    );
  }

  Future<ConstructorDeclaration?> _computeSuperCtor(
    ClassDeclaration clazz,
    MemberDeclarationBuilder builder,
  ) async {
    final superClass = clazz.superclass;
    if (superClass == null && superCtor != null) {
      builder.report(
        Diagnostic(
          DiagnosticMessage(
            'superCtor was specified, but the class does not have a superclass',
          ),
          Severity.error,
        ),
      );
      return null;
    }
    if (superClass == null) return null;

    final superDeclaration =
        await builder.typeDeclarationOf(superClass.identifier);
    final superCtors = await builder.constructorsOf(superDeclaration);
    final targetCtor = superCtors.firstWhereOrNull(
      (e) => e.identifier.name == (superCtor ?? ''),
    );

    if (targetCtor == null && superCtor != null) {
      builder.report(
        Diagnostic(
          DiagnosticMessage(
            '`superCtor` was specified, '
            'but the superclass does not have a constructor with that name',
          ),
          Severity.error,
        ),
      );
      return null;
    }

    return targetCtor;
  }

  Future<void> _generateToString(
    List<_FreezedField> fields,
    MemberDeclarationBuilder builder,
    ClassDeclaration clazz,
  ) async {
    final methods = await builder.methodsOf(clazz);
    final toString =
        methods.where((e) => e.identifier.name == 'toString').firstOrNull;

    if (toString != null) return;

    final fieldsCode = DeclarationCode.fromParts([
      for (final (index, field) in fields.indexed) ...[
        if (index != 0) ', ',
        '${field.name.escaped}: \${${field.name}}',
      ],
    ]);

    builder.declareInLibrary(
      DeclarationCode.fromParts(
        await builder.parts(args: {'fields': fieldsCode}, '''

  @{{override}}
  {{String}} toString() {
    return r'${clazz.identifier.name}'
      '#\$hashCode({{fields}})';
  }'''),
      ),
    );
  }

  Future<void> _generateEqual(
    List<_FreezedField> fields,
    MemberDeclarationBuilder builder,
    ClassDeclaration clazz,
  ) async {
    final methods = await builder.methodsOf(clazz);
    final equal =
        methods.where((e) => e.identifier.name == 'operator==').firstOrNull;
    if (equal != null) return;

    builder.declareInLibrary(
      DeclarationCode.fromParts(
        await builder.parts(
          args: {
            'Class': clazz.identifier,
            'fields':
                fields.map((e) => ' && ${e.name} == other.${e.name}').join(),
          },
          '''

  @{{override}}
  {{bool}} operator ==({{Object}} other) {
    if ({{identical}}(this, other)) return true;

    return other is {{Class}}{{fields}};
  }''',
        ),
      ),
    );
  }

  Future<void> _generateHash(
    List<_FreezedField> fields,
    MemberDeclarationBuilder builder,
    ClassDeclaration clazz,
  ) async {
    final methods = await builder.methodsOf(clazz);
    final hash =
        methods.where((e) => e.identifier.name == 'hashCode').firstOrNull;
    if (hash != null) return;

    if (fields.isEmpty) {
      builder.declareInLibrary(
        DeclarationCode.fromParts(
          await builder.parts('''

  @{{override}}
  {{int}} get hashCode => runtimeType.hashCode;'''),
        ),
      );
      return;
    }

    if (fields.length >= 19) {
      builder.declareInLibrary(
        DeclarationCode.fromParts(
          await builder.parts('''

  @{{override}}
  {{int}} get hashCode => {{Object}}.hashAll([runtimeType, ${fields.map((e) => e.name).join(', ')}]);'''),
        ),
      );
      return;
    }

    builder.declareInLibrary(
      DeclarationCode.fromParts(
        await builder.parts('''

  @{{override}}
  {{int}} get hashCode => {{Object}}.hash(runtimeType, ${fields.map((e) => e.name).join(', ')});'''),
      ),
    );
  }

  Future<void> _generateConstructor(
    List<_FreezedField> fields,
    MemberDeclarationBuilder builder,
    ClassDeclaration clazz, {
    required ConstructorDeclaration? targetSuperCtor,
    required bool hasConstructor,
  }) async {
    final list = await builder.resolveIdentifier(
      Uri.parse('dart:core'),
      'List',
    );
    final unmodifiableList = await builder.resolveIdentifier(
      Uri.parse('package:freezed/freezed.dart'),
      'EqualUnmodifiableListView',
    );
    final map = await builder.resolveIdentifier(
      Uri.parse('dart:core'),
      'Map',
    );
    final unmodifiableMap = await builder.resolveIdentifier(
      Uri.parse('package:freezed/freezed.dart'),
      'EqualUnmodifiableMapView',
    );
    final hashSet = await builder.resolveIdentifier(
      Uri.parse('dart:core'),
      'Set',
    );
    final unmodifiableSet = await builder.resolveIdentifier(
      Uri.parse('package:freezed/freezed.dart'),
      'EqualUnmodifiableSetView',
    );

    final requiredPositional =
        fields.where((e) => e.isRequired && e.isPositional).toList();
    final optionalPositional =
        fields.where((e) => !e.isRequired && e.isPositional).toList();
    final named = fields.where((e) => e.isNamed).toList();

    List<Object> initializerForField(
      _FreezedField field,
    ) {
      if (!makeCollectionsUnmodifiable) return [field.name];

      if (field.type case final NamedTypeAnnotation type) {
        final result = <Object>[
          if (type.isNullable) '${field.name} == null ? null : ',
        ];

        if (type.identifier == list) {
          return result
            ..add(unmodifiableList)
            ..add('(${field.name})');
        } else if (type.identifier == map) {
          return result
            ..add(unmodifiableMap)
            ..add('(${field.name})');
        } else if (type.identifier == hashSet) {
          return result
            ..add(unmodifiableSet)
            ..add('(${field.name})');
        }
      }

      return [field.name];
    }

    Future<List<Object>> initializers() async {
      final result = <Object>[];

      for (final (index, field) in fields.indexed) {
        result
          ..add('${field.name} = ')
          ..addAll(initializerForField(field));

        if (index != fields.length - 1) result.add(',\n      ');
      }

      return result;
    }

    List<Object> parameters() {
      List<Object> partsForParam(_FreezedField param) {
        return [
          if (hasConstructor) ...[
            param.type.code,
            ' ',
          ] else if (param.isInherited)
            'super.'
          else
            'this.',
          param.name,
          ',',
        ];
      }

      return [
        for (final field in requiredPositional) ...[
          '\n    ',
          ...partsForParam(field),
        ],
        if (optionalPositional.isNotEmpty) ...[
          '[',
          for (final field in optionalPositional) ...[
            '\n    ',
            ...partsForParam(field),
          ],
          '\n  ]',
        ],
        if (named.isNotEmpty) ...[
          '{',
          for (final field in named) ...[
            '\n    ',
            if (field.isRequired) 'required ',
            ...partsForParam(field),
          ],
          '\n  }',
        ],
        if (fields.isNotEmpty && optionalPositional.isEmpty && named.isEmpty)
          '\n  ',
      ];
    }

    Future<List<Object>> superParts() async {
      if (targetSuperCtor == null) return [];

      return [
        'super',
        if (targetSuperCtor.identifier.name.isNotEmpty)
          '.${targetSuperCtor.identifier.name}',
        '()',
      ];
    }

    final constructorCode = DeclarationCode.fromParts([
      '  ',
      if (hasConstructor) 'augment ',
      clazz.identifier.name,
      if (constructor != null) '.$constructor',
      '(',
      ...parameters(),
      ')',
      if (targetSuperCtor != null || (hasConstructor && fields.isNotEmpty))
        ' : ',
      if (fields.isNotEmpty && hasConstructor) ...await initializers(),
      ...await superParts(),
      ';',
    ]);

    builder.declareInLibrary(constructorCode);
  }

  Future<void> _generateFields(
    List<_FreezedField> fields,
    MemberDeclarationBuilder builder,
    ClassDeclaration clazz,
  ) async {
    final fieldsCode = DeclarationCode.fromParts([
      for (final field in fields)
        if (field.needsDeclaration) ...[
          '\n  final ',
          field.type.code,
          ' ',
          field.name,
          ';',
        ],
    ]);

    builder.declareInLibrary(fieldsCode);
  }

  Future<void> _generateCopyWith(
    List<_FreezedField> fields,
    MemberDeclarationBuilder builder,
    ClassDeclaration clazz,
  ) async {
    if (fields.isEmpty) {
      return;
    }

    final copyWithPrototype = await builder.parts(
      args: {
        'Class': clazz.identifier,
        'CopyWithParameters': DeclarationCode.fromParts([
          for (final field in fields) ...[
            '\n    ',
            field.type.code,
            ' ${field.name},',
          ],
        ]),
      },
      '''
{{Class}} Function({{{CopyWithParameters}}
  })''',
    ).asDeclarationCode();

    final object =
        await builder.resolveIdentifier(Uri.parse('dart:core'), 'Object');
    final sentinel = await builder
        .parts(
          '{{package:freezed/freezed.dart#Sentinel}}',
        )
        .asDeclarationCode();

    if (clazz.hasSealed) {
      builder.declareInLibrary(
        DeclarationCode.fromParts([
          '  ',
          copyWithPrototype,
          ' get copyWith;',
        ]),
      );
      return;
    }

    builder.declareInLibrary(
      await builder.parts(args: {
        'CopyWithPrototype': copyWithPrototype,
        'CopyWithParameters': DeclarationCode.fromParts([
          for (final field in fields) ...[
            '\n      ',
            NullableTypeAnnotationCode(NamedTypeAnnotationCode(name: object)),
            ' ${field.name}',
            if (field.type.isNullable) ...[
              ' = const ',
              sentinel,
              '()',
            ],
            ',',
          ]
        ]),
        'Instance': DeclarationCode.fromParts([
          clazz.identifier,
          if (constructor != null) '.$constructor',
          '(',
          for (final field in fields) ...[
            '\n        ',
            if (field.isNamed) '${field.name}: ',
            '${field.name} == ',
            if (field.type.isNullable) ...[
              ' const ',
              sentinel,
              '()',
            ] else
              ' null',
            '\n          ? this.${field.name}\n          : ${field.name} as ',
            field.type.code,
            ',',
          ],
          '\n      )',
        ]),
      }, '''

  {{CopyWithPrototype}} get copyWith {
    return ({{{CopyWithParameters}}
    }) {
      return {{Instance}};
    };
  }''').asDeclarationCode(),
    );
  }
}
