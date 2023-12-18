import 'package:markdown/markdown.dart' as md;
import 'package:mdast_dart/ast/abstract_nodes/ast.dart';

import 'ast/nodes/nodes.dart';
import 'transformer_helpers/html_helper.dart';
import 'transformer_helpers/md_element_to_mdast.dart';

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

List<String> allTags = [
  'blockquote',
  'pre',
  'code',
  'h1',
  'h2',
  'h3',
  'h4',
  'h5',
  'h6',
  'hr',
  'ol',
  'ul',
  'li',
  'p',
  'table',
  'thead',
  'tbody',
  'th',
  'tr',
  'td',
  'a',
  'em',
  'strong',
  'img',
  'br',
  'section', // Used for list of footnotes
  'sup' // superscript -> The text that links to the foot note.
];

class MdastTransformer implements md.NodeVisitor {
  late final Root _root;
  Set<String> uniqueIds = {};
  final _nodeStack = <Node>[];

  MdastTransformer() {
    _root = Root(
      children: [],
      footnotes: {},
    );
    _nodeStack.add(_root);
  }

  /// Entry point for transforming an AST of [md.Node] into an
  /// Mdast AST
  Root transform(List<md.Node> nodes) {
    uniqueIds = <String>{};

    for (var node in nodes) {
      node.accept(this);
    }

    return _root;
  }

  /// Called when a Text node has been reached.
  /// Text must be a leaf
  @override
  void visitText(md.Text text) {
    var content = text.textContent;

    /// Blocks of Html are parsed as [md.Text] objects with no identifiers
    if (htmlBlockPattern.hasMatch(content)) {
      (_nodeStack.last as Parent).children.add(Html(value: content));
      return;
    }

    (_nodeStack.last as Parent).children.add(Text(value: content));
  }

  /// Called when a new element is reached for the first time,
  /// _before_ it's children
  @override
  bool visitElementBefore(md.Element element) {
    /// [md.Element]s with these tags return List<Node>
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
    /// and don't have special rule.s
    else if (!element.isEmpty) {
      _nodeStack.add(getNodeFromElement(element));
      return true;
    } else {
      throw "shit";
    }
  }

  // must not have anymore children
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
