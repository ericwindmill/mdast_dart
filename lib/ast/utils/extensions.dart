import 'dart:convert';

import 'package:source_span/source_span.dart';

extension SourceLocationExtensions on SourceLocation {
  bool equals(SourceLocation other) =>
      line == other.line &&
      column == other.column &&
      other.offset == offset &&
      other.sourceUrl == sourceUrl;

  Map<String, int> toMap() => {
        'line': line,
        'column': column,
        'offset': offset,
      };
}

extension SourceSpanExtensions on SourceSpan {
  Map<String, dynamic> toMap() => {
        'start': start.toMap(),
        'end': end.toMap(),
        'text': text,
      };
}

/// Converts [object] to a JSON [String] with a 2 whitespace indent.
String _toPrettyString(Object object) =>
    const JsonEncoder.withIndent('  ').convert(object);

extension MapExtensions on Map<dynamic, dynamic> {
  String toPrettyString() => _toPrettyString(this);
}
