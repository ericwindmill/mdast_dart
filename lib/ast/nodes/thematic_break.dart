import '../abstract_nodes/ast.dart';
import '../utils/extensions.dart';

class ThematicBreak extends Node {
  @override
  String get type => 'thematicBreak';

  ThematicBreak({
    required super.position,
    super.attributes,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'position': {
        'start': position.start.toMap(),
        'end': position.end.toMap(),
      },
      'attributes': attributes,
    };
  }
}
