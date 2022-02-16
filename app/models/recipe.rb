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

    # unaccent everything
    scope :with_ingredients, ->(*ingredients) { 
        where("to_tsvector(unaccent(ARRAY_TO_STRING(ingredients,','))) @@ to_tsquery(unaccent(?))", ingredients.join(' & ')) 
    }    

    # Search recipes with ingredients, with caching
    # q can be an empty string (no filter is applied)
    def self.search(q)
        raise StandardError.new 'q is not a string' if !(q.is_a? String)
        sanitized_q = sanitize_q(q)
        ids = Rails.cache.fetch(sanitized_q, expires_in: 12.hours) do
            results = all
            results = results.with_ingredients(sanitized_q) unless sanitized_q.blank?
            results.pluck(:id) 
        end   
        where(id: ids)   
    rescue => e
        puts "Error: #{e}"
        none
    end        

    # enforce some validation rules on user input
    def self.sanitize_q(q)
        PragmaticTokenizer::Tokenizer.new.tokenize(I18n.transliterate(q))
            .map {|word| Search.keep_only_letters(word) }
            .map {|word| word.split(' ') }                   
            .flatten
            .map {|word| Search.strip_sql_reserved_words(word) }
            .reject(&:blank?)
    end    


end
