import 'package:freezed/src/freezed_generator.dart';
import 'package:freezed/src/models.dart';

import 'copy_with.dart';
import 'properties.dart';
import 'prototypes.dart';

class Abstract {
  Abstract({
    required this.data,
    required this.copyWith,
    required this.commonProperties,
  });

  final Data data;
  final CopyWith? copyWith;
  final List<Property> commonProperties;

  @override
  String toString() {
    final abstractProperties = commonProperties
        .expand((e) => [
              e.unimplementedGetter,
              if (!e.isFinal) e.unimplementedSetter,
            ])
        .join();

    return '''
/// @nodoc
mixin _\$${data.name.public}${data.genericsDefinitionTemplate} {

$abstractProperties
$_when
$_whenOrNull
$_maybeWhen
$_map
$_mapOrNull
$_maybeMap
$_toJson
${copyWith?.abstractCopyWithGetter ?? ''}
}

$_firebaseCollectionReference

$_firebaseDocumentReference

${copyWith?.commonInterface ?? ''}

${copyWith?.commonConcreteImpl ?? ''}
''';
  }

  String get _toJsonParams => toJsonParameters(
      data.genericsParameterTemplate, data.genericArgumentFactories);
  String get _toJson {
    if (!data.generateToJson) return '';
    return 'Map<String, dynamic> toJson($_toJsonParams)'
        ' => throw $privConstUsedErrorVarName;';
  }

  String get _when {
    if (!data.when.when) return '';
    return '${whenPrototype(data.constructors)} => throw $privConstUsedErrorVarName;';
  }

  String get _whenOrNull {
    if (!data.when.whenOrNull) return '';
    return '${whenOrNullPrototype(data.constructors)} => throw $privConstUsedErrorVarName;';
  }

  String get _maybeWhen {
    if (!data.when.maybeWhen) return '';
    return '${maybeWhenPrototype(data.constructors)} => throw $privConstUsedErrorVarName;';
  }

  String get _map {
    if (!data.map.map) return '';
    return '${mapPrototype(data.constructors, data.genericsParameterTemplate)} => throw $privConstUsedErrorVarName;';
  }

  String get _mapOrNull {
    if (!data.map.mapOrNull) return '';
    return '${mapOrNullPrototype(data.constructors, data.genericsParameterTemplate)} => throw $privConstUsedErrorVarName;';
  }

  String get _maybeMap {
    if (!data.map.maybeMap) return '';
    return '${maybeMapPrototype(data.constructors, data.genericsParameterTemplate)} => throw $privConstUsedErrorVarName;';
  }

  String get _firebaseCollectionReference {
    if (data.firebasePath == null) return '';
    return '''
      CollectionReference<${data.name.public}> ${data.name.public[0].toLowerCase() + data.name.public.substring(1)}Collection([String path = '${data.firebasePath}']) {
        return FirebaseFirestore.instance.collection(path).withConverter<${data.name.public}>(
            fromFirestore: (snapshot, _) => _\$${data.name.public}FromJson(snapshot.data()!),
            toFirestore: (instance, _) => instance.toJson());
      }
    ''';
  }

  String get _firebaseDocumentReference {
    if (data.firebasePath == null) return '';
    return '''
      DocumentReference<${data.name.public}> ${data.name.public[0].toLowerCase() + data.name.public.substring(1)}Doc({String path = '${data.firebasePath}', required String docId}) {
        return FirebaseFirestore.instance.doc('\$path/\$docId').withConverter<${data.name.public}>(
            fromFirestore: (snapshot, _) => _\$${data.name.public}FromJson(snapshot.data()!),
            toFirestore: (instance, _) => instance.toJson());
      }
    ''';
  }
}
