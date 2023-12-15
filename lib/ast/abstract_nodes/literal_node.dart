import '../abstract_nodes/ast.dart';
import '../utils/extensions.dart';

/// Inline AST nodes that only contain content
abstract class Literal extends Node {
  Literal({
    super.position,
    required this.value,
    super.attributes,
  });

  final String value;

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'value': value,
      if (position != null)
        'position': {
          'start': position!.start.toMap(),
          'end': position!.end.toMap(),
        },
      'attributes': attributes,
    };
  }
}
