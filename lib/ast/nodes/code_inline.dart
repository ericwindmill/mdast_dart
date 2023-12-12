import '../abstract_nodes/ast.dart';

/// InlineCode (Literal) represents a fragment of computer code,
/// such as a file name, computer program, or anything a computer could parse.
///
/// InlineCode can be used where phrasing content is expected. Its content is
/// represented by its value field.
///
/// This node relates to the flow content concept Code.
/// https://github.com/syntax-tree/mdast#inlinecode
class InlineCode extends Literal {
  InlineCode({
    required super.position,
    required super.value,
    super.attributes,
  });

  @override
  String get type => 'inlineCode';
}
