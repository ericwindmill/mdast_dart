import '../abstract_nodes/ast.dart';

/// Html represents a fragment of raw HTML.
/// Html can be used where flow or phrasing content is expected. Its content
/// is represented by it's `value` field.
///
/// Html nodes do not have the restriction of being valid or complete HTML
/// constructs.
class Html extends Literal {
  @override
  String get type => 'html';

  Html({
    super.position,
    required super.value,
    super.attributes,
  });
}
