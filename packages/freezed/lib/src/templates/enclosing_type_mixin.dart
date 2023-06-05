// import 'package:freezed/src/freezed_generator.dart';

// class EnclosingClassMixin {
//   EnclosingClassMixin(this.classDefinition);

//   final FreezedClassDefinition classDefinition;

//   void generate(StringBuffer buffer) {
//     // TODO common properties
//     // TODO add when
//     // TODO add map
//     // TODO add toJson
//     // TODO add copyWith

//     buffer.write('''
// /// The mixin for [${classDefinition.declaration.name}].
// mixin ${classDefinition.mixinName} {
// ''');

//     _writeProperties(buffer);

//     buffer.writeln('}');
//   }

//   void _writeProperties(StringBuffer buffer) {}
// }
