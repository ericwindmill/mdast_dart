import 'package:markdown/markdown.dart' as md;

import '../../mdast_dart.dart';
import '../transformer_exception.dart';

Node buildFootnoteRefNode(md.Element el) {
  if (el
      case md.Element(
        tag: 'sup',
        children: [
          md.Element(
            tag: 'a',
            attributes: {
              'href': String href, // format: #fn-${refLabel}
              'id': String id, // format: fnref-${refLabel}
            },
            children: [
              md.Text(
                text: String
                    footnoteSuperscriptText, // should be a number (i.e. "1")
              )
            ]
          ),
        ]
      )) {
    return FootnoteReference(identifier: href, label: footnoteSuperscriptText);
  }

  throw MarkdownTransformException(
    'Failed to transform `sup` tag into FootnoteReference',
    source: el,
  );
}

List<Node> buildFootnoteDefinitions(md.Element el) {
  final footnoteDefs = <Node>[];

  final ol = el.children!
          .firstWhere((element) => element is md.Element && element.tag == 'ol')
      as md.Element;

  final children = ol.children ?? [];

  for (var child in children) {
    if (child is md.Element && child.tag == 'li') {
      final id =
          child.attributes.containsKey('id') ? child.attributes['id'] : '';
      final children = !child.isEmpty ? child.children! : <md.Node>[];
      final mdastTransformer = MdastTransformer();
      final footnoteChildren = mdastTransformer.transform(children);
      // final link = footnoteChildren.children.firstWhere((element) => element.type == 'link') as Link;

      footnoteDefs.add(
        FootnoteDefinition(
          identifier: id!,
          attributes: {'label': 'label'},
          children: [
            Paragraph(
              children: footnoteChildren.children,
            )
          ],
        ),
      );
    }
  }

  return footnoteDefs;
}
