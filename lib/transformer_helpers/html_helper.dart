/// Copied from dart-lang/markdown package: https://github.com/dart-lang/markdown

/// A [String] pattern to match a named tag like `<table>` or `</table>`.
const namedTagDefinition =
// Opening tag begins.
    '<'

// Tag name.
    '[a-z][a-z0-9-]*'

// Attribute begins, see
// https://spec.commonmark.org/0.30/#attribute.
    r'(?:\s+'

// Attribute name, see
// https://spec.commonmark.org/0.30/#attribute-name.
    '[a-z_:][a-z0-9._:-]*'

//
    '(?:'
// Attribute value specification, see
// https://spec.commonmark.org/0.30/#attribute-value-specification.
    r'\s*=\s*'

// Attribute value, see
// https://spec.commonmark.org/0.30/#unquoted-attribute-value.
    r'''(?:[^\s"'=<>`]+?|'[^']*?'|"[^"]*?")'''

// Attribute ends.
    ')?)*'

// Opening tag ends.
    r'\s*/?>'

// Or
    '|'

// Closing tag, see
// https://spec.commonmark.org/0.30/#closing-tag.
    r'</[a-z][a-z0-9-]*\s*>';

/// A pattern to match the start of an HTML block.
///
/// The 7 conditions here correspond to the 7 start conditions in the Commonmark
/// specification one by one: https://spec.commonmark.org/0.30/#html-block.
final htmlBlockPattern = RegExp(
  '^ {0,3}(?:'
  '<(?<condition_1>pre|script|style|textarea)'
  r'(?:\s|>|$)'
  '|'
  '(?<condition_2><!--)'
  '|'
  r'(?<condition_3><\?)'
  '|'
  '(?<condition_4><![a-z])'
  '|'
  r'(?<condition_5><!\[CDATA\[)'
  '|'
  '</?(?<condition_6>address|article|aside|base|basefont|blockquote|body|'
  'caption|center|col|colgroup|dd|details|dialog|dir|DIV|dl|dt|fieldset|'
  'figcaption|figure|footer|form|frame|frameset|h1|h2|h3|h4|h5|h6|head|'
  'header|hr|html|iframe|legend|li|link|main|menu|menuitem|nav|noframes|ol|'
  'optgroup|option|p|param|section|source|summary|table|tbody|td|tfoot|th|'
  'thead|title|tr|track|ul)'
  r'(?:\s|>|/>|$)'
  '|'

  // Here we are more restrictive than the Commonmark definition (Rule #7).
  // Otherwise some raw HTML test cases will fail, for example:
  // https://spec.commonmark.org/0.30/#example-618.
  // Because if a line is treated as an HTML block, it will output as a
  // Text node directly, and the RawHtmlSyntax will not have a chance to
  // validate if this HTML tag is legal or not.
  '(?<condition_7>(?:$namedTagDefinition)\\s*\$))',
  caseSensitive: false,
);
