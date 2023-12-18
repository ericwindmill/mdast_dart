import 'package:mdast_dart/ast/nodes/nodes.dart';

import '../../mdast_dart_test.dart';

final imageReferenceCase = [
  TestCase(
    syntax: 'ImageReference',
    markdown: '''
![Foo]

[foo]: /url "title"   
''',
    mdast: Root(
      children: [
        Paragraph(
          children: [
            Image(url: '/url', alt: 'Foo', title: 'title'),
          ],
        ),
      ],
    ),
  ),
  TestCase(
    syntax: 'ImageReference',
    markdown: '''
![aaa][bbb]

[bbb]: /iRefUrl    
''',
    mdast: Root(
      children: [
        Paragraph(
          children: [
            Image(
              url: '/iRefUrl',
              alt: 'aaa',
            ),
          ],
        ),
      ],
    ),
  ),
];
