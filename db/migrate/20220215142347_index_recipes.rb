class IndexRecipes < ActiveRecord::Migration[6.1]
  def change
    add_index :recipes, :id

    execute <<-SQL
      CREATE INDEX recipes_ingredients_en_idx ON recipes USING GIN (to_tsvector('ts_unaccent_en',f_array_to_string(ingredients)));
    SQL

    execute <<-SQL
      CREATE INDEX recipes_ingredients_fr_idx ON recipes USING GIN (to_tsvector('ts_unaccent_fr',f_array_to_string(ingredients)));
    SQL
    
    execute <<-SQL
      CREATE INDEX recipes_ingredients_idx ON recipes USING GIN (to_tsvector('ts_unaccent',f_array_to_string(ingredients)));
    SQL

  end
end
