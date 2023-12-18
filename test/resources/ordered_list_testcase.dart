import 'package:mdast_dart/ast/nodes/nodes.dart';

import '../mdast_dart_test.dart';

final orderedListTestCases = [
  TestCase(
    syntax: 'OrderedList',
    markdown: '''
list syntax in markdown

1. list item 1
2. list item 2
3. list item 3
''',
    mdast: Root(
      children: [
        Paragraph(
          children: [
            Text(value: 'list syntax in markdown'),
          ],
        ),
        OrderedList(
          ordered: true,
          spread: false,
          children: [
            ListItem(children: [Text(value: 'list item 1')]),
            ListItem(children: [Text(value: 'list item 2')]),
            ListItem(children: [Text(value: 'list item 3')]),
          ],
          start: 1,
        ),
      ],
    ),
  ),
  TestCase(
    syntax: 'OrderedList',
    markdown: '''
list syntax that doesn't start with 1

3. list item 1
4. list item 2
5. list item 3
''',
    mdast: Root(
      children: [
        Paragraph(
          children: [
            Text(value: "list syntax that doesn't start with 1"),
          ],
        ),
        OrderedList(
          ordered: true,
          spread: false,
          children: [
            ListItem(children: [Text(value: 'list item 1')]),
            ListItem(children: [Text(value: 'list item 2')]),
            ListItem(children: [Text(value: 'list item 3')]),
          ],
          start: 3,
        ),
      ],
    ),
  ),
];
