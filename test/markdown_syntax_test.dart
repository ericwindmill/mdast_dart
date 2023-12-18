import 'package:markdown/markdown.dart' as md;
import 'package:mdast_dart/mdast_dart.dart';
import 'package:test/test.dart';

import 'mdast_dart_test.dart';
import 'resources/testcases.dart';

void main() {
  var syntaxTestCases = [
    bulletListTestCases,
    blockquoteCases,
    bulletListTestCases,
    codeBlockTestCases,
    emphasisTestCases,
    footnoteTestcases,
    headingTestCases,
    htmlBlockTestCase,
    inlineCodeTestCases,
    orderedListTestCases,
    paragraphTestCases,
    strongTestCases,
  ];

  group("transform md.Element objects into Mdast nodes", () {
    void testSyntax(List<TestCase> testCases) {
      for (var testCase in testCases) {
        test("${testCase.syntax} syntax to mdast", () {
          final ast = markdownToMdast(
            testCase.markdown,
            extensionSet: md.ExtensionSet.gitHubWeb,
          );
          expect(ast.toMap(), testCase.mdast.toMap());
        });
      }
    }

    for (var syntax in syntaxTestCases) {
      testSyntax(syntax);
    }
  });
}
