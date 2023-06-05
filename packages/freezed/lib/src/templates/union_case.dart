// import 'package:freezed/src/freezed_generator.dart';
// import 'package:freezed/src/templates/prototypes.dart';
// import 'package:source_gen/source_gen.dart';

// class UnionCaseTemplate {
//   UnionCaseTemplate(this.unions);

//   String get _name => unions.first.constructor.name;

//   late final Set<FreezedClassDefinition> _classes =
//       unions.map((e) => e.clazz).toSet();
//   final List<ConstructorPair> unions;

//   void generate(StringBuffer buffer) {
//     // TODO common properties
//     // TODO add when
//     // TODO add map
//     // TODO add toJson
//     // TODO add copyWith

//     _writeDocs(buffer);
//     _writeClassPrototype(buffer);
//     _writeProperties(buffer);

//     buffer.writeln('}');
//   }

//   void _writeClassPrototype(StringBuffer buffer) {
//     buffer.write('sealed class $_name ');

//     switch (_classes) {
//       case [FreezedClassDefinition(canBeExtended: true) && final base]:
//         buffer.writeClassPrototype(extend: base.name);

//       case _ when _classes.where((e) => e.canBeExtended).take(2).length == 2:
//         // TODO A generated type is associated with two classes, yet at least
//         // one of those classes defined a ._() constructor. Meaning that class
//         // should be extended. But that's not doable due to classes being able
//         // to extend only one class.
//         throw InvalidGenerationSourceError('');

//       case _:
//         buffer.writeClassPrototype(
//           implements: _classes
//               .where((e) => e.declaration.mixinKeyword == null)
//               .map((e) => e.name),
//           withs: _classes
//               .where((e) => e.declaration.mixinKeyword != null)
//               .map((e) => e.name),
//         );
//     }
//   }

//   void _writeProperties(StringBuffer buffer) {}

//   void _writeDocs(StringBuffer buffer) {
//     buffer.writeln('/// Mixin for:');
//     for (final union in unions) {
//       buffer.writeln('/// - [${union.constructor.name}]');
//     }
//   }
// }
