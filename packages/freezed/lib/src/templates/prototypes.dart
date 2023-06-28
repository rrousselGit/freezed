import 'package:analyzer/dart/element/element.dart';
import 'package:collection/collection.dart';
import 'package:freezed/src/freezed_generator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'parameter_template.dart';

typedef ParameterDefinition = (String, {String? defaultValue});

extension TypeHelpers on StringBuffer {
  void writeClassPrototype({
    String? extend,
    Iterable<String> implements = const [],
    Iterable<String> withs = const [],
  }) {
    if (extend != null) {
      write(' extends ');
      write(extend);
      write(' ');
    }

    if (implements.isNotEmpty) {
      write(' implements ');
      writeAll(implements, ', ');
      write(' ');
    }

    if (withs.isNotEmpty) {
      write(' with ');
      writeAll(withs, ', ');
      write(' ');
    }
  }

  void writeArguments({
    Iterable<ParameterDefinition> requiredPositionals = const [],
    Iterable<ParameterDefinition> optionalPositionals = const [],
    Iterable<ParameterDefinition> optionalNamed = const [],
    Iterable<ParameterDefinition> requiredNamed = const [],
  }) {
    write('(');

    void writeArguments(ParameterDefinition argument, {String? leading}) {
      if (leading != null) {
        write(leading);
        write(' ');
      }

      write(argument.$1);
      if (argument.defaultValue != null) {
        write(' = ');
        write(argument.defaultValue);
      }
      write(', ');
    }

    requiredPositionals.forEach(writeArguments);

    if (optionalPositionals.isNotEmpty) {
      write('[');
      optionalPositionals.forEach(writeArguments);
      write(']');
    }

    if (optionalNamed.isNotEmpty || requiredNamed.isNotEmpty) {
      write('{');
      optionalNamed.forEach(writeArguments);
      for (final argument in requiredNamed) {
        writeArguments(argument, leading: 'required');
      }
      write('}');
    }

    write(')');
  }

  void writeGenericDefinition(List<(String, {String? extend})> generics) {
    if (generics.isEmpty) return;

    write('<');
    writeAll(
      generics.map((e) {
        if (e.extend == null) return e.$1;
        return '${e.$1} extends ${e.extend}';
      }),
      ', ',
    );
    write('>');
  }

  void writeGenericUsage(Iterable<String> generics) {
    if (generics.isEmpty) return;

    write('<');
    writeAll(generics, ', ');
    write('>');
  }
}

String buildParamInvocationQuery(
  Map<ParameterElement, String> parameters, {
  bool asThisParameter = false,
}) {
  final buffer = StringBuffer()
    ..writeAll(
      parameters.entries.map((e) {
        if (e.key.isNamed) return '${e.key.name}: ${e.value}';
        return e.value;
      }).expand((e) => [e, ',']),
    );

  return buffer.toString();
}

List<String> parseDecorators(List<ElementAnnotation> metadata) {
  return [
    for (final meta in metadata)
      if (!meta.isRequired && !meta.isDefault) meta.toSource(),
  ];
}

String wrapClassField(String name) {
  return name.contains(r'$') ? '\${$name}' : '\$$name';
}

extension FreezedElementAnnotation on ElementAnnotation {
  /// if the element is decorated with `@Default(value)`
  bool get isDefault {
    return const TypeChecker.fromRuntime(Default)
        .isExactlyType(computeConstantValue()!.type!);
  }

  /// if the element is decorated with `@With<Type>`
  bool get isWith {
    return const TypeChecker.fromRuntime(With)
        .isExactlyType(computeConstantValue()!.type!);
  }

  /// if the element is decorated with `@Implements<Type>`
  bool get isImplements {
    return const TypeChecker.fromRuntime(Implements)
        .isExactlyType(computeConstantValue()!.type!);
  }
}

void whenPrototype(StringBuffer buffer, List<UnionCaseMeta> unionCases) {
  return _whenPrototype(
    buffer,
    unionCases,
    name: 'when',
    areCallbacksRequired: true,
    isReturnTypeNullable: false,
  );
}

void whenOrNullPrototype(
  StringBuffer buffer,
  List<UnionCaseMeta> allConstructors,
) {
  return _whenPrototype(
    buffer,
    allConstructors,
    areCallbacksRequired: false,
    isReturnTypeNullable: true,
    name: 'whenOrNull',
  );
}

void maybeWhenPrototype(
  StringBuffer buffer,
  List<UnionCaseMeta> allConstructors,
) {
  _whenPrototype(
    buffer,
    allConstructors,
    areCallbacksRequired: false,
    isReturnTypeNullable: false,
    name: 'maybeWhen',
  );
}

void mapPrototype(
  StringBuffer buffer,
  List<UnionCaseMeta> allConstructors,
  List<String> genericParameters,
) {
  return _mapPrototype(
    buffer,
    allConstructors,
    genericParameters,
    areCallbacksRequired: true,
    isReturnTypeNullable: false,
    name: 'map',
  );
}

void mapOrNullPrototype(
  StringBuffer buffer,
  List<UnionCaseMeta> allConstructors,
  List<String> genericParameters,
) {
  return _mapPrototype(
    buffer,
    allConstructors,
    genericParameters,
    areCallbacksRequired: false,
    isReturnTypeNullable: true,
    name: 'mapOrNull',
  );
}

void maybeMapPrototype(
  StringBuffer buffer,
  List<UnionCaseMeta> allConstructors,
  List<String> genericParameters,
) {
  _mapPrototype(
    buffer,
    allConstructors,
    genericParameters,
    areCallbacksRequired: false,
    isReturnTypeNullable: false,
    name: 'maybeMap',
  );
}

void _mapPrototype(
  StringBuffer buffer,
  List<UnionCaseMeta> allConstructors,
  List<String> generics, {
  required bool areCallbacksRequired,
  required bool isReturnTypeNullable,
  required String name,
}) {
  return _unionPrototype(
    buffer,
    allConstructors,
    areCallbacksRequired: areCallbacksRequired,
    isReturnTypeNullable: isReturnTypeNullable,
    name: name,
    writeParameter: (buffer, constructor) {
      buffer
        ..write('TResult Function(')
        ..write(constructor.redirectedName)
        ..writeGenericUsage(generics)
        ..write(' ')
        ..write(constructorNameToCallbackName(constructor.name))
        ..write(areCallbacksRequired ? ') ' : ')? ')
        ..write(constructorNameToCallbackName(constructor.name));
    },
  );
}

typedef UnionFieldMeta = ({
  bool isFinal,
  bool isOptional,
  bool isNamed,
  String leading,
  String name,
  String? defaultValueSource,
});

typedef UnionCaseMeta = ({
  String? name,
  String redirectedName,
  List<FreezedField> fields,
});

void _whenPrototype(
  StringBuffer buffer,
  List<UnionCaseMeta> allConstructors, {
  required bool areCallbacksRequired,
  required bool isReturnTypeNullable,
  required String name,
}) {
  _unionPrototype(
    buffer,
    allConstructors,
    areCallbacksRequired: areCallbacksRequired,
    isReturnTypeNullable: isReturnTypeNullable,
    name: name,
    writeParameter: (buffer, constructor) {
      buffer
        ..write('TResult Function(')
        ..writeAll(
          constructor.fields.map((e) => '${e.typeSource} ${e.name}'),
          ',',
        )
        ..write(areCallbacksRequired ? ') ' : ')? ')
        ..write(constructorNameToCallbackName(constructor.name));
    },
  );
}

void _unionPrototype(
  StringBuffer buffer,
  List<UnionCaseMeta> allConstructors, {
  required String name,
  required bool areCallbacksRequired,
  required bool isReturnTypeNullable,
  required void Function(StringBuffer buffer, UnionCaseMeta) writeParameter,
}) {
  final returnType = isReturnTypeNullable ? 'TResult?' : 'TResult';

  buffer.write(
    '@optionalTypeArgs $returnType $name<TResult extends Object?>(',
  );

  final defaultCase = allConstructors.firstWhereOrNull((e) => e.name == null);
  if (defaultCase != null) {
    writeParameter(buffer, defaultCase);
    buffer.write(', ');
  }

  var didWriteOpeningBracket = false;
  void maybeWriteOpeningBracket() {
    if (!didWriteOpeningBracket) {
      buffer.write('{');
      didWriteOpeningBracket = true;
    }
  }

  for (final constructor in allConstructors) {
    if (constructor.name == null) continue;

    maybeWriteOpeningBracket();

    if (areCallbacksRequired) buffer.write('required ');

    writeParameter(buffer, constructor);
    buffer.write(', ');
  }

  final hasOrElse = !areCallbacksRequired && !isReturnTypeNullable;
  if (hasOrElse) {
    maybeWriteOpeningBracket();
    buffer.write('required TResult Function() orElse,');
  }

  if (didWriteOpeningBracket) buffer.write('}');

  buffer.writeln(')');
}

bool isDefaultConstructor(ConstructorElement constructor) {
  return constructor.name.isEmpty;
}

String constructorNameToCallbackName(String? constructorName) {
  return constructorName == null ? r'$default' : constructorName;
}

String toJsonParameters(
  GenericsParameterTemplate parameters,
  bool genericArgumentFactories,
) {
  if (!genericArgumentFactories) {
    return '';
  }
  return '${parameters.typeParameters.map((t) => 'Object? Function($t) toJson$t').join(',')}';
}

String toJsonArguments(
  GenericsParameterTemplate parameters,
  bool genericArgumentFactories,
) {
  if (!genericArgumentFactories) {
    return '';
  }
  return '${parameters.typeParameters.map((t) => 'toJson$t').join(',')}';
}

String fromJsonParameters(
  GenericsParameterTemplate parameters,
  bool genericArgumentFactories,
) {
  if (!genericArgumentFactories) {
    return '';
  }
  return ',${parameters.typeParameters.map((t) => '$t Function(Object?) fromJson$t').join(',')}';
}

String fromJsonArguments(
  GenericsParameterTemplate parameters,
  bool genericArgumentFactories,
) {
  if (!genericArgumentFactories) {
    return '';
  }
  return ',${parameters.typeParameters.map((t) => 'fromJson$t').join(',')}';
}
