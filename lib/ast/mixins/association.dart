/// Association represents an internal relation from one node to another.
///
/// Whether the value of identifier is expected to be a unique identifier or
/// not depends on the type of node (including the [Association]). An example of
/// this is that they should be unique on Definition, whereas multiple
/// [LinkReference]s can be non-unique to be associated with one definition.
abstract class Association {
  /// An identifier field must be present. It can match another node.
  /// [identifier] is a source value: character escapes and character
  /// references are not parsed. Its value must be normalized.
  ///
  /// To normalize a value, collapse markdown whitespace ([\t\n\r ]+) to a
  /// space, trim the optional initial and/or final space, and perform
  /// case-folding.
  final String identifier;

  /// A label field can be present. [label] is a
  /// string value: it works just like title on a link or a lang on code:
  /// character escapes and character references are parsed.
  final String? label;

  Association({required this.identifier, this.label});
}
