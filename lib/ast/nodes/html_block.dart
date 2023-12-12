import '../abstract_nodes/ast.dart';

class HtmlBlock extends Parent {
  HtmlBlock({
    required super.position,
    required super.children,
    super.attributes,
  });

  @override
  String get type => 'htmlBlock';
}
