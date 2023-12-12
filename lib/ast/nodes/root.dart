import '../abstract_nodes/ast.dart';

/// Root (Parent) represents a document.
///
/// Root can be used as the root of a tree, never as a child. Its content
/// model is not limited to flow content, but instead can contain any mdast
/// content with the restriction that all content must be of the same category.
/// https://github.com/syntax-tree/mdast#root
class Root extends Parent {
  @override
  String get type => 'root';

  Root({
    required super.position,
    required super.children,
    super.attributes,
  });
}
