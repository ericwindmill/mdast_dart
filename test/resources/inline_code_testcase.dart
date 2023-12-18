import 'package:mdast_dart/ast/nodes/nodes.dart';

import '../mdast_dart_test.dart';

final inlineCodeTestCases = [
  TestCase(
    syntax: 'InlineCode',
    markdown: '`inline code alone`',
    mdast: Root(
      children: [
        Paragraph(
          children: [
            InlineCode(
              value: 'inline code alone',
            ),
          ],
        ),
      ],
    ),
  ),
  TestCase(
    syntax: 'InlineCode',
    markdown: 'this is a paragraph with `inline code` in the middle ',
    mdast: Root(
      children: [
        Paragraph(
          children: [
            Text(value: 'this is a paragraph with '),
            InlineCode(value: 'inline code'),
            Text(value: ' in the middle'),
          ],
        ),
      ],
    ),
  ),
  TestCase(
    syntax: 'InlineCode',
    markdown: 'this is a paragraph that ends with `inline code`',
    mdast: Root(
      children: [
        Paragraph(
          children: [
            Text(value: 'this is a paragraph that ends with '),
            InlineCode(value: 'inline code'),
          ],
        ),
      ],
    ),
  ),
];
