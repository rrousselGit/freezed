import 'package:meta/meta.dart';

class Abstract {
  Abstract({
    @required this.name,
    @required this.interface,
    @required this.properties,
  });

  final String name;
  final String interface;
  final List<Getter> properties;

  @override
  String toString() {
    return '''
abstract class $name {
${properties.join()}

$copyWithPrototype
}
''';
  }

  String get copyWithPrototype {
    final parameters = properties.map((p) {
      return '${p.type} ${p.name}';
    }).join(',');

    return '''
$interface copyWith({
$parameters
});
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
