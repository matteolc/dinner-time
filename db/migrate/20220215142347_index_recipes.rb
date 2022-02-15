class IndexRecipes < ActiveRecord::Migration[6.1]
  def change
    add_index :recipes, :id
    add_index :recipes, :ingredients

    execute <<-SQL
      CREATE INDEX recipes_ingredients_gin_idx ON recipes USING GIN (ingredients);
    SQL

  end
end
