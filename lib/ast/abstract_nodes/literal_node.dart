import '../abstract_nodes/ast.dart';
import '../utils/extensions.dart';

/// Inline AST nodes that only contain content
abstract class Literal extends Node {
  Literal({
    required super.position,
    required this.value,
    super.attributes,
  });

  final String value;

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'value': value,
      'position': {
        'start': position.start.toMap(),
        'end': position.end.toMap(),
      },
      'attributes': attributes,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Literal &&
          type == other.type &&
          position.start == other.position.start &&
          position.end == other.position.end &&
          runtimeType == other.runtimeType &&
          value == other.value;
}
