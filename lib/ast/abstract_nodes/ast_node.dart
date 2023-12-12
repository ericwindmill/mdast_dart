import 'package:source_span/source_span.dart';

typedef Position = ({SourceLocation start, SourceLocation end});

/// Base class for  MdAST items
/// Implements unist specification https://github.com/syntax-tree/unist#nodes
abstract class Node {
  Node({
    required this.position,
    this.attributes = const {},
  });

  /// The markdown type, such as 'headline'
  /// The type field is a non-empty string representing the variant of a node.
  /// This field can be used to determine the type a node implements.
  String get type;

  final Position position;

  /// Added to allow implementers to extend the functionality
  Map<String, dynamic> attributes;

  Map<String, dynamic> toMap();
}
