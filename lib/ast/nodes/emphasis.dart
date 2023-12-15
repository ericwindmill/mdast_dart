import '../abstract_nodes/parent_node.dart';

/// Emphasis represents stress emphasis of its contents.
class Emphasis extends Parent {
  @override
  String get type => 'emphasis';

  Emphasis({
    super.position,
    super.children,
    super.attributes,
  });
}
