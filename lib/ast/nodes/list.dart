import '../abstract_nodes/ast.dart';
import '../utils/extensions.dart';

/// _List represents a list of [ListItem] AST nodes.
/// List can be used where flow content is expected.
/// Its content model is list content.
/// https://github.com/syntax-tree/mdast#list
abstract class _List extends Parent {
  _List({
    required super.position,
    required super.children,
    this.ordered = false,
    this.spread = false,
    super.attributes,
  });

  /// An ordered field can be present. It represents
  /// that the items have been intentionally ordered (when true),
  /// or that the order of items is not important (when false or not present).
  final bool? ordered;

  /// A spread field can be present. It represents that one or more of its
  /// children are separated with a blank line from its siblings (when true),
  /// or not (when false or not present).
  final bool? spread;
}

/// An AST node that represents an ordered [_List]
class OrderedList extends _List {
  @override
  final String type = 'orderedList';

  OrderedList({
    required super.position,
    required super.children,
    super.spread,
    super.ordered = true,
    required this.start,
    super.attributes,
  }) : assert(ordered!);

  /// A start field can be present. It represents,
  /// when the ordered field is true, the starting number of the list.
  ///https://github.com/syntax-tree/mdast#list
  final int start;

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      if (ordered != null) 'ordered': ordered,
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

/// An AST node that represents an unordered bullet [_List]
class BulletList extends _List {
  @override
  String get type => 'bulletList';

  BulletList({
    required super.position,
    required super.children,
    super.ordered = false,
    super.spread,
    super.attributes,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      if (ordered != null) 'ordered': ordered,
      if (spread != null) 'spread': spread,
      'position': {
        'start': position.start.toMap(),
        'end': position.end.toMap(),
      },
      'children': children.map((child) => child.toMap()),
      'attributes': attributes,
    };
  }
}
