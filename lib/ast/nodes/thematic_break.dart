import '../abstract_nodes/ast.dart';
import '../utils/extensions.dart';

class ThematicBreak extends Node {
  @override
  String get type => 'thematicBreak';

  ThematicBreak({
    super.position,
    super.attributes,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      if (position != null)
        'position': {
          'start': position!.start.toMap(),
          'end': position!.end.toMap(),
        },
      'attributes': attributes,
    };
  }
}
