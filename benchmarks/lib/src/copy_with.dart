import 'package:freezed_annotation/freezed_annotation.dart';

part 'copy_with.freezed.dart';

const _kUseNaiveImpl = false;

@freezed
abstract class Model with _$Model {
  factory Model({required int counter}) = _Model;
}

@freezed
abstract class ModelWrapper with _$ModelWrapper {
  factory ModelWrapper({
    required Model model,
  }) = _ModelWrapper;
}

void main(List<String> arguments) {
  var wrapper = ModelWrapper(model: Model(counter: 0));

  for (var i = 0; i < 10000000; i++) {
    if (_kUseNaiveImpl)
      wrapper = ModelWrapper(model: Model(counter: wrapper.model.counter + 1));
    else
      wrapper = wrapper.copyWith.model(counter: wrapper.model.counter + 1);
  }
  print(wrapper.model.counter);
}
