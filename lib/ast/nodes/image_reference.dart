import '../abstract_nodes/ast.dart';
import '../mixins/alternative.dart';
import '../mixins/reference.dart';
import '../utils/extensions.dart';

class ImageReference extends Node implements Reference, Alternative {
  @override
  String get type => 'imageReference';

  ImageReference({
    required this.identifier,
    required this.referenceType,
    super.position,
    this.alt,
    this.label,
    super.attributes,
  });

  @override
  final String identifier;

  @override
  final String? label;

  @override
  final ReferenceType referenceType;

  @override
  String? alt;

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'identifier': identifier,
      if (alt != null) 'alt': alt,
      if (label != null) 'label': label,
      if (position != null)
        'position': {
          'start': position!.start.toMap(),
          'end': position!.end.toMap(),
        },
      'attributes': attributes,
    };
  }
}
