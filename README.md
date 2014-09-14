# From Goulash to Gourmet

A book of my grandmother's family recipes.

## Editing recipes

The master recipes are markdown files in the `recipes` directory. Just follow the pattern you see in the other files, namely:

### YAML front-matter

`title` and `category` (chapter) go a recipe's YAML front matter for natice compatibility with Jekyll. For building the PDF and 
other artifacts, these are tranlsated accordingly.

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

