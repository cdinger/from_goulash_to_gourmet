# From Goulash to Gourmet

A book of my grandmother's family recipes.

## Editing recipes

The master recipes are markdown files in the `recipes` directory. Just follow the pattern you see in the other files, namely:

### YAML front-matter

`title` and `category` (chapter) go a recipe's YAML front matter for native compatibility with Jekyll. For building the PDF and other artifacts, these are tranlsated accordingly.

### Recipe structure

Every recipe should have these elements:

```markdown
---
title: Green Eggs and Ham
category: Fake food
---

## Ingredients

- 2 green eggs
- 1/4 lb green ham

## Preparation

Slice green ham and fry until lightly brown in a skillet. Fry green eggs.

Serves 1.
```

## Building a PDF

The PDF generator depends on [Pandoc](http://johnmacfarlane.net/pandoc/) and [Apache FOP](http://xmlgraphics.apache.org/fop/).
Both can be installed with Homebrew, but you'll need the newest snapshot of FOP if you want to use OTF fonts. They
haven't released a binary update since 2012.

- Install Pandoc: `brew install pandoc`
- Install FOP snapshot (from within the `export` directory): `svn co http://svn.apache.org/repos/asf/xmlgraphics/fop/trunk/ fop`
- Build FOP: `cd fop && ant`

Build (must be run from the `export` directory): `./build.sh`

