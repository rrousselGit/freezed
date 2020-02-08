import 'package:meta/meta.dart';

part 'generic.g.dart';

class Model<T> {
  Model(this.value);
  final T value;
}

@immutable
abstract class Generic<T extends Model<dynamic>> with _$Generic<T> {
  factory Generic(T model) = _Generic<T>;
}

@immutable
abstract class MultiGeneric<A, T extends Model<A>> with _$MultiGeneric<A, T> {
  factory MultiGeneric(T model) = _MultiGeneric<A, T>;
}

@immutable
abstract class MultipleConstructors<A, B> with _$MultipleConstructors<A, B> {
  factory MultipleConstructors(bool flag) = Default<A, B>;
  factory MultipleConstructors.first(A a) = First<A, B>;
  factory MultipleConstructors.second(B b) = Second<A, B>;
}

@immutable
abstract class Union<T> with _$Union<T> {
  const factory Union(T value) = Data<T>;
  const factory Union.loading() = Loading<T>;
  const factory Union.error([String message]) = ErrorDetails<T>;
}