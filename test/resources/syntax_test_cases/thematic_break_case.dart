import 'package:mdast_dart/ast/nodes/nodes.dart';

import '../../mdast_dart_test.dart';

final thematicBreakTestCases = [
  TestCase(
    syntax: 'Thematic Break',
    markdown: '''
 ***
  ***
   ***
''',
    mdast: Root(
      children: [
        ThematicBreak(),
        ThematicBreak(),
        ThematicBreak(),
      ],
    ),
  ),
];
