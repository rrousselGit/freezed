import 'package:immutable/parameter_template.dart';

class Abstract {
  Abstract(
    this.name,
    this.properties,
  );

  final String name;
  final List<Getter> properties;

  @override
  String toString() {
    return '''
abstract class $name {
${properties.join()}
}
''';
  }
}

class Getter {
  final String type;
  final String name;

  Getter({this.type, this.name});

  @override
  String toString() {
    return '${type ?? 'dynamic'} get $name;';
  }
}
