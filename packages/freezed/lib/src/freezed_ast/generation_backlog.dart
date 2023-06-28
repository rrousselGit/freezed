import 'package:analyzer/dart/ast/ast.dart';
import 'package:freezed/src/freezed_generator.dart' show FreezedField;
import 'package:freezed/src/templates/prototypes.dart';

sealed class GeneratorBacklog {
  void run(StringBuffer buffer);
}

class UserDefinedClassMixin implements GeneratorBacklog {
  UserDefinedClassMixin({
    required this.typeParameters,
    required this.annotatedClassName,
    required this.mixinName,
    required this.fields,
  });

  final TypeParameterList? typeParameters;
  final String annotatedClassName;
  final String mixinName;
  final List<FreezedField> fields;

  @override
  void run(StringBuffer buffer) {
    // TODO common properties
    // TODO add when
    // TODO add map
    // TODO add toJson
    // TODO add copyWith

    buffer.write('''
/// The mixin for [$annotatedClassName].
mixin $mixinName${typeParameters ?? ''} {
''');

    _writeProperties(buffer);

    buffer.writeln('}');
  }

  void _writeProperties(StringBuffer buffer) {
    for (final parameter in fields) {
      buffer.writeln(
        '  ${parameter.typeSource} get ${parameter.name} => throw UnimplementedError();',
      );
    }
  }
}

class GeneratedFreezedClass implements GeneratorBacklog {
  GeneratedFreezedClass({
    required this.typeParameters,
    required this.hasConstConstructor,
    required this.name,
    required this.mixins,
    required this.implementList,
    required this.extendClause,
    required this.fields,
  });

  final bool hasConstConstructor;
  final String name;
  final TypeParameterList? typeParameters;
  final List<String> mixins;
  final List<String> implementList;
  final String? extendClause;
  final List<FreezedField> fields;

  @override
  void run(StringBuffer buffer) {
    // TODO common properties
    // TODO add when
    // TODO add map
    // TODO add toJson
    // TODO add copyWith

    _writeDocs(buffer);
    _writeClassPrototype(buffer);
    _writeProperties(buffer);

    buffer.writeln('}');
  }

  void _writeClassPrototype(StringBuffer buffer) {
    buffer.write('class $name ');

    if (typeParameters != null) buffer.write(typeParameters);

    buffer.writeClassPrototype(
      extend: extendClause,
      implements: implementList,
      withs: mixins,
    );

    buffer.writeln(' {');

    _writeConstructor(buffer);
  }

  void _writeConstructor(StringBuffer buffer) {
    buffer.write('  ');
    if (hasConstConstructor) {
      buffer.writeln('const ');
    }

    buffer
      ..write(name)
      ..writeArguments(
        optionalNamed: fields
            .where((e) => e.isOptional && e.isNamed)
            // TODO default value
            .map((e) => ('this.${e.name}', defaultValue: null)),
        requiredNamed: fields
            .where((e) => e.isRequired && e.isNamed)
            .map((e) => ('this.${e.name}', defaultValue: null)),
        optionalPositionals: fields
            .where((e) => e.isOptional && e.isPositional)
            .map((e) => ('this.${e.name}', defaultValue: null)),
        requiredPositionals: fields
            .where((e) => e.isRequired && e.isPositional)
            .map((e) => ('this.${e.name}', defaultValue: null)),
      )
      ..writeln(';');
  }

  void _writeProperties(StringBuffer buffer) {
    for (final parameter in fields) {
      buffer.writeln('  final ${parameter.typeSource} ${parameter.name};');
    }
  }

  void _writeDocs(StringBuffer buffer) {
    // TODO
  }
}
