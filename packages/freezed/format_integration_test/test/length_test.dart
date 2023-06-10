import 'dart:io';
import 'package:test/test.dart';

void main() {
  test('format line length', () {
    final freezed = File('lib/equal.freezed.dart').readAsStringSync();
    expect(
        freezed,
        contains(
            r'factory $SimpleCopyWith(Simple value, $Res Function(Simple) then) = _$SimpleCopyWithImpl<$Res, Simple>;'));
  });
}
