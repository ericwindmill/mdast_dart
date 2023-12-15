import '../abstract_nodes/ast.dart';
import '../mixins/association.dart';
import '../mixins/resource.dart';

/// Definition represents a resource.
/// Definition should be associated with LinkReferences and ImageReferences.
class Definition extends Node implements Association, Resource {
  @override
  String get type => 'definition';

  Definition({
    required this.identifier,
    this.label,
    this.title,
    required this.url,
    super.position,
    super.attributes,
  });

  @override
  final String identifier;

  @override
  final String? label;

  @override
  final String? title;

  @override
  final String url;

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      if (label != null) 'label': label,
      if (title != null) 'title': title,
      'url': url,
      'attributes': attributes,
    };
  }
}
