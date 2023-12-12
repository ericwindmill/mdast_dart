import '../abstract_nodes/ast.dart';
import '../utils/extensions.dart';

/// Parent AST nodes are nodes that have [children]
/// such as Text, Code block,
abstract class Parent extends Node {
  Parent({
    required super.position,
    required this.children,
    super.attributes,
  });

  final List<Node> children;

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'children': children.map((e) => e.toMap()),
      'position': {
        'start': position.start.toMap(),
        'end': position.end.toMap(),
      },
      'attributes': attributes,
    };
  }

  @override
  String toString() => toMap().toPrettyString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Parent &&
          type == other.type &&
          position.start == other.position.start &&
          position.end == other.position.end &&
          runtimeType == other.runtimeType &&
          children == other.children;

  @override
  int get hashCode => children.hashCode;
}
