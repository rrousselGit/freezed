extension StringUtils on String {
  bool get isPublic => !startsWith('_');

  String get public {
    if (startsWith('_')) return substring(1);
    return this;
  }

  String get generated => '_\$$public';

  String get titled {
    return replaceFirstMapped(
      RegExp('[a-zA-Z]'),
      (match) => match.group(0)!.toLowerCase(),
    );
  }
}
