import 'package:mdast_dart/ast/nodes/nodes.dart';

import '../../mdast_dart_test.dart';

final headingTestCases = [
  TestCase(
    syntax: 'Heading',
    markdown: '''
# foo
## foo
### foo
#### foo
##### foo
###### foo
''',
    mdast: Root(
      children: [
        Heading(depth: 1, children: [Text(value: 'foo')]),
        Heading(depth: 2, children: [Text(value: 'foo')]),
        Heading(depth: 3, children: [Text(value: 'foo')]),
        Heading(depth: 4, children: [Text(value: 'foo')]),
        Heading(depth: 5, children: [Text(value: 'foo')]),
        Heading(depth: 6, children: [Text(value: 'foo')]),
      ],
    ),
  ),
];
