/// Alternative represents a node with a fallback
abstract class Alternative {
  /// An alt field should be present. It represents equivalent content for
  /// environments that cannot represent the node as intended.
  final String? alt;

  Alternative({this.alt});
}
