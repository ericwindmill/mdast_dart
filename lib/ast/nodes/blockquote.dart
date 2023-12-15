import '../abstract_nodes/parent_node.dart';
import '../utils/extensions.dart';

class Blockquote extends Parent {
  @override
  String get type => 'blockquote';

  Blockquote({
    super.children,
    super.position,
    super.attributes,
  });

  @override
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
}
