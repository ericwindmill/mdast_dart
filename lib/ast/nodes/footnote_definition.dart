import '../abstract_nodes/ast.dart';
import '../mixins/association.dart';
import '../utils/extensions.dart';

/// [FootnoteDefinition] represents content relating to the document
/// that is outside its flow. (The footnote itself that generally appears at
/// the bottom of the rendered page.)
///
/// FootnoteDefinition can be used where flow content is expected. Its content
/// model is also flow content.
///
/// FootnoteDefinition includes the mixin [Association].
/// FootnoteDefinition should be associated with FootnoteReferences.
class FootnoteDefinition extends Parent implements Association {
  @override
  String get type => 'footnoteDefinition';

  FootnoteDefinition({
    super.position,
    super.children,
    required this.identifier,
    this.label,
    super.attributes,
  });

  @override
  final String identifier;

  @override
  final String? label;

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'identifier': identifier,
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
