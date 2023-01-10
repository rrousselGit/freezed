import 'package:analyzer/dart/element/element.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:source_gen/source_gen.dart';

import '../models.dart';
import 'parameter_template.dart';

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

String whenPrototype(List<ConstructorDetails> allConstructors) {
  return _whenPrototype(
    allConstructors,
    areCallbacksRequired: true,
    isReturnTypeNullable: false,
    name: 'when',
  );
}

String whenOrNullPrototype(List<ConstructorDetails> allConstructors) {
  return _whenPrototype(
    allConstructors,
    areCallbacksRequired: false,
    isReturnTypeNullable: true,
    name: 'whenOrNull',
  );
}

String maybeWhenPrototype(List<ConstructorDetails> allConstructors) {
  return _whenPrototype(
    allConstructors,
    areCallbacksRequired: false,
    isReturnTypeNullable: false,
    name: 'maybeWhen',
  );
}

String mapPrototype(
  List<ConstructorDetails> allConstructors,
  GenericsParameterTemplate genericParameters,
) {
  return _mapPrototype(
    allConstructors,
    genericParameters,
    areCallbacksRequired: true,
    isReturnTypeNullable: false,
    name: 'map',
  );
}

String mapOrNullPrototype(
  List<ConstructorDetails> allConstructors,
  GenericsParameterTemplate genericParameters,
) {
  return _mapPrototype(
    allConstructors,
    genericParameters,
    areCallbacksRequired: false,
    isReturnTypeNullable: true,
    name: 'mapOrNull',
  );
}

String maybeMapPrototype(
  List<ConstructorDetails> allConstructors,
  GenericsParameterTemplate genericParameters,
) {
  return _mapPrototype(
    allConstructors,
    genericParameters,
    areCallbacksRequired: false,
    isReturnTypeNullable: false,
    name: 'maybeMap',
  );
}

String _mapPrototype(
  List<ConstructorDetails> allConstructors,
  GenericsParameterTemplate genericParameters, {
  required bool areCallbacksRequired,
  required bool isReturnTypeNullable,
  required String name,
}) {
  return _unionPrototype(
    allConstructors,
    areCallbacksRequired: areCallbacksRequired,
    isReturnTypeNullable: isReturnTypeNullable,
    name: name,
    ctor2parameters: (constructor) {
      return ParametersTemplate([
        Parameter(
          name: 'value',
          type: '${constructor.redirectedName}$genericParameters',
          isRequired: false,
          isNullable: false,
          isFinal: false,
          isDartList: false,
          isDartSet: false,
          isDartMap: false,
          decorators: const [],
          defaultValueSource: '',
          doc: '',
          // TODO: do we want to support freezed classes that implements MapView/ListView?
          isPossiblyDartCollection: false,
          showDefaultValue: false,
          parameterElement: null,
        ),
      ]);
    },
  );
}

String _whenPrototype(
  List<ConstructorDetails> allConstructors, {
  required bool areCallbacksRequired,
  required bool isReturnTypeNullable,
  required String name,
}) {
  return _unionPrototype(
    allConstructors,
    areCallbacksRequired: areCallbacksRequired,
    isReturnTypeNullable: isReturnTypeNullable,
    name: name,
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
}

String _unionPrototype(
  List<ConstructorDetails> allConstructors, {
  required bool areCallbacksRequired,
  required bool isReturnTypeNullable,
  required String name,
  required ParametersTemplate Function(ConstructorDetails) ctor2parameters,
}) {
  final returnType = isReturnTypeNullable ? 'TResult?' : 'TResult';

  final buffer = StringBuffer(
      '@optionalTypeArgs $returnType $name<TResult extends Object?>(');

  final parameters = <CallbackParameter>[];
  for (final constructor in allConstructors) {
    var template = CallbackParameter(
      name: constructorNameToCallbackName(constructor.name),
      type: returnType,
      isFinal: false,
      isDartList: false,
      isDartMap: false,
      isDartSet: false,
      isRequired: !constructor.isDefault && areCallbacksRequired,
      isNullable: !areCallbacksRequired,
      parameters: ctor2parameters(constructor),
      decorators: const [],
      defaultValueSource: '',
      doc: '',
      isPossiblyDartCollection: false,
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

bool isDefaultConstructor(ConstructorElement constructor) {
  return constructor.name.isEmpty;
}

String constructorNameToCallbackName(String constructorName) {
  return constructorName.isEmpty ? '\$default' : constructorName;
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
