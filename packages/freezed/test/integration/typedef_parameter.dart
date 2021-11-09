import 'package:freezed_annotation/freezed_annotation.dart';
import 'external_typedef.dart';
import 'external_typedef_two.dart' as two;

part 'typedef_parameter.freezed.dart';

typedef MyTypedef = Function(String);

@freezed
class ClassWithTypedef with _$ClassWithTypedef {
  ClassWithTypedef._();
  factory ClassWithTypedef(
    MyTypedef myTypedef,
    MyTypedef? maybeTypedef,
    ExternalTypedef externalTypedef,
    two.ExternalTypedefTwo externalTypedefTwo,
  ) = _ClassWithTypedef;
}
