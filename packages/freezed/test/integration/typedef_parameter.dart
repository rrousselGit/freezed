import 'package:freezed_annotation/freezed_annotation.dart';
import 'external_typedef.dart';
import 'external_typedef_two.dart' as two;

part 'typedef_parameter.freezed.dart';

typedef MyTypedef = Function(String);
typedef GenericTypedef<T, S> = S Function(T);

@freezed
class ClassWithTypedef with _$ClassWithTypedef {
  ClassWithTypedef._();
  factory ClassWithTypedef(
    MyTypedef myTypedef,
    MyTypedef? maybeTypedef,
    ExternalTypedef externalTypedef,
    two.ExternalTypedefTwo externalTypedefTwo,
    GenericTypedef<int, bool> genericTypedef,
  ) = _ClassWithTypedef;
}
