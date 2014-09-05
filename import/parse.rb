require "bundler"
Bundler.require
require "erb"
require "ostruct"

cookbook = Nori.new.parse(IO.read("recipes.xml"))

class Recipe
  def initialize(hash)
    @title = hash["title"]
    @category = hash["category"]
    @instructions = hash["instructions"]
    @ingredient_groups = [hash["ingredients"]].flatten
  end

  def parameterized_title
    sep = "-"
    @title.downcase.gsub(/\'/, '').gsub(/[^a-z0-9]+/, sep).gsub(/#{sep}{2,}/, '')
  end

  def to_markdown
    ERB.new(IO.read("recipe.md.erb"), nil, "-").result(binding)
  end
end

cookbook["cookbook"]["recipe"].each do |recipe_hash|
  recipe = Recipe.new(recipe_hash)
  IO.write(File.join("..", "#{recipe.parameterized_title}.md"), recipe.to_markdown)
end

