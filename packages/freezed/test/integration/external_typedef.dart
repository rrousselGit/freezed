import 'concrete.dart';

/// A typedef that imports another type
///
/// The generated freezed class will not have to import this import as it
/// is hidden behind the typedef
typedef ExternalTypedef = Function(Concrete);
