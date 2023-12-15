import '../abstract_nodes/ast.dart';

/// Paragraph (Parent) represents a unit of discourse dealing with a
///  particular point or idea.
///
/// Paragraph can be used where content is expected. Its content model is
/// phrasing content.
///
/// https://github.com/syntax-tree/mdast#paragraph
class Paragraph extends Parent {
  @override
  String get type => 'paragraph';

  Paragraph({
    super.position,
    super.children,
    super.attributes,
  });
}
