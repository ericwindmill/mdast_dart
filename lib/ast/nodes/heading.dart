import '../abstract_nodes/ast.dart';
import '../utils/extensions.dart';

/// Heading represents a heading of a section.
class Heading extends Parent {
  @override
  String get type => 'heading';

  Heading({
    required super.children,
    required super.position,
    required this.depth,
    super.attributes,
  }) : assert(depth >= 1 && depth <= 6);

  final int depth;

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'children': children.map((child) => child.toMap()),
      'depth': depth,
      'position': {
        'start': position.start.toMap(),
        'end': position.end.toMap(),
      },
      'attributes': attributes,
    };
  }
}
