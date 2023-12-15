import '../abstract_nodes/ast.dart';
import '../mixins/resource.dart';
import '../utils/extensions.dart';

/// Link represents a hyperlink within text.
///
/// https://github.com/syntax-tree/mdast#link
class Link extends Parent implements Resource {
  @override
  String get type => 'type';

  Link({
    super.position,
    super.children,
    required this.url,
    this.title,
    super.attributes,
  });

  @override
  final String? title;

  @override
  final String url;

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'url': url,
      if (title != null) 'title': title,
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
