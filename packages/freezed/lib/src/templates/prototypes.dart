import 'package:analyzer/dart/element/element.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:source_gen/source_gen.dart';

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
    return const TypeChecker.fromRuntime(
      Default,
    ).isExactlyType(computeConstantValue()!.type!);
  }

  /// if the element is decorated with `@With<Type>`
  bool get isWith {
    return const TypeChecker.fromRuntime(
      With,
    ).isExactlyType(computeConstantValue()!.type!);
  }

  /// if the element is decorated with `@Implements<Type>`
  bool get isImplements {
    return const TypeChecker.fromRuntime(
      Implements,
    ).isExactlyType(computeConstantValue()!.type!);
  }
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
