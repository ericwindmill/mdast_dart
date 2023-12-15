import 'package:mdast_dart/ast/nodes/nodes.dart';

import '../mdast_dart_test.dart';

final codeBlockTestCases = [
  TestCase(
    markdown: '''
```dart
var message = 'hello';
print(message);
```
''',
    mdast: Root(
      children: [
        CodeBlock(
          lang: 'language-dart',
          value: "var message = 'hello';\nprint(message);\n",
        ),
      ],
    ),
  ),
];
