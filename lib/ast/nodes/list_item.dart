import '../abstract_nodes/ast.dart';
import '../utils/extensions.dart';

class ListItem extends Parent {
  @override
  final String type = 'listItem';

  ListItem({
    this.spread,
    super.children,
    super.position,
    super.attributes,
  });

  bool? spread;

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      if (spread != null) 'spread': spread,
      if (position != null)
        'position': {
          'start': position!.start.toMap(),
          'end': position!.end.toMap(),
        },
      'children': children.map((child) => child.toMap()).toList(),
      'attributes': attributes,
    };
  }
}
