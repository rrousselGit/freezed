// ignore: implementation_imports
import 'package:_fe_analyzer_shared/src/scanner/token.dart'
    show CommentToken, Token;
import 'package:analyzer/dart/element/element.dart';

String documentationOfParameter(ParameterElement parameter) {
  final builder = StringBuffer();

  for (Token token = parameter.session
          .getParsedLibraryByElement(parameter.library)
          ?.getElementDeclaration(parameter)
          ?.node
          ?.beginToken
          ?.precedingComments;
      token is CommentToken;
      token = token.next) {
    builder.writeln(token);
  }

  return builder.toString();
}
