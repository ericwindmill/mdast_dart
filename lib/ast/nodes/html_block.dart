import '../abstract_nodes/ast.dart';

class HtmlBlock extends Parent {
  HtmlBlock({
    super.position,
    super.children,
    super.attributes,
  });

  @override
  String get type => 'htmlBlock';
}
