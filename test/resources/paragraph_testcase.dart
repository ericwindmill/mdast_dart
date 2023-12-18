import 'package:mdast_dart/ast/nodes/nodes.dart';

import '../mdast_dart_test.dart';

final paragraphTestCases = [
  TestCase(
    syntax: 'Paragraph',
    markdown: 'banana',
    mdast: Root(
      children: [
        Paragraph(
          children: [
            Text(value: 'banana'),
          ],
        ),
      ],
    ),
  ),
];
