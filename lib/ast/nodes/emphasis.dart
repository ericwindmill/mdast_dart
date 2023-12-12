import '../abstract_nodes/parent_node.dart';

/// Emphasis represents stress emphasis of its contents.
class Emphasis extends Parent {
  @override
  String get type => 'emphasis';

  Emphasis({
    required super.position,
    required super.children,
    super.attributes,
  });
}
