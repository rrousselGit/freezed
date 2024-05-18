import 'package:macros/macros.dart';

extension PartUtils on TypePhaseIntrospector {
  /// Resolves top-level identifier references of form `{{uri@name}}`.
  Future<List<Object>> parts(
    String withIdentifiers, {
    Map<String, Object> args = const {},
  }) async {
    final result = <Object>[];
    var lastMatchEnd = 0;

    void addStringPart(int end) {
      final str = withIdentifiers.substring(lastMatchEnd, end);
      result.add(str);
    }

    final pattern = RegExp(r'\{\{([^}]+?#)?(\w+?)\}\}');
    for (final match in pattern.allMatches(withIdentifiers)) {
      addStringPart(match.start);

      if (match.group(1) == null && args.containsKey(match.group(2))) {
        result.add(args[match.group(2)!]!);
      } else {
        var uri = match.group(1);
        uri = uri == null ? 'dart:core' : uri.substring(0, uri.length - 1);

        // ignore: deprecated_member_use
        final identifier = await resolveIdentifier(
          Uri.parse(uri),
          match.group(2)!,
        );
        result.add(identifier);
      }
      lastMatchEnd = match.end;
    }

    addStringPart(withIdentifiers.length);

    return result;
  }
}

extension PartsAs on Future<List<Object>> {
  Future<DeclarationCode> asDeclarationCode() async {
    final parts = await this;
    return DeclarationCode.fromParts(parts);
  }
}
