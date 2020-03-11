import 'package:freezed_annotation/freezed_annotation.dart';

part 'deep_copy.freezed.dart';

@freezed
abstract class Simple with _$Simple {
  factory Simple(@nullable int first, @nullable String second) = _Simple;
}

@freezed
abstract class Deep with _$Deep {
  factory Deep(@nullable Simple first, @nullable int second) = _Deep;
}

@freezed
abstract class VeryDeep with _$VeryDeep {
  factory VeryDeep(@nullable Deep first, @nullable int second) = _VeryDeep;
}

// void main() {
//   Simple simple;
//   var x = simple.$first(42);

//   Deep deep;

//   deep = deep.$first(x);
//   deep = deep.$first.first(42);
//   deep = deep.$second(42);

//   VeryDeep veryDeep;

//   veryDeep = veryDeep.$first(deep);
//   veryDeep = veryDeep.$first.first(simple);
//   veryDeep = veryDeep.$first.first.first(42);
//   veryDeep = veryDeep.$second(42);
// }

// /** GENERATED  */

// extension on Simple {
//   Simple $first(int value) {
//     return Simple(value, second);
//   }

//   Simple $second(String value) {
//     return Simple(first, value);
//   }
// }

// T _identity<T>(T value) => value;

// extension on Deep {
//   _$DeepFirst<Deep> get $first => _$DeepFirst(this, _identity);

//   Deep $second(int value) {
//     return Deep(first, value);
//   }
// }

// class _$DeepFirst<Res> {
//   _$DeepFirst(this._deep, this._then);

//   final Deep _deep;
//   final Res Function(Deep value) _then;

//   Res call(Simple value) {
//     return _then(
//       Deep(value, _deep.second),
//     );
//   }

//   Res first(int value) {
//     return _then(
//       Deep(
//         _deep.first.$first(value),
//         _deep.second,
//       ),
//     );
//   }

//   Res second(String value) {
//     return _then(
//       Deep(
//         _deep.first.$second(value),
//         _deep.second,
//       ),
//     );
//   }
// }

// extension on VeryDeep {
//   _$VeryDeepFirst<VeryDeep> get $first => _$VeryDeepFirst(this, _identity);

//   VeryDeep $second(int value) {
//     return VeryDeep(first, value);
//   }
// }

// class _$VeryDeepFirst<Res> {
//   _$VeryDeepFirst(this._veryDeep, this._then);

//   final VeryDeep _veryDeep;
//   final Res Function(VeryDeep value) _then;

//   Res call(Deep value) {
//     return _then(VeryDeep(value, _veryDeep.second));
//   }

//   _$DeepFirst<VeryDeep> get first {
//     return _veryDeep.first == null
//         ? null
//         : _$DeepFirst<VeryDeep>(
//             _veryDeep.first,
//             (res) => VeryDeep(res, _veryDeep.second),
//           );
//   }

//   Res second(int value) {
//     return _then(
//       VeryDeep(
//         _veryDeep.first.$second(value),
//         _veryDeep.second,
//       ),
//     );
//   }
// }
