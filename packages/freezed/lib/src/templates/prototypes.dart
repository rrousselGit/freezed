import 'package:analyzer/dart/element/element.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

import '../models.dart';
import 'parameter_template.dart';

final _redirectedConstructorNameRegexp =
    RegExp(r'^[^;{}]+?=[\s\n\t]*([^<>(){}]+?)(?:<.+?>)*?;', dotAll: true);

List<String> parseDecorators(List<ElementAnnotation> metadata) {
  return [
    for (final meta in metadata)
      if (!meta.isRequired && !meta.isDefault) meta.toSource(),
  ];
}

extension FreezedElementAnnotation on ElementAnnotation {
  /// if the element is decorated with `@Default(value)`
  bool get isDefault {
    return const TypeChecker.fromRuntime(Default)
        .isExactlyType(computeConstantValue().type);
  }

  /// if the element is decorated with `@With(Type)` or
  /// `@With.fromString('Type')`
  bool get isWith {
    return const TypeChecker.fromRuntime(With)
        .isExactlyType(computeConstantValue().type);
  }

  /// if the element is decorated with `@Implements(Type)` or
  /// `@Implements.fromString('Type')`
  bool get isImplements {
    return const TypeChecker.fromRuntime(Implements)
        .isExactlyType(computeConstantValue().type);
  }
}

String whenPrototype(List<ConstructorDetails> allConstructors) {
  return _whenPrototype(allConstructors,
      areCallbacksRequired: true, name: 'when');
}

String maybeWhenPrototype(List<ConstructorDetails> allConstructors) {
  return _whenPrototype(allConstructors,
      areCallbacksRequired: false, name: 'maybeWhen');
}

String mapPrototype(List<ConstructorDetails> allConstructors,
    GenericsParameterTemplate genericParameters) {
  return _mapPrototype(allConstructors, genericParameters,
      areCallbacksRequired: true, name: 'map');
}

String maybeMapPrototype(List<ConstructorDetails> allConstructors,
    GenericsParameterTemplate genericParameters) {
  return _mapPrototype(allConstructors, genericParameters,
      areCallbacksRequired: false, name: 'maybeMap');
}

String _mapPrototype(
  List<ConstructorDetails> allConstructors,
  GenericsParameterTemplate genericParameters, {
  @required bool areCallbacksRequired,
  @required String name,
}) {
  return _unionPrototype(
    allConstructors,
    areCallbacksRequired: areCallbacksRequired,
    name: name,
    ctor2parameters: (constructor) {
      return ParametersTemplate([
        Parameter(
          name: 'value',
          type: '${constructor.redirectedName}$genericParameters',
          isRequired: false,
          decorators: const [],
          nullable: false,
          defaultValueSource: '',
          doc: '',
        ),
      ]);
    },
  );
}

String _whenPrototype(
  List<ConstructorDetails> allConstructors, {
  @required bool areCallbacksRequired,
  @required String name,
}) {
  return _unionPrototype(
    allConstructors,
    areCallbacksRequired: areCallbacksRequired,
    name: name,
    ctor2parameters: (constructor) {
      return ParametersTemplate([
        ...constructor.parameters.requiredPositionalParameters,
        ...constructor.parameters.optionalPositionalParameters,
        ...constructor.parameters.namedParameters
            .map((e) => e.copyWith(isRequired: false)),
      ]);
    },
  );
}

String _unionPrototype(
  List<ConstructorDetails> allConstructors, {
  @required bool areCallbacksRequired,
  @required String name,
  @required ParametersTemplate Function(ConstructorDetails) ctor2parameters,
}) {
  final buffer =
      StringBuffer('@optionalTypeArgs TResult $name<TResult extends Object>(');

  final parameters = <CallbackParameter>[];
  for (final constructor in allConstructors) {
    var template = CallbackParameter(
      name: constructorNameToCallbackName(constructor.name),
      type: 'TResult',
      isRequired: !constructor.isDefault && areCallbacksRequired,
      parameters: ctor2parameters(constructor),
      decorators: const [],
      nullable: false,
      defaultValueSource: '',
      doc: '',
    );

    if (constructor.isDefault) {
      buffer..write(template)..write(',');
    } else {
      parameters.add(template);
    }
  }

  buffer
    ..write('{')
    ..writeAll(parameters, ',')
    ..write(',');

  if (!areCallbacksRequired) {
    buffer.write('@required TResult orElse(),');
  }
  buffer.write('})');
  return buffer.toString();
}

bool isDefaultConstructor(ConstructorElement constructor) {
  return constructor.name == null || constructor.name.isEmpty;
}

String constructorNameToCallbackName(String constructorName) {
  return constructorName == null || constructorName.isEmpty
      ? '\$default'
      : constructorName;
}
