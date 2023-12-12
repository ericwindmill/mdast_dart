import '../abstract_nodes/ast.dart';
import '../utils/extensions.dart';

class CodeBlock extends Parent {
  @override
  String get type => 'code';

  CodeBlock({
    required super.position,
    required super.children,
    this.lang,
    this.meta,
    super.attributes,
  });

  /// A lang field can be present. It represents the language of computer
  /// code being marked up.
  final String? lang;

  /// If the lang field is present, a meta field can be present.
  /// It represents custom information relating to the node.
  final String? meta;

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'children': children,
      if (lang != null) 'lang': lang,
      if (meta != null) 'meta': meta,
      'position': {
        'start': position.start.toMap(),
        'end': position.end.toMap(),
      },
      'attributes': attributes,
    };
  }

  List<Object?> get props => throw UnimplementedError();
}
