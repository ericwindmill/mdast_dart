import 'package:markdown/markdown.dart' as md;
import 'package:mdast_dart/ast/abstract_nodes/ast.dart';

import 'ast/nodes/nodes.dart';

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

  final mdastTransformer = MdastTransformer(Root(children: []));
  return mdastTransformer.transform(nodes);
}

/// Mdast nodes are of type Literal, Parent, or (rarely) Node
/// These don't map cleanly to Markdown's block and inline syntax,
/// nor does it map cleanly to [md.Element]s with children and without.
/// For example, the Mdast [CodeBlock] node is a Literal, but the
/// [md.Element] types 'pre' and 'code' have children.
///
/// Effectively, this means that we can't cleanly distinguish between
/// elements that have children and don't. Rather, each element-to-node
/// combination must be put into a particular bucket.
///
/// All tags:
///
///
/// - Block elements that become Parents
/// - Block elements that become Literals (such as
/// - Inline elements that become Parents (such as 'em' or 'strong' => [Strong])
/// - Inline elements that become Literals (such as 'code' => [InlineCode])
///

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
  'html',
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
];

List<String> tagsThatBecomeLiteral = [
  'html',
  'code',
];

List<String> tagsThatBecomeNode = ['br', 'img'];

class MdastTransformer implements md.NodeVisitor {
  final Root _root;
  Set<String> uniqueIds = {};
  final _nodeStack = <Node>[];

  MdastTransformer(this._root) {
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

    (_nodeStack.last as Parent).children.add(Text(value: content));
  }

  Map<String, Type> elementToNodeType = {
    'code': Literal,
  };

  // "Before" refers to when this node is visited in relation to it's
  // children, not to the Element before this one.
  @override
  bool visitElementBefore(md.Element element) {
    if (tagsThatBecomeLiteral.contains(element.tag)) {
      // handle literal
      (_nodeStack.last as Parent).children.add(getNodeFromElement(element));
      return false;
    } else if (tagsThatBecomeNode.contains(element.tag)) {
      // handle node
      (_nodeStack.last as Parent).children.add(getNodeFromElement(element));
      return false;
    } else if (!element.isEmpty) {
      _nodeStack.add(getNodeFromElement(element));
      return true;
    } else {
      throw MarkdownTransformException(
        'Element has unknown tag type: ${element.tag}',
        source: element,
      );
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

Node getNodeFromElement(md.Element el) {
  return switch (el.tag) {
    'blockquote' => Blockquote(children: []),
    'code' => _buildCodeBlock(el),
    'ul' => BulletList(children: []),
    'li' => ListItem(children: []),
    'strong' => Strong(children: <Node>[]),
    'p' => Paragraph(children: <Node>[]),
    _ => throw ('Unknown tag type ${el.tag}'),
  };
}

CodeBlock _buildCodeBlock(md.Element el) {
  if (el
      case md.Element(
        tag: 'code',
        attributes: {'class': String language},
        children: <md.Node>[md.Text codeValue],
      )) {
    return CodeBlock(
      value: codeValue.textContent,
      lang: language,
    );
  }

  throw MarkdownTransformException('Failed to transform code tag', source: el);
}

/// Thrown when the Markdown to Mdast transformer encounters
/// an [md.Element] that is cannot convert to an Mdast node
class MarkdownTransformException implements Exception {
  final String message;
  final md.Element? source;

  MarkdownTransformException(
    this.message, {
    this.source,
  });

  @override
  String toString() {
    String report = 'MarkdownTransformException: $message';

    if (source != null) {
      report += '\n Element: ${source!.tag}';
      if (source!.generatedId != null) {
        report += '\n generatedId: ${source!.generatedId}';
      }
    }

    return report;
  }
}
