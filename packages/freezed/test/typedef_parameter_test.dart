import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

void main() {
  test('has no issue', () async {
    final main = await resolveSources(
      {
        'freezed|test/integration/typedef_parameter.dart': useAssetReader,
      },
      (r) => r.libraries.firstWhere(
          (element) => element.source.toString().contains('typedef_parameter')),
    );

    final errorResult = await main.session.getErrors(
            '/freezed/test/integration/typedef_parameter_test.freezed.dart')
        as ErrorsResult;

    expect(errorResult.errors, isEmpty);
  });

  test('generates correct typedefs', () async {
    final main = await resolveSources(
      {
        'freezed|test/integration/typedef_parameter.dart': useAssetReader,
      },
      (r) => r.libraries.firstWhere(
          (element) => element.source.toString().contains('typedef_parameter')),
    );

    var freezedClass = main.topLevelElements
        .whereType<ClassElement>()
        .firstWhere((element) => element.name == '_ClassWithTypedef');

    var constructor =
        freezedClass.constructors.firstWhere((element) => element.name == '');

    var a = constructor.parameters.first.type;
    expect(a, isA<FunctionType>());
    expect(a.alias!.element.name, equals('MyTypedef'));

    var b = constructor.parameters[1].type;
    expect(b, isA<FunctionType>());
    expect(b.alias!.element.name, equals('MyTypedef'));
    expect(b.nullabilitySuffix, equals(NullabilitySuffix.question));

    var c = constructor.parameters[2].type;
    expect(c, isA<FunctionType>());
    expect(c.alias!.element.name, equals('ExternalTypedef'));

    var d = constructor.parameters[3].type;
    expect(d, isA<FunctionType>());
    expect(d.alias!.element.name, equals('ExternalTypedefTwo'));

    var e = constructor.parameters[4].type;
    expect(e, isA<FunctionType>());
    expect(e.alias!.element.name, equals('GenericTypedef'));
    expect(e.alias!.typeArguments.toString(), equals('[int, bool]'));
  });
}
