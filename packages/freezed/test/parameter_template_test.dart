import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'integration/single_class_constructor.dart';

void main() {
  test('generated freezed code has no final keyword in constructor parameters', () {
    final pubspecDir = _findPubspecDir(p.current);

    final generatedFile = File(
      p.join(
        pubspecDir,
        'test',
        'integration',
        'single_class_constructor.freezed.dart',
      ),
    );

    final content = generatedFile.readAsStringSync();

    // Match constructor parameter patterns with 'final' keyword.
    // This regex finds patterns like 'final Type name' or 'final Type? name'
    // that appear inside constructor parameter lists.
    final finalParamRegex = RegExp(r'\(\s*final\s+\w+');

    final matches = finalParamRegex.allMatches(content).toList();

    expect(
      matches,
      isEmpty,
      reason:
          'Generated freezed code should not contain "final" keyword in constructor parameter lists. '
          'Found ${matches.length} occurrence(s): ${matches.map((m) => '"${m.group(0)}"').join(', ')}',
    );
  });

  test('unmodifiable list class compiles and works', () {
    final value = UnmodifiableListEqual([1, 2, 3]);
    expect(value.list, [1, 2, 3]);

    expect(() => value.list.add(4), throwsUnsupportedError);
  });

  test('unmodifiable set class compiles and works', () {
    final value = UnmodifiableSetEqual({1, 2, 3});
    expect(value.dartSet, {1, 2, 3});

    expect(() => value.dartSet.add(4), throwsUnsupportedError);
  });

  test('unmodifiable map class compiles and works', () {
    final value = UnmodifiableMapEqual({'a': 1, 'b': 2});
    expect(value.map, {'a': 1, 'b': 2});

    expect(() => value.map['c'] = 3, throwsUnsupportedError);
  });
}

String _findPubspecDir(String start) {
  var dir = Directory(start);
  while (true) {
    if (File(p.join(dir.path, 'pubspec.yaml')).existsSync()) {
      return dir.path;
    }
    final parent = dir.parent;
    if (parent.path == dir.path) break;
    dir = parent;
  }
  return start;
}
