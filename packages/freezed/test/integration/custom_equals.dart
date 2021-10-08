import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_equals.freezed.dart';

@freezed
class CustomEquals with _$CustomEquals {
  CustomEquals._();
  factory CustomEquals({String? name, int? id}) = _CustomEquals;

  @override
  bool operator ==(Object o) => o is CustomEquals && o.name == name;

  @override
  int get hashCode => name.hashCode;
}

@freezed
class CustomEqualsWithUnion with _$CustomEqualsWithUnion {
  CustomEqualsWithUnion._();
  factory CustomEqualsWithUnion.first({
    String? name,
    int? id,
  }) = CustomEqualsFirst;

  factory CustomEqualsWithUnion.second({
    String? name,
    bool? active,
  }) = CustomEqualsSecond;

  @override
  bool operator ==(Object o) => o is CustomEqualsWithUnion && o.name == name;

  @override
  int get hashCode => name.hashCode;
}
