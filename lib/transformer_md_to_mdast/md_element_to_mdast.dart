import 'package:markdown/markdown.dart' as md;

import '../ast/abstract_nodes/ast_node.dart';
import '../ast/nodes/nodes.dart';
import 'helpers/code_block_helper.dart';
import 'helpers/footnote_reference_helper.dart';

Node getNodeFromElement(md.Element el) {
  return switch (el) {
    md.Element(tag: 'a', attributes: {'href': String href}) => Link(url: href),
    md.Element(tag: 'blockquote') => Blockquote(),
    md.Element(tag: 'code') => InlineCode(value: el.textContent),
    md.Element(tag: 'em') => Emphasis(),
    md.Element(tag: 'h1') => Heading(depth: 1),
    md.Element(tag: 'h2') => Heading(depth: 2),
    md.Element(tag: 'h3') => Heading(depth: 3),
    md.Element(tag: 'h4') => Heading(depth: 4),
    md.Element(tag: 'h5') => Heading(depth: 5),
    md.Element(tag: 'h6') => Heading(depth: 6),
    md.Element(tag: 'hr') => ThematicBreak(),
    md.Element(tag: 'html') => Html(value: el.textContent),
    md.Element(
      tag: 'img',
      attributes: {
        'src': String url,
        'alt': String alt,
        'title': String title,
      }
    ) =>
      Image(url: url, alt: alt, title: title),
    md.Element(
      tag: 'img',
      attributes: {
        'src': String url,
        'alt': String alt,
      }
    ) =>
      Image(url: url, alt: alt),
    md.Element(tag: 'li') => ListItem(),
    md.Element(
      tag: 'ol',
      attributes: {'start': String start},
    ) =>
      OrderedList(start: int.parse(start)),
    md.Element(tag: 'ol') => OrderedList(start: 1),
    md.Element(tag: 'p') => Paragraph(),
    md.Element(tag: 'pre') => buildCodeBlock(el),
    md.Element(tag: 'strong') => Strong(),
    md.Element(tag: 'sup') => buildFootnoteRefNode(el),
    md.Element(tag: 'ul') => BulletList(),
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
