import '../abstract_nodes/ast.dart';
import '../mixins/alternative.dart';
import '../mixins/resource.dart';
import '../utils/extensions.dart';

class Image extends Node implements Resource, Alternative {
  @override
  String get type => 'image';

  Image({
    super.position,
    required this.url,
    this.title,
    this.alt,
    super.attributes,
  });

  @override
  final String? alt;

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
      if (alt != null) 'alt': alt,
      if (position != null)
        'position': {
          'start': position!.start.toMap(),
          'end': position!.end.toMap(),
        },
      'attributes': attributes,
    };
  }
}
