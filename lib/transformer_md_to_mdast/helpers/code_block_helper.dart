import 'package:markdown/markdown.dart' as md;

import '../../ast/abstract_nodes/ast_node.dart';
import '../../ast/nodes/nodes.dart';
import '../transformer_exception.dart';

Node buildCodeBlock(md.Element el) {
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

  /// Block level code starts with a `pre` tag
  if (el
      case md.Element(
        tag: 'pre',
        children: [
          md.Element(
            tag: 'code',
            children: <md.Node>[md.Text codeValue],
          ),
        ],
      )) {
    return CodeBlock(
      value: codeValue.textContent,
      lang: 'txt',
    );
  }

  throw MarkdownTransformException(
    'Failed to transform `pre` element into CodeBlock ',
    source: el,
  );
}
