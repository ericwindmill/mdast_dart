import '../abstract_nodes/ast.dart';

class ListItem extends Parent {
  @override
  final String type = 'listItem';

  ListItem({
    this.spread,
    required super.children,
    required super.position,
    super.attributes,
  });

  bool? spread;

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      if (spread != null) 'spread': spread,
      'position': {
        'start': position.start,
        'end': position.end,
      },
      'children': children.map((child) => child.toMap()),
      'attributes': attributes,
    };
  }
}
