import 'package:freezed_annotation/freezed_annotation.dart';

part 'equal.freezed.dart';

@freezed
abstract class ModelWithList with _$ModelWithList {
  factory ModelWithList({
    @Default(<int>[]) List<int> someList,
    @Default(0) int counter,
  }) = _ModelWithList;
}

void main(List<String> arguments) {
  var model = ModelWithList(someList: List.filled(1000000, 0));

  final stopwatch = Stopwatch()..start();

  var elapsed = 0;

  for (var i = 0; i < 10000; i++) {
    final oldModel = model;
    model = model.copyWith(counter: model.counter + 1);

    if (oldModel == model) {
      throw Exception('New model should not equal old model.');
    }

    model.hashCode;

    final elapsedThisIteration = stopwatch.elapsedMicroseconds;

    if (i % 10 == 0) {
      print('Delta: ${(elapsedThisIteration - elapsed) / 1000000} seconds');
    }

    elapsed = elapsedThisIteration;
  }
}
