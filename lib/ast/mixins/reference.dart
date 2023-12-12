import 'association.dart';

enum ReferenceType { shortcut, collapsed, full }

abstract class Reference implements Association {
  /// A referenceType field must be present.
  /// Its value must be a referenceType.
  /// It represents the explicitness of the reference.
  final ReferenceType referenceType;

  Reference({required this.referenceType});
}
