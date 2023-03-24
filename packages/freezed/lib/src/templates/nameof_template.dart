import 'package:freezed/src/models.dart';

import 'properties.dart';

class NameOf {
  NameOf({
    required this.data,
    required this.commonProperties,
  });

  final Data data;
  final List<Property> commonProperties;

  @override
  String toString() {
    final properties = commonProperties
        .map((e) => 'String get ${e.name} => "${e.name}";')
        .join();

    return '''
/// @nodoc
class $className {
$properties
}
''';
  }

  String get className {
    return '_\$${data.name}NameOf';
  }
}
