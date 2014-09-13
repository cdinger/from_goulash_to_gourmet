#!/bin/bash

# order categories
categories=$(grep -ho 'categories\:.*' ../recipes/*.md | sort | uniq)

sortedfilenames=$(while read -r category; do
  grep -l "$category" ../recipes/*.md
done <<< "$categories")

#echo "$sortedfilenames"
echo '<cookbook>' > recipes.xml

while read -r filename; do
  echo "converting to XML: $filename"
  pandoc "$filename" --template=xml.template >> recipes.xml
done <<< "$sortedfilenames"

echo '</cookbook>' >> recipes.xml

./fop/fop -xml recipes.xml -xsl cookbook.xsl -pdf cookbook.pdf -c config.xml && open cookbook.pdf
