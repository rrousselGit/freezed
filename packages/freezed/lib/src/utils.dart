import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';

Future<String> documentationOfParameter(
  ParameterElement parameter,
  BuildStep buildStep,
) async {
  final builder = StringBuffer();

  final astNode = await tryGetAstNodeForElement(parameter, buildStep);

  for (Token token = astNode?.beginToken?.precedingComments;
      token != null;
      token = token.next) {
    builder.writeln(token);
  }

  return builder.toString();
}

Future<AstNode> tryGetAstNodeForElement(
  Element element,
  BuildStep buildStep,
) async {
  var library = element.library;

  while (true) {
    try {
      return library.session
          .getParsedLibraryByElement(library)
          .getElementDeclaration(element)
          .node;
    } on InconsistentAnalysisException {
      library = await buildStep.resolver.libraryFor(
        await buildStep.resolver.assetIdForElement(element.library),
      );
    }
  }
}
