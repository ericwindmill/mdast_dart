import '../abstract_nodes/ast.dart';
import '../utils/extensions.dart';

/// Parent AST nodes are nodes that have [children]
/// such as Text, Code block,
abstract class Parent extends Node {
  Parent({
    this.children = const [],
    super.position,
    super.attributes,
  });

  final List<Node> children;

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'children': children.map((child) => child.toMap()).toList(),
      if (position != null)
        'position': {
          'start': position!.start.toMap(),
          'end': position!.end.toMap(),
        },
      'attributes': attributes,
    };
  }

  @override
  String toString() => toMap().toPrettyString();
}
