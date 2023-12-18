import 'package:mdast_dart/ast/nodes/nodes.dart';

import '../mdast_dart_test.dart';

// Text blocks that originate from HTML in the dart/markdown package
// preserve white space and new lines
final htmlBlockTestCase = [
  TestCase(
    syntax: 'HTML',
    markdown: '''
<table>
  <tr>
    <td>
           hi
    </td>
  </tr>
</table>''',
    mdast: Root(
      children: [
        Html(
          value: '''
<table>\n  <tr>\n    <td>\n           hi\n    </td>\n  </tr>\n</table>''',
        ),
      ],
    ),
  ),
];
