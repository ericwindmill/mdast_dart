import 'package:mdast_dart/ast/nodes/nodes.dart';
import 'package:mdast_dart/mdast_dart.dart';
import 'package:test/test.dart';

import 'resources/blockquote_testcase.dart';
import 'resources/codeblock_testcase.dart';

void main() {
  group("markdown syntax - ", () {
    test("transforms text without syntax into Text", () {
      var markdown = 'banana';
      var ast = markdownToMdast(markdown);
      var result = Root(
        children: [
          Paragraph(
            children: [
              Text(value: 'banana'),
            ],
          ),
        ],
      );

      expect(ast.toMap(), result.toMap());
    });

    test("transforms text with strong syntax", () {
      final markdown = 'this is **strong** text';
      var ast = markdownToMdast(markdown);
      var result = Root(children: [
        Paragraph(children: [
          Text(value: 'this is '),
          Strong(children: [
            Text(value: 'strong'),
          ]),
          Text(value: ' text'),
        ]),
      ]);

      expect(ast.toMap(), result.toMap());
    });

    test("transforms text with ul and li syntax", () {
      final markdown = '''
list syntax in markdown

* list item 1
* list item 2
* list item 3
''';
      var ast = markdownToMdast(markdown);
      var result = Root(
        children: [
          Paragraph(
            children: [
              Text(value: 'list syntax in markdown'),
            ],
          ),
          BulletList(
            ordered: false,
            spread: false,
            children: [
              ListItem(children: [Text(value: 'list item 1')]),
              ListItem(children: [Text(value: 'list item 2')]),
              ListItem(children: [Text(value: 'list item 3')]),
            ],
          ),
        ],
      );

      expect(ast.toMap(), result.toMap());
    });

    test("blockquote syntax", () {
      for (var testCase in blockquoteCases) {
        final ast = markdownToMdast(testCase.markdown);
        expect(ast.toMap(), testCase.mdast.toMap());
      }
    });

    test("code block syntax", () {
      for (var testCase in codeBlockTestCases) {
        final ast = markdownToMdast(testCase.markdown);
        expect(ast.toMap(), testCase.mdast.toMap());
      }
    });
  });
}
