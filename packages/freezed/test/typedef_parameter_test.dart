import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
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

    var firstTypedefType = constructor.parameters.first.type;
    expect(firstTypedefType, isA<FunctionType>());
    expect(firstTypedefType.alias!.element.name, equals('MyTypedef'));

    var secondTypedefType = constructor.parameters[1].type;
    expect(secondTypedefType, isA<FunctionType>());
    expect(secondTypedefType.alias!.element.name, equals('ExternalTypedef'));
  });
}
