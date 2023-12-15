import 'dart:io';

import 'package:mdast_dart/ast/nodes/nodes.dart';
import 'package:mdast_dart/mdast_dart.dart';
import 'package:test/test.dart';

class TestCase {
  final String markdown;
  final Root mdast;

  TestCase({
    required this.markdown,
    required this.mdast,
  });
}

void main() {
  group("markdown documents", () {
    test("transforms longform markdown into Mdast nodes", () {
      final file = File('./test/resources/markdown_example_01.md');
      final markdownString = file.readAsStringSync();
      final ast = markdownToMdast(markdownString);
    });
  });
}
