import 'package:markdown/markdown.dart' as md;
import 'package:mdast_dart/transformer_helpers/footnote_reference_helper.dart';

import '../ast/abstract_nodes/ast_node.dart';
import '../ast/nodes/nodes.dart';
import 'transformer_exception.dart';

Node getNodeFromElement(md.Element el) {
  return switch (el) {
    md.Element(tag: 'a', attributes: {'href': String href}) => Link(url: href),
    md.Element(tag: 'blockquote') => Blockquote(),
    md.Element(tag: 'pre') => _buildCodeBlock(el),
    md.Element(tag: 'code') => _buildInlineCode(el),
    md.Element(tag: 'em') => Emphasis(),
    md.Element(tag: 'ol', attributes: {'start': String start}) => OrderedList(
        start: int.parse(start),
      ),
    md.Element(tag: 'ol') => OrderedList(start: 1),
    md.Element(tag: 'ul') => BulletList(),
    md.Element(tag: 'li') => ListItem(),
    md.Element(tag: 'strong') => Strong(),
    md.Element(tag: 'p') => Paragraph(),
    md.Element(tag: 'h1') => Heading(depth: 1),
    md.Element(tag: 'h2') => Heading(depth: 2),
    md.Element(tag: 'h3') => Heading(depth: 3),
    md.Element(tag: 'h4') => Heading(depth: 4),
    md.Element(tag: 'h5') => Heading(depth: 5),
    md.Element(tag: 'h6') => Heading(depth: 6),
    md.Element(tag: 'html') => Html(value: el.textContent),
    md.Element(tag: 'sup') => buildFootnoteRefNode(el),
    _ => throw ('Unknown tag type ${el.tag}'),
  };
}

List<Node> getNodesFromElement(md.Element el) {
  return switch (el) {
    md.Element(
      tag: 'section',
      attributes: {'class': 'footnotes'},
    ) =>
      buildFootnoteDefinitions(el),
    _ => throw ('Unknown tag type: ${el.tag}'),
  };
}

Node _buildCodeBlock(md.Element el) {
  /// Block level code starts with a `pre` tag
  if (el
      case md.Element(
        tag: 'pre',
        children: [
          md.Element(
            tag: 'code',
            attributes: {'class': String language},
            children: <md.Node>[md.Text codeValue],
          ),
        ],
      )) {
    return CodeBlock(
      value: codeValue.textContent,
      lang: language,
    );
  }

  throw MarkdownTransformException(
    'Failed to transform `pre` element into CodeBlock ',
    source: el,
  );
}

Node _buildInlineCode(md.Element el) {
  /// Inline code starts with `code`
  if (el
      case md.Element(
        tag: 'code',
        children: <md.Node>[md.Text codeValue],
      )) {
    return InlineCode(value: codeValue.textContent);
  }

  throw MarkdownTransformException(
    'Failed to transform `code` element into inline code ',
    source: el,
  );
}
