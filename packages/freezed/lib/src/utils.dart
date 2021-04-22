import 'package:analyzer/dart/analysis/results.dart';
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

  for (Token? token = astNode.beginToken.precedingComments;
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
  var library = element.library!;

  while (true) {
    try {
      final result = library.session.getParsedLibraryByElement2(library)
          as ParsedLibraryResult?;

      return result!.getElementDeclaration(element)!.node;
    } on InconsistentAnalysisException {
      library = await buildStep.resolver.libraryFor(
        await buildStep.resolver.assetIdForElement(element.library!),
      );
    }
  }
}

final _upperCase = RegExp('[A-Z]');

String kebabCase(String input) => _fixCase(input, '-');

String snakeCase(String input) => _fixCase(input, '_');

String pascalCase(String input) {
  if (input.isEmpty) {
    return '';
  }

  return input[0].toUpperCase() + input.substring(1);
}

String _fixCase(String input, String separator) =>
    input.replaceAllMapped(_upperCase, (match) {
      var lower = match.group(0)!.toLowerCase();

      if (match.start > 0) {
        lower = '$separator$lower';
      }

      return lower;
    });
