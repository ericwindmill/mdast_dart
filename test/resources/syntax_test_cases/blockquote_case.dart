import 'package:mdast_dart/ast/nodes/nodes.dart';

import '../../mdast_dart_test.dart';

final blockquoteCases = [
  TestCase(
    syntax: 'Blockquote',
    markdown: '''
> Foo
> bar
> baz
''',
    mdast: Root(
      children: [
        Blockquote(children: [
          Paragraph(
            children: [
              Text(
                value: 'Foo\nbar\nbaz',
              )
            ],
          ),
        ]),
      ],
    ),
  ),
  TestCase(
    syntax: 'Blockquote',
    markdown: '''
> However, because of laziness, a blank line is needed between a block quote and a following paragraph:
''',
    mdast: Root(
      children: [
        Blockquote(children: [
          Paragraph(
            children: [
              Text(
                value:
                    'However, because of laziness, a blank line is needed between a block quote and a following paragraph:',
              )
            ],
          ),
        ]),
      ],
    ),
  )
];
