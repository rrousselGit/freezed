import 'package:macros/macros.dart';

extension FunctionUtils on FunctionDeclaration {
  /// All parameters for this function.
  Iterable<FormalParameterDeclaration> get parameters =>
      positionalParameters.followedBy(namedParameters);
}
