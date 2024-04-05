final _upperCase = RegExp('[A-Z]');

extension StringX on String {
  String get kebabCase => _fixCase('-');

  String get snakeCase => _fixCase('_');

  String get screamingSnake => snakeCase.toUpperCase();

  String get pascalCase {
    if (isEmpty) return '';

    return this[0].toUpperCase() + substring(1);
  }

  String _fixCase(String separator) => replaceAllMapped(_upperCase, (match) {
        var lower = match.group(0)!.toLowerCase();

        if (match.start > 0) {
          lower = '$separator$lower';
        }

        return lower;
      });
}
