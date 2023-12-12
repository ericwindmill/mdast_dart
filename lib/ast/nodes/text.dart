import '../abstract_nodes/ast.dart';

/// Text (Literal) represents everything that is just text.
///
/// Text can be used where phrasing content is expected. Its content is
/// represented by its value field.
class Text extends Literal {
  @override
  String get type => 'Text';

  Text({required super.value, required super.position, super.attributes});
}
