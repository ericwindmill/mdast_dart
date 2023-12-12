import '../abstract_nodes/ast.dart';

/// Emphasis represents stress emphasis of its contents.
class Strong extends Parent {
  @override
  String get type => 'strong';

  Strong({required super.position, required super.children, super.attributes});
}
