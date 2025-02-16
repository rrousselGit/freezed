import 'package:freezed_annotation/freezed_annotation.dart';

part 'part_of.dart';
part 'part.freezed.dart';

@freezed
abstract class Part with _$Part {
  const factory Part({required int value}) = _Part;
}
