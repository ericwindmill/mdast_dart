/// Visitor pattern for the AST.
///
/// Renderers or other AST transformers should implement this.
abstract class Visitor<T, E> {
  /// Called when an Element has been reached, before its children have been
  /// visited.
  ///
  /// Returns `false` to skip its children.
  bool visitElementBefore(E element);

  /// Called when an Element has been reached, after its children have been
  /// visited.
  ///
  /// Will not be called if [visitElementBefore] returns `false`.
  void visitElementAfter(E element);

  /// Called when a Text node has been reached.
  void visitText(T text);
}
