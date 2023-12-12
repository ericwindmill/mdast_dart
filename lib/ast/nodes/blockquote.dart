import '../abstract_nodes/parent_node.dart';
import '../utils/extensions.dart';

class Blockquote extends Parent {
  @override
  String get type => 'blockquote';

  Blockquote({
    required super.children,
    required super.position,
    super.attributes,
  });

  @override
  @override
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'children': children.map((child) => child.toMap()),
      'position': {
        'start': position.start.toMap(),
        'end': position.end.toMap(),
      },
      'attributes': attributes,
    };
  }
}
