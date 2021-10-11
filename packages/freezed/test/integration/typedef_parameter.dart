import 'package:freezed_annotation/freezed_annotation.dart';
import 'external_typedef.dart';

part 'typedef_parameter.freezed.dart';

typedef MyTypedef = Function(String);

@freezed
class ClassWithTypedef with _$ClassWithTypedef {
  ClassWithTypedef._();
  factory ClassWithTypedef(
      MyTypedef myTypedef, ExternalTypedef externalTypedef) = _ClassWithTypedef;
}
