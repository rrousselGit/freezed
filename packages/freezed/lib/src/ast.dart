import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/element/element2.dart';

extension AstX on AstNode {
  String? get documentation {
    final builder = StringBuffer();

    for (
      Token? token = beginToken.precedingComments;
      token != null;
      token = token.next
    ) {
      builder.writeln(token);
    }

    if (builder.isEmpty) return null;

    return builder.toString();
  }
}

extension ClassX on ClassDeclaration {
  bool get hasCustomToString {
    final element = declaredFragment!.element;

    for (final type in [
      element,
      ...element.allSupertypes
          .where((e) => !e.isDartCoreObject)
          .map((e) => e.element3),
    ]) {
      for (final method in type.methods2) {
        if (method.name3 == 'toString') {
          return true;
        }
      }
    }

    return false;
  }

  bool get hasSuperEqual => declaredFragment!.element.allSupertypes
      .where((e) => !e.isDartCoreObject)
      .map((e) => e.element3)
      .any((e) => e.hasEqual);

  bool get hasCustomEquals => declaredFragment!.element.hasEqual;

  bool get hasSuperHashCode => declaredFragment!.element.allSupertypes
      .where((e) => !e.isDartCoreObject)
      .map((e) => e.element3)
      .any((e) => e.hasHashCode);
}

extension on InterfaceElement2 {
  bool get hasEqual => methods2.any(((e) => e.isOperator && e.name3 == '=='));

  bool get hasHashCode => getters2.any((e) => e.name3 == 'hashCode');
}

extension ConstructorX on ConstructorDeclaration {
  String get fullName {
    final classElement = declaredFragment!.element.enclosingElement2;

    var generics = classElement.typeParameters2
        .map((e) => '\$${e.name3}')
        .join(', ');
    if (generics.isNotEmpty) {
      generics = '<$generics>';
    }

    final className = classElement.enclosingElement2.name3;

    return name == null ? '$className$generics' : '$className$generics.$name';
  }

  String get escapedName {
    final classElement = declaredFragment!.element.enclosingElement2;

    var generics = classElement.typeParameters2
        .map((e) => '\$${e.name3}')
        .join(', ');
    if (generics.isNotEmpty) {
      generics = '<$generics>';
    }

    final escapedElementName = classElement.name3!.replaceAll(r'$', r'\$');
    final escapedConstructorName = name?.lexeme.replaceAll(r'$', r'\$');

    return escapedConstructorName == null
        ? '$escapedElementName$generics'
        : '$escapedElementName$generics.$escapedConstructorName';
  }
}
