import 'package:analyzer/dart/element/type_provider.dart';
import 'package:freezed/src/models.dart';
import 'package:freezed/src/templates/parameter_template.dart';
import 'package:freezed/src/templates/prototypes.dart';

String patterns(Class data) {
  final typeProvider = data.library.typeProvider;
  final buffer = StringBuffer()
    ..write(_maybeMap(data, typeProvider: typeProvider))
    ..write(_map(data, typeProvider: typeProvider))
    ..write(_mapOrNull(data, typeProvider: typeProvider))
    ..write(_maybeWhen(data, typeProvider: typeProvider))
    ..write(_when(data, typeProvider: typeProvider))
    ..write(_whenOrNull(data, typeProvider: typeProvider));

  if (buffer.isNotEmpty) {
    return '''
/// Adds pattern-matching-related methods to [${data.name}].
extension ${data.name}Patterns${data.genericsDefinitionTemplate} on ${data.name}${data.genericsParameterTemplate} {
$buffer
}
''';
  }

  return '';
}

String _maybeMap(
  Class data, {
  required TypeProvider typeProvider,
}) {
  if (!data.options.map.maybeMap) return '';

  return _mapImpl(
    data,
    doc: '''
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```
''',
    areCallbacksRequired: false,
    isReturnTypeNullable: false,
    name: 'maybeMap',
    typeProvider: typeProvider,
  );
}

String _map(
  Class data, {
  required TypeProvider typeProvider,
}) {
  if (!data.options.map.map) return '';

  return _mapImpl(
    data,
    doc: '''
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```
''',
    areCallbacksRequired: true,
    isReturnTypeNullable: false,
    name: 'map',
    typeProvider: typeProvider,
  );
}

String _mapOrNull(
  Class data, {
  required TypeProvider typeProvider,
}) {
  if (!data.options.map.mapOrNull) return '';

  return _mapImpl(
    data,
    doc: '''
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```
''',
    areCallbacksRequired: false,
    isReturnTypeNullable: true,
    name: 'mapOrNull',
    typeProvider: typeProvider,
  );
}

String _maybeWhen(
  Class data, {
  required TypeProvider typeProvider,
}) {
  if (!data.options.when.maybeWhen) return '';

  return _whenImpl(
    data,
    doc: '''
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```
''',
    areCallbacksRequired: false,
    isReturnTypeNullable: false,
    name: 'maybeWhen',
    typeProvider: typeProvider,
  );
}

String _when(
  Class data, {
  required TypeProvider typeProvider,
}) {
  if (!data.options.when.when) return '';

  return _whenImpl(
    data,
    doc: '''
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```
''',
    areCallbacksRequired: true,
    isReturnTypeNullable: false,
    name: 'when',
    typeProvider: typeProvider,
  );
}

String _whenOrNull(
  Class data, {
  required TypeProvider typeProvider,
}) {
  if (!data.options.when.whenOrNull) return '';

  return _whenImpl(
    data,
    doc: '''
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```
''',
    areCallbacksRequired: false,
    isReturnTypeNullable: true,
    name: 'whenOrNull',
    typeProvider: typeProvider,
  );
}

String _mapImpl(
  Class data, {
  required bool areCallbacksRequired,
  required bool isReturnTypeNullable,
  required String name,
  required String doc,
  required TypeProvider typeProvider,
}) {
  final proto = _unionPrototype(
    data.constructors,
    areCallbacksRequired: areCallbacksRequired,
    isReturnTypeNullable: isReturnTypeNullable,
    name: name,
    doc: doc,
    typeProvider: typeProvider,
    ctor2parameters: (constructor) {
      return ParametersTemplate([
        Parameter(
          name: 'value',
          type: typeProvider.objectType,
          typeDisplayString:
              '${constructor.redirectedName}${data.genericsParameterTemplate}',
          isRequired: false,
          isFinal: false,
          decorators: const [],
          defaultValueSource: '',
          doc: '',
          showDefaultValue: false,
          parameterElement: null,
        ),
      ]);
    },
  );

  final buffer = StringBuffer(proto)
    ..writeln('{')
    ..writeln('final _that = this;')
    ..writeln('switch (_that) {');
  for (final constructor in data.constructors) {
    buffer.write('case ${constructor.redirectedName}()');
    if (!areCallbacksRequired) {
      buffer.write(' when ${constructor.callbackName} != null');
    }
    buffer
      ..writeln(':')
      ..write('return ${constructor.callbackName}(_that);');
  }

  if (isReturnTypeNullable) {
    buffer.writeln('''
case _:
  return null;
''');
  } else if (!areCallbacksRequired) {
    buffer.writeln('''
case _:
  return orElse();
''');
  } else if (!data.isSealed) {
    buffer.writeln('''
case _:
  throw StateError('Unexpected subclass');
''');
  }

  buffer
    ..writeln('}')
    ..writeln('}');

  return buffer.toString();
}

String _whenImpl(
  Class data, {
  required bool areCallbacksRequired,
  required bool isReturnTypeNullable,
  required String name,
  required String doc,
  required TypeProvider typeProvider,
}) {
  final proto = _unionPrototype(
    data.constructors,
    doc: doc,
    areCallbacksRequired: areCallbacksRequired,
    isReturnTypeNullable: isReturnTypeNullable,
    name: name,
    typeProvider: typeProvider,
    ctor2parameters: (constructor) {
      return ParametersTemplate([
        ...constructor.parameters.requiredPositionalParameters
            .map((e) => e.copyWith(isFinal: false)),
        ...constructor.parameters.optionalPositionalParameters
            .map((e) => e.copyWith(
                  isFinal: false,
                  showDefaultValue: false,
                )),
        ...constructor.parameters.namedParameters.map((e) => e.copyWith(
              isRequired: false,
              isFinal: false,
              showDefaultValue: false,
            )),
      ]);
    },
  );

  final buffer = StringBuffer('$proto {')
    ..writeln('final _that = this;')
    ..writeln('switch (_that) {');

  for (final constructor in data.constructors) {
    buffer.write('case ${constructor.redirectedName}()');
    if (!areCallbacksRequired) {
      buffer.write(' when ${constructor.callbackName} != null');
    }

    final callbackParameters =
        constructor.properties.map((e) => '_that.${e.name}').join(',');

    buffer
      ..writeln(':')
      ..write('return ${constructor.callbackName}($callbackParameters);');
  }

  if (isReturnTypeNullable) {
    buffer.writeln('''
case _:
  return null;
''');
  } else if (!areCallbacksRequired) {
    buffer.writeln('''
case _:
  return orElse();
''');
  } else if (!data.isSealed) {
    buffer.writeln('''
case _:
  throw StateError('Unexpected subclass');
''');
  }

  buffer
    ..writeln('}')
    ..writeln('}');

  return buffer.toString();
}

String _unionPrototype(
  List<ConstructorDetails> allConstructors, {
  required bool areCallbacksRequired,
  required bool isReturnTypeNullable,
  required String name,
  required String doc,
  required ParametersTemplate Function(ConstructorDetails) ctor2parameters,
  required TypeProvider typeProvider,
}) {
  final returnType = isReturnTypeNullable ? 'TResult?' : 'TResult';

  final buffer = StringBuffer(
    '$doc\n@optionalTypeArgs $returnType $name<TResult extends Object?>(',
  );

  final parameters = <CallbackParameter>[];
  for (final constructor in allConstructors) {
    var template = CallbackParameter(
      name: constructorNameToCallbackName(constructor.name),
      type: areCallbacksRequired
          ? typeProvider.objectType
          : typeProvider.nullType,
      typeDisplayString: returnType,
      isFinal: false,
      isRequired: !constructor.isDefault && areCallbacksRequired,
      parameters: ctor2parameters(constructor),
      decorators: const [],
      defaultValueSource: '',
      doc: '',
      parameterElement: null,
    );

    if (constructor.isDefault) {
      buffer
        ..write(template)
        ..write(',');
    } else {
      parameters.add(template);
    }
  }

  final hasOrElse = !areCallbacksRequired && !isReturnTypeNullable;

  if (parameters.isNotEmpty || hasOrElse) {
    buffer.write('{');
    if (parameters.isNotEmpty) {
      buffer
        ..writeAll(parameters, ',')
        ..write(',');
    }

    if (hasOrElse) {
      buffer.write('required $returnType orElse(),');
    }

    buffer.write('}');
  }
  buffer.write(')');
  return buffer.toString();
}
