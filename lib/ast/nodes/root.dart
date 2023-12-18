import 'package:mdast_dart/ast/nodes/nodes.dart';

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

  /// A map of footnote identifiers to [FootnoteDefinition]
  /// In Markdown to HTML, footnotes are often added at the bottom of a
  /// document in a `<section>` tag. This map is the IR of that section tag.
  Map<String, FootnoteDefinition> footnotes;

  Root({
    super.position,
    super.children,
    super.attributes,
    Map<String, FootnoteDefinition>? footnotes,
  }) : footnotes = footnotes ?? {};
}
