import '../abstract_nodes/ast.dart';
import '../mixins/reference.dart';
import '../utils/extensions.dart';

/// LinkReference represents a hyperlink through association,
/// or its original source if there is no association.
///
/// LinkReference can be used where phrasing content is expected.
/// Its content model is also phrasing content.
///
/// LinkReferences should be associated with a [Definition].
/// https://github.com/syntax-tree/mdast#linkreference
class LinkReference extends Parent implements Reference {
  @override
  String get type => 'linkReference';

  LinkReference({
    super.position,
    super.children,
    required this.identifier,
    this.label,
    required this.referenceType,
    super.attributes,
  });

  @override
  final String identifier;

  @override
  final String? label;

  @override
  final ReferenceType referenceType;

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'identifier': identifier,
      'referenceType': referenceType.name,
      if (label != null) 'label': label,
      'children': children.map((child) => child.toMap()).toList(),
      if (position != null)
        'position': {
          'start': position!.start.toMap(),
          'end': position!.end.toMap(),
        },
      'attributes': attributes,
    };
  }
}
