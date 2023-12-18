import 'package:markdown/markdown.dart' as md;

/// Thrown when the Markdown to Mdast transformer encounters
/// an [md.Element] that is cannot convert to an Mdast node
class MarkdownTransformException implements Exception {
  final String message;
  final md.Element? source;

  MarkdownTransformException(
    this.message, {
    this.source,
  });

  @override
  String toString() {
    String report = 'MarkdownTransformException: $message';

    if (source != null) {
      report += '\n Element: ${source!.tag}';
      if (source!.generatedId != null) {
        report += '\n generatedId: ${source!.generatedId}';
      }
    }

    return report;
  }
}
