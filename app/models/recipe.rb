# frozen_string_literal: true

# == Schema Information
#
# Table name: recipes
#
#  id              :bigint           not null, primary key
#  author          :string           not null
#  author_tip      :string           not null
#  budget          :string           not null
#  cook_time       :string           not null
#  difficulty      :string           not null
#  image           :string           not null
#  ingredients     :string           not null, is an Array
#  name            :string           not null
#  nb_comments     :string           not null
#  people_quantity :string
#  prep_time       :string           not null
#  rate            :string
#  tags            :string           not null, is an Array
#  total_time      :string           not null
#
# Indexes
#
#  index_recipes_on_id         (id)
#  recipes_ingredients_en_idx  (to_tsvector('ts_unaccent_en'::regconfig, f_array_to_string((ingredients)::text[]))) USING gin
#

# https://github.com/remaudcorentin-dev/python-marmiton
#
# name: name of the recipe
# ingredients: string list of the recipe ingredients (including quantities)
# steps: string list of each step of the recipe
# image: if exists, image of the recipe (url).
# cook_time: string, cooking time of the recipe
# prep_time: string, estimated preparation time of the recipe
# total_time: string, estimated total time of the recipe (cooking + preparation time)
# author: string, name of the author of the recipe
# nb_comments: string, number of comments/rates left by users
# people_quantity: string, number of people the recipie is made for
# budget: string, indicate the category of budget according to the website
# difficulty: string, indicate the category of difficulty according to the website
# rate: string, rate of the recipe out of 5
# author_tip: string, note or tip left by the author
# tags: string list, tags of the recipe

class Recipe < ApplicationRecord
  
  scope :with_ingredients_en_sql_ranked, lambda { |*ingredients|
    find_by_sql(
"SELECT recipes.*
FROM recipes
    INNER JOIN (
      SELECT recipes.id AS pg_search_id,
      #{Search.ts_rank_string(Search.ts_vector_unaccent_string('ingredients'), ingredients.join(' | '))} AS rank
      FROM recipes
      WHERE (#{Search.ts_vector_query_string(Search.ts_vector_unaccent_string('ingredients'), ingredients.join(' | '))})
    ) AS pg_search_result    
ON recipes.id = pg_search_result.pg_search_id
ORDER BY pg_search_result.rank DESC"
) }

  scope :search_scope_en_sql_ranked, lambda { |q_string| 
    sanitized_q = Search.sanitize_q(q_string)
    sanitized_q.blank? ? 
      find_by_sql("SELECT recipes.* FROM recipes") : 
      with_ingredients_en_sql_ranked(sanitized_q)
  }


end
