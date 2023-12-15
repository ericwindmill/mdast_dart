import '../abstract_nodes/ast.dart';

/// Emphasis represents stress emphasis of its contents.
class Strong extends Parent {
  @override
  String get type => 'strong';

  Strong({super.position, super.children, super.attributes});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Strong &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          children == other.children &&
          attributes == other.attributes;

  @override
  int get hashCode => super.hashCode;
}
