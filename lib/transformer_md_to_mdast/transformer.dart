import 'package:markdown/markdown.dart' as md;
import 'package:mdast_dart/transformer_md_to_mdast/transformer_exception.dart';

import '../ast/abstract_nodes/ast.dart';
import '../ast/nodes/nodes.dart';
import 'helpers/html_helper.dart';
import 'md_element_to_mdast.dart';

Root markdownToMdast(
  String markdown, {
  Iterable<md.BlockSyntax> blockSyntaxes = const [],
  Iterable<md.InlineSyntax> inlineSyntaxes = const [],
  md.ExtensionSet? extensionSet,
  md.Resolver? linkResolver,
  md.Resolver? imageLinkResolver,
  bool inlineOnly = false,
  bool encodeHtml = true,
  bool enableTagfilter = false,
  bool withDefaultBlockSyntaxes = true,
  bool withDefaultInlineSyntaxes = true,
}) {
  final document = md.Document(
    blockSyntaxes: blockSyntaxes,
    inlineSyntaxes: inlineSyntaxes,
    extensionSet: extensionSet,
    linkResolver: linkResolver,
    imageLinkResolver: imageLinkResolver,
    encodeHtml: encodeHtml,
    withDefaultBlockSyntaxes: withDefaultBlockSyntaxes,
    withDefaultInlineSyntaxes: withDefaultInlineSyntaxes,
  );

  final nodes = document.parse(markdown);

  final mdastTransformer = MdastTransformer();
  return mdastTransformer.transform(nodes);
}

class MdastTransformer implements md.NodeVisitor {
  late final Root _root;
  final _nodeStack = <Node>[];

  MdastTransformer() {
    _root = Root(
      children: [],
      footnotes: {},
    );
    _nodeStack.add(_root);
  }

  /// Entry point for transforming an AST of [md.Node] into an
  /// Mdast AST.
  Root transform(List<md.Node> nodes) {
    for (var node in nodes) {
      node.accept(this);
    }

    return _root;
  }

  /// Called when a Text node has been reached. Text must be a leaf.
  ///
  /// Blocks of Html are parsed as [md.Text] objects with no identifiers,
  /// and need to be transformed into [Html] mdast nodes, and thus
  /// are handled here.
  @override
  void visitText(md.Text text) {
    var content = text.textContent;

    if (htmlBlockPattern.hasMatch(content)) {
      (_nodeStack.last as Parent).children.add(Html(value: content));
      return;
    }

    (_nodeStack.last as Parent).children.add(Text(value: content));
  }

  /// Called when a new element is reached for the first time,
  /// before it's children are visited. This method performs most of the
  /// heavy lifting.
  ///
  ///
  /// [md.Element]s require different rules for transforming, and this method
  /// handles distinguishing which elements should be handled which way.
  /// Elements are differentiates by the following characteristics:
  /// - Should the element's children be visited? (return true or false)
  /// - Will the element transform into a List of nodes, or a singular node?
  ///
  /// The specific cases handled:
  /// - Elements who's children should not be visited (if they have children),
  /// and who will produce a List of nodes.
  /// This is a special case for [FootnoteDefinition]s. This case adds the
  /// resulting nodes to [Root.footnotes].
  /// - Elements who have children, but who's children should not be visited,
  /// and who will transform into a single a [Node].
  /// This case covers elements who are flattened in some way as they're
  /// transformed into mdast nodes, and elements who don't have children
  /// - Elements who's children should be visited. This is the most common case.
  @override
  bool visitElementBefore(md.Element element) {
    if (['section'].contains(element.tag)) {
      // TODO(ewindmill) Are the only nodes in this clause ones that will be
      // added directly to the root?
      final nodes = getNodesFromElement(element);
      if (nodes.first is FootnoteDefinition) {
        for (var (node as FootnoteDefinition) in nodes) {
          _root.footnotes[node.identifier] = node;
        }
      }
      return false;
    }

    /// [md.Elements] tags who do not need their children visited
    /// This can be because they have no children, or because they are
    /// a special case in which their children are transformed outside this
    /// visitor
    /// Elements will return false if they have no children,
    else if (['code', 'pre', 'sup', 'br', 'hr', 'img'].contains(element.tag)) {
      (_nodeStack.last as Parent).children.add(getNodeFromElement(element));
      return false;
    }

    /// The standard case: All elements that have children,
    /// and don't require a special case.
    else if (!element.isEmpty) {
      _nodeStack.add(getNodeFromElement(element));
      return true;
    } else {
      throw MarkdownTransformException(
          "visitElementBefore failed. Element didn't satisfy any condition for further transforming.");
    }
  }

  /// Called when an Element has been reached, after its children have been
  /// visited.
  ///
  /// Will not be called if [visitElementBefore] returns `false`.
  @override
  void visitElementAfter(md.Element element) {
    final currentNode = _nodeStack.removeLast();

    // if there's one element left in the stack,
    // it must be the Root.
    if (_nodeStack.isNotEmpty) {
      (_nodeStack.last as Parent).children.add(currentNode);
    }
  }
}
