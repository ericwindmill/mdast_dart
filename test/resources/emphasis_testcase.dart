import 'package:mdast_dart/ast/nodes/nodes.dart';

import '../mdast_dart_test.dart';

final emphasisTestCases = [
  TestCase(
    syntax: 'Emphasis',
    markdown: 'this is _emphasized_ text',
    mdast: Root(
      children: [
        Paragraph(
          children: [
            Text(value: 'this is '),
            Emphasis(
              children: [
                Text(value: 'emphasized'),
              ],
            ),
            Text(value: ' text'),
          ],
        ),
      ],
    ),
  ),
];
