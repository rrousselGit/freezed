// a set of utilities for multiple_constructors_test extracted in a separate
// file so that they can use non-nullable types

import 'integration/multiple_constructors.dart';

typedef NoCommonParamDefaultTearOff = NoCommonParam0 Function(
  String a, {
  int? b,
});

typedef NoCommonParamNamedTearOff = NoCommonParam1 Function(
  double c, [
  Object? d,
]);
