import 'package:mdast_dart/ast/nodes/nodes.dart';

import '../../mdast_dart_test.dart';

final strongTestCases = [
  TestCase(
    syntax: 'Strong',
    markdown: 'this is **strong** text',
    mdast: Root(
      children: [
        Paragraph(
          children: [
            Text(value: 'this is '),
            Strong(children: [
              Text(value: 'strong'),
            ]),
            Text(value: ' text'),
          ],
        ),
      ],
    ),
  ),
];
