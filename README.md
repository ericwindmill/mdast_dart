# Mdast Dart

**M**ark**d**own **A**bstract **S**yntax **T**ree.

This package transforms markdown into an [intermediate representation][],
AST nodes. The goal of this is to make written content easier to
work with in Flutter.

The AST nodes in this package are a Dart 
implementation of [mdast][].

## Why use this package

Currently, creating great user experiences in
Flutter from Markdown source files isn't easy. Flutter, unlike HTML and CSS,
applies styling as the widgets are built, rather than during a second pass. 
The consequence of this is that you can't create highly customized widgets from
markdown source by applying html classes and id's.

This package attempts to solve that problem by transforming markdown into an AST
of Dart objects, making it easier to work with the data into your Flutter app.

**Note:** This package is not a renderer. It will not create widgets for you. If you just
want to render markdown in your Flutter app, and you aren't concerned with 
making a highly customized experience, you should use [flutter_markdown][].

## Usage

Using this package most likely requires two steps:

1. In a build pre-process, you transform your markdown source into mdast nodes.
```
// TODO(ewindmill): update this example when CLI is complete
dart run script filename.md
```

2. In your Flutter app, you render widgets based on the AST nodes.

```dart
// TODO(ewindmill): update this example when /example is complete
```

## Mdast

**mdast** is a specification for representing markdown in a [syntax
tree][syntax-tree]. It can represent several flavours of [markdown][], 
such as [CommonMark][] and [GitHub Flavored Markdown][gfm].

Note that mdast was created with and for TypeScript, so this package
a 1-to-1 implementation. Namely, this package doesn't
include [Content Models](https://github.com/syntax-tree/mdast#content-model).

#### Implemented mdast nodes

- Nodes (abstract)
    - Node
    - Parent
    - Child
- Nodes
    - Blockquote
    - Break
    - Code
    - Definition
    - Emphasis
    - Heading
    - Html
    - Image
    - ImageReference
    - InlineCode
    - Link
    - LinkReference
    - List
    - ListItem
    - Paragraph
    - Root
    - Strong
    - Text
    - ThematicBreak
- Mixins (See [mdast spec](https://github.com/syntax-tree/mdast#mixin) for information)
    - Alternative
    - Association
    - Reference
    - Resource


## Markdown transformer

In its current implementation, the markdown-to-mdast transformer 
is built on top of the [markdown package][]. 
This package does not parse the markdown itself. 
Rather, the markdown package transforms the markdown into its own AST, which
is a list of `Element` objects that have an html `tag`. This package 
transforms that AST into an mdast AST. 

There are several limitations to this approach, which are discussed in the 
[Missing Pieces](/#missing-pieces) section.

The following html tags are currently supported. This covers [CommonMark][], 
plus footnotes. 

* blockquote
* pre
* code
* h1
* h2
* h3
* h4
* h5
* h6
* hr
* ol
* ul
* li
* p
* a
* em
* strong
* img
* br
* section
* sup

**Any markdown syntax that the [markdown package][] does not parse into 
an `Element` with these tags will break the markdown-to-mdast transformer.**


## Missing Pieces

This package is very much in it's version 0.0.1. It is currently a 
proof-of-concept, meant to help determine how viable it is to turn a well-defined
AST into a tree of Flutter widgets.

Thus, the following major feature are missing from this package:

### Mdast_dart should implement its own markdown parser.

[mdast][] is a specification that, if fully implemented, could theoretically
be converted back into markdown. The current version of this package
is not suitable to transform an mdast AST back into markdown 
_in it's exact original form_. 

First, because the [markdown package][] doesn't
provide positional information of the individual nodes in it's AST. Therefor,
you cannot re-render markdown and be sure that every bit of content is in the
same position.

If you are concerned with parsing markdown into an AST, and back into markdown,
you can use the [markdown-dart pub package][].

Secondly, the markdown package's AST isn't concerned with ImageReferences
or LinkReferences. 

For example, consider this markdown:

```text
This package transforms markdown into an 
[intermediate representation](https://en.wikipedia.org/wiki/Intermediate_representation),
AST nodes. The goal of this is to make written content easier to
work with in Flutter.
```

vs this markdown:

```text
This package transforms markdown into an [intermediate representation][],
AST nodes. The goal of this is to make written content easier to
work with in Flutter.

The AST nodes in this package are a Dart implementation of mdast.

[intermediate representation]: https://en.wikipedia.org/wiki/Intermediate_representation

```

The [markdown package][]  indiscriminately parses the links in both examples 
to the equivalent `Element`s with the same "img" tag.
The same is true of Images and Image references.  
This makes sense if your goal is to render HTML.

Therefor, in its current implementation, this package has no way to determine
if the link was inline or a link reference, and therefor never adds a 
`LinkReference` to the resulting AST.


### Planned updates, hinging on usefulness of proof of concept

- [] Fork [markdown package][] and refactor it to produce mdast nodes directly.
- [] Forked version should also convert mdast nodes into HTML.
- [] Add AST nodes for common markdown flavors, such as Github Flavored Markdown.
- [] Add build_runner to transformer
- [] Add hooks into build process, allowing users to define custom markdown syntax.

[flutter_markdown]: https://github.com/flutter/packages/tree/main/packages/flutter_markdown
[markdown package]: https://pub.dev/package/markdown
[markdown-dart pub package]: https://github.com/DrafaKiller/Markdown-dart/tree/main 
[intermediate representation]: https://en.wikipedia.org/wiki/Intermediate_representation
[mdast]: https://github.com/syntax-tree/mdast
[markdown]: https://daringfireball.net/projects/markdown/
[commonmark]: https://commonmark.org
[gfm]: https://github.github.com/gfm/