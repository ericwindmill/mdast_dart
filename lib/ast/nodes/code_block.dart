import '../abstract_nodes/ast.dart';
import '../utils/extensions.dart';

class CodeBlock extends Literal {
  @override
  String get type => 'code';

  CodeBlock({
    super.position,
    required super.value,
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
      'value': value,
      if (lang != null) 'lang': lang,
      if (meta != null) 'meta': meta,
      if (position != null)
        'position': {
          'start': position!.start.toMap(),
          'end': position!.end.toMap(),
        },
      'attributes': attributes,
    };
  }
}
