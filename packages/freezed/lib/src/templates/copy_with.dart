import 'package:freezed/src/templates/concrete_template.dart';
import 'package:freezed/src/templates/parameter_template.dart';
import 'package:meta/meta.dart';

class CopyWith {
  CopyWith({
    @required this.clonedClassName,
    @required this.genericsDefinition,
    @required this.genericsParameter,
    @required this.clonneableProperty,
    this.superClass,
  });

  static String interfaceNameFrom(String name) => '\$${name}CopyWith';

  final String clonedClassName;
  final GenericsDefinitionTemplate genericsDefinition;
  final GenericsParameterTemplate genericsParameter;
  final List<Property> clonneableProperty;
  final String superClass;

  String get interface {
    var implements = superClass == null ? '' : 'implements $superClass$genericsParameter';
    return '''
abstract class $_copyWithInterface$genericsDefinition $implements {
${_copyWithPrototype('call')}
}''';
  }

  String _copyWithPrototype(String methodName) {
    if (clonneableProperty.isEmpty) return '';
    final parameters = clonneableProperty.map((p) {
      return '${p.decorators.join()} ${p.type} ${p.name}';
    }).join(',');

    return _maybeOverride('''
$clonedClassName$genericsParameter $methodName({
$parameters
});
''');
  }

  String get abstractMethod {
    if (clonneableProperty.isEmpty) return '';
    return _maybeOverride(
        '$_copyWithInterface$genericsParameter get copyWith;');
  }

  String _maybeOverride(String res) {
    return superClass != null ? '@override $res' : res;
  }

  String get _copyWithInterface => interfaceNameFrom(clonedClassName);
}
