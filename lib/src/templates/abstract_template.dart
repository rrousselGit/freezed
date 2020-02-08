import 'package:analyzer/dart/element/element.dart';
import 'package:immutable/src/templates/prototypes.dart';
import 'package:meta/meta.dart';

class Abstract {
  Abstract({
    @required this.name,
    @required this.interface,
    @required this.properties,
    @required this.allConstructors,
  });

  final String name;
  final String interface;
  final List<Getter> properties;
  final List<ConstructorElement> allConstructors;

  @override
  String toString() {
    return '''
abstract class $name {
${properties.join()}

$copyWithPrototype

$when
}
''';
  }

  String get copyWithPrototype {
    if (properties.isEmpty) return '';
    final parameters = properties.map((p) {
      return '${p.type} ${p.name}';
    }).join(',');

    return '''
$interface copyWith({
$parameters
});
''';
  }

  String get when {
    if (allConstructors.length < 2) return '';
    return '${whenPrototype(allConstructors, areCallbacksRequired: true)};';
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
