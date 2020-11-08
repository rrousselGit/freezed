import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/element/element.dart';

String documentationOfParameter(ParameterElement parameter) {
  final builder = StringBuffer();

  try {
    for (Token token = parameter.session
            .getParsedLibraryByElement(parameter.library)
            ?.getElementDeclaration(parameter)
            ?.node
            ?.beginToken
            ?.precedingComments;
        token != null;
        token = token.next) {
      builder.writeln(token);
    }
  } catch (err, stack) {
    print(
      'Failed documentationOfParameter ${parameter} ${parameter.enclosingElement} ${parameter.source}',
    );
    rethrow;
  }

  return builder.toString();
}
