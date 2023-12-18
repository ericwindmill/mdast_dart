import 'package:mdast_dart/ast/nodes/nodes.dart';

import '../mdast_dart_test.dart';

final footnoteTestcases = [
  TestCase(
    syntax: 'Footnote',
    markdown: '''
Footnote 1 link[^first].

[^first]: footnote reference in footnote definition
 ''',
    mdast: Root(
      children: [
        Paragraph(
          children: [
            Text(value: 'Footnote 1 link'),
            FootnoteReference(
              identifier: '#fn-first',
              label: "1",
              attributes: {},
            ),
            Text(value: '.'),
          ],
        ),
      ],
      footnotes: {
        '#fn-first': FootnoteDefinition(
          identifier: '#fn-first',
          children: [
            Paragraph(
              children: [
                Text(
                  value: 'footnote reference in footnote definition',
                )
              ],
            )
          ],
        ),
      },
    ),
  ),
];
