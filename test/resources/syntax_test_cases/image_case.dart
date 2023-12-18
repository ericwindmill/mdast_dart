import 'package:mdast_dart/ast/nodes/nodes.dart';

import '../../mdast_dart_test.dart';

final inlineImageTestCases = [
  TestCase(
    syntax: 'Image',
    markdown: '![foo](/url "title")',
    mdast: Root(
      children: [Image(url: '/url', title: 'title', alt: 'foo')],
    ),
  ),
];
