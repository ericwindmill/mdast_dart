import '../abstract_nodes/ast.dart';
import '../mixins/association.dart';
import '../utils/extensions.dart';

/// [FootnoteReference] represents a marker through association. It is the item
/// that appears in the main document text, denoting that there is additional
/// information in the footnotes of the document.
///
/// FootnoteReference can be used where phrasing content is expected. It has
/// no content model.
///
/// FootnoteReference includes the mixin [Association].
/// FootnoteReference should be associated with a [FootnoteDefinition].
class FootnoteReference extends Node implements Association {
  @override
  String get type => 'footnoteReference';

  FootnoteReference({
    super.position,
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
      if (position != null)
        'position': {
          'start': position!.start.toMap(),
          'end': position!.end.toMap(),
        },
      'attributes': attributes,
    };
  }
}
