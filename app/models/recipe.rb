# == Schema Information
#
# Table name: recipes
#
#  id                 :bigint           not null, primary key
#  author             :string           not null
#  author_tip         :string           not null
#  budget             :string           not null
#  cook_time          :string           not null
#  difficulty         :string           not null
#  image              :string           not null
#  ingredients        :string           not null, is an Array
#  name               :string           not null
#  nb_comments        :string           not null
#  people_quantity    :string
#  prep_time          :string           not null
#  rate               :string
#  tags               :string           not null, is an Array
#  total_time         :string           not null
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

    scope :with_ingredients, ->(*ingredients) { 
        where("to_tsvector(unaccent(ARRAY_TO_STRING(ingredients,','))) @@ to_tsquery(unaccent('#{ingredients.join(' & ')}'))") 
    }    
    
    # search with cache
    def self.search(with_ingredients_params)     
        ids = Rails.cache.fetch(with_ingredients_params, expires_in: 12.hours) do
            results = all
            results = results.with_ingredients(with_ingredients_params) unless with_ingredients_params.blank?
            results.pluck(:id) 
        end   
        where(id: ids)
    end    


end
