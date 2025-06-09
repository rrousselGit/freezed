import 'dart:convert';

import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:freezed/builder.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

void main() {
  test('defaultFormatOutput formats code correctly', () {
    const unformattedCode = '''
class Test{
int value;
Test(this.value);
}
''';

    final formattedCode = defaultFormatOutput(
      unformattedCode,
      Version(3, 0, 0),
    );

    expect(formattedCode, contains('class Test {'));
    expect(formattedCode, contains('  int value;'));
    expect(formattedCode, contains('  Test(this.value);'));
    expect(formattedCode, isNot(contains('// dart format width=')));
  });

  test('generated file does not contain default source_gen header', () async {
    const testInput = '''
import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_input.freezed.dart';

@freezed
class TestClass with _\$TestClass {
  const factory TestClass({required int value}) = _TestClass;
}
''';

    final writer = InMemoryAssetWriter();
    await testBuilder(
      freezed(const BuilderOptions({})),
      {
        'test_package|lib/test_input.dart': testInput,
      },
      reader: await PackageAssetReader.currentIsolate(),
      writer: writer,
    );

    final output =
        writer.assets[AssetId('test_package', 'lib/test_input.freezed.dart')];
    expect(output, isNotNull);

    final content = utf8.decode(output!);

    expect(content, isNot(contains('// dart format width=')));

    expect(content, contains('// coverage:ignore-file'));
    expect(content, contains('// GENERATED CODE - DO NOT MODIFY BY HAND'));
    expect(content, contains('// ignore_for_file: type=lint'));
  });

  test('generated file has correct structure and formatting', () async {
    const testInput = '''
import 'package:freezed_annotation/freezed_annotation.dart';

part 'simple_class.freezed.dart';

@freezed
class SimpleClass with _\$SimpleClass {
  const factory SimpleClass({
    required String name,
    required int age,
  }) = _SimpleClass;
}
''';

    final writer = InMemoryAssetWriter();
    await testBuilder(
      freezed(const BuilderOptions({'format': true})),
      {
        'test_package|lib/simple_class.dart': testInput,
      },
      reader: await PackageAssetReader.currentIsolate(),
      writer: writer,
    );

    final output =
        writer.assets[AssetId('test_package', 'lib/simple_class.freezed.dart')];
    expect(output, isNotNull);

    final content = utf8.decode(output!);

    expect(content, isNot(contains('// dart format')));

    expect(content, contains('// coverage:ignore-file'));
    expect(content, contains('// GENERATED CODE - DO NOT MODIFY BY HAND'));
    expect(content, contains('// ignore_for_file: type=lint'));

    expect(content, contains('mixin _\$SimpleClass {'));
    expect(content, contains('  String get name;'));
    expect(content, contains('  int get age;'));
  });
}
