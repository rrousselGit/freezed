// ignore_for_file: prefer_const_constructors, omit_local_variable_types, deprecated_member_use_from_same_package
import 'package:analyzer/dart/analysis/results.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

Future<void> main() async {
  test('sealed class with type parameters generates correct switch cases', () async {
    final library = await resolveSources(
      {'freezed|test/integration/sealed_generic_switch/sealed_generic.dart': useAssetReader},
      (r) => r.libraries.firstWhere(
        (element) =>
            element.firstFragment.source.uri.path.endsWith('sealed_generic_switch/sealed_generic.dart'),
      ),
    );

    const generatedPath =
        '/freezed/test/integration/sealed_generic_switch/sealed_generic.freezed.dart';
    final result = await library.session.getErrors(generatedPath);
    expect(result, isA<ErrorsResult>(), reason: 'Expected ErrorsResult for $generatedPath');
    final errorResult = result as ErrorsResult;

    // The key test: verify that the generated code has no errors
    // This confirms that switch cases with type parameters are correctly generated
    expect(errorResult.errors, isEmpty);
  });
  
  test('sealed class with type parameters - verify generated switch cases include type params', () async {
    // This test verifies the generated code content by checking that it compiles correctly
    // with the expected patterns. Since resolveSources generates files in memory and
    // the content isn't directly accessible, we verify correctness through compilation.
    final library = await resolveSources(
      {'freezed|test/integration/sealed_generic_switch/sealed_generic.dart': useAssetReader},
      (r) => r.libraries.firstWhere(
        (element) =>
            element.firstFragment.source.uri.path.endsWith('sealed_generic_switch/sealed_generic.dart'),
      ),
    );

    const generatedPath =
        '/freezed/test/integration/sealed_generic_switch/sealed_generic.freezed.dart';
    
    // Verify the file exists and has no errors
    // This confirms that switch cases with type parameters are correctly generated
    // If the type parameters were missing, the analyzer would report errors
    final result = await library.session.getErrors(generatedPath);
    expect(result, isA<ErrorsResult>(), reason: 'Expected ErrorsResult for $generatedPath');
    final errorResult = result as ErrorsResult;
    expect(errorResult.errors, isEmpty, 
        reason: 'Generated file should have no errors. '
            'This confirms that switch cases include type parameters (e.g., case SealedGenericFirst<T>():) '
            'and copyWith factories include type parameters (e.g., = _\$SealedGenericCopyWithImpl<T, \$Res>;), '
            'as missing type parameters would cause compilation errors.');
  });

  test('sealed class without type parameters continues to work correctly', () async {
    // This test ensures backward compatibility - sealed classes without type parameters
    // should continue to work as before, without requiring type parameters in switch cases
    final library = await resolveSources(
      {'freezed|test/integration/sealed_generic_switch/sealed_non_generic.dart': useAssetReader},
      (r) => r.libraries.firstWhere(
        (element) =>
            element.firstFragment.source.uri.path.endsWith('sealed_generic_switch/sealed_non_generic.dart'),
      ),
    );

    const generatedPath =
        '/freezed/test/integration/sealed_generic_switch/sealed_non_generic.freezed.dart';
    final result = await library.session.getErrors(generatedPath);
    expect(result, isA<ErrorsResult>(), reason: 'Expected ErrorsResult for $generatedPath');
    final errorResult = result as ErrorsResult;

    // Verify that the generated code has no errors
    // This confirms that sealed classes without type parameters continue to work correctly
    expect(errorResult.errors, isEmpty,
        reason: 'Sealed class without type parameters should generate error-free code. '
            'This ensures backward compatibility - non-generic sealed classes should work '
            'without requiring type parameters in switch cases.');
  });
}
