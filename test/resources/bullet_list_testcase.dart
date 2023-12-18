import 'package:mdast_dart/ast/nodes/nodes.dart';

import '../mdast_dart_test.dart';

final bulletListTestCases = [
  TestCase(
    syntax: 'BulletList',
    markdown: '''
list syntax in markdown

* list item 1
* list item 2
* list item 3
''',
    mdast: Root(
      children: [
        Paragraph(
          children: [
            Text(value: 'list syntax in markdown'),
          ],
        ),
        BulletList(
          ordered: false,
          spread: false,
          children: [
            ListItem(children: [Text(value: 'list item 1')]),
            ListItem(children: [Text(value: 'list item 2')]),
            ListItem(children: [Text(value: 'list item 3')]),
          ],
        ),
      ],
    ),
  ),
];
