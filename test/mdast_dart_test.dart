import 'dart:io';

import 'package:mdast_dart/mdast_dart.dart';
import 'package:test/test.dart';

class TestCase {
  final String syntax;
  final String markdown;
  final Root mdast;

  TestCase({
    required this.syntax,
    required this.markdown,
    required this.mdast,
  });
}

void main() {
  group("markdown documents", () {
    test("transforms longform markdown into Mdast nodes", () {
      final file =
          File('./test/resources/markdown_files/markdown_example_01.md');
      final markdownString = file.readAsStringSync();
      try {
        final ast = markdownToMdast(markdownString);
      } catch (e) {
        rethrow;
      }
    });
  });
}
