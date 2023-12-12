///Resource represents a reference to resource.
abstract class Resource {
  /// A url field must be present. It represents a URL to the referenced
  /// resource.
  final String url;

  /// A title field can be present. It represents advisory information for
  /// the resource, such as would be appropriate for a tooltip.
  final String? title;

  Resource({required this.url, this.title});
}
