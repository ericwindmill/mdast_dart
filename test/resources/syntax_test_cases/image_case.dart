import 'package:mdast_dart/ast/nodes/nodes.dart';

import '../../mdast_dart_test.dart';

final inlineImageTestCases = [
  TestCase(
    syntax: 'Image',
    markdown: '![foo](/url "title")',
    mdast: Root(
      children: [
        Paragraph(
          children: [
            Image(url: '/url', title: 'title', alt: 'foo'),
          ],
        ),
      ],
    ),
  ),
  TestCase(
    syntax: 'Image',
    markdown: '''
![foo *bar*][]

[foo *bar*]: train.jpg "train & tracks"    
''',
    mdast: Root(
      children: [
        Paragraph(
          children: [
            Image(
                url: 'train.jpg', title: 'train &amp; tracks', alt: 'foo bar'),
          ],
        ),
      ],
    ),
  ),
];
