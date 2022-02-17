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
#  recipes_ingredients_fr_idx  (to_tsvector('ts_unaccent_fr'::regconfig, f_array_to_string((ingredients)::text[]))) USING gin
#  recipes_ingredients_idx     (to_tsvector('ts_unaccent'::regconfig, f_array_to_string((ingredients)::text[]))) USING gin
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
    scope :with_ingredients_en, ->(*ingredients) { 
        where("to_tsvector('ts_unaccent_en', f_array_to_string(ingredients)) @@ to_tsquery('ts_unaccent_en', ?)", ingredients.join(' & ')) 
    }    
    scope :with_ingredients_fr, ->(*ingredients) { 
        where("to_tsvector('ts_unaccent_fr', f_array_to_string(ingredients)) @@ to_tsquery('ts_unaccent_fr', ?)", ingredients.join(' & ')) 
    }    
    scope :with_ingredients, ->(*ingredients) { 
        where("to_tsvector('ts_unaccent', f_array_to_string(ingredients)) @@ to_tsquery('ts_unaccent', ?)", ingredients.join(' & ')) 
    }            

    # Search recipes with ingredients, with caching
    # q can be an empty string (no filter is applied)
    def self.search(q)
        raise StandardError.new 'q is not a string' if !(q.is_a? String)
        sanitized_q = sanitize_q(q)
        cache_key = sanitized_q.blank? ? Recipe.name : sanitized_q.join('-')
        ids = Rails.cache.fetch(cache_key, expires_in: 12.hours) do
            results = all
            results = results.with_ingredients_en(sanitized_q) unless sanitized_q.blank?
            results.pluck(:id) 
        end   
        where(id: ids)   
    rescue => e
        puts "Error: #{e}"
        none
    end        

    # enforce some validation rules on user input
    # 1. remove all accents (transliterate)
    # 2. tokenize string in words
    # 3. remove any character that is not a letter
    # 4. remove any reserved sql words
    # 5. remove any blank values
    def self.sanitize_q(q)
        PragmaticTokenizer::Tokenizer.new({
            language: :fr,
            punctuation: :none,          # Removes all punctuation from the result.
            numbers: :none,              # Removes all tokens that include a number from the result (including Roman numerals)
            remove_emoji: true,          # Removes any token that contains an emoji.
            remove_urls: true,           # Removes any token that contains a URL.
            clean: true,                 # Removes tokens consisting of only hypens, underscores, or periods as well as some special characters (®, ©, ™). Also removes long tokens or tokens with a backslash.
            hashtags: :keep_and_clean,   # Removes the hashtag (#) prefix from the token.
            mentions: :keep_and_clean,   # Removes the mention (@) prefix from the token.
            classic_filter: true,        # Removes dots from acronyms and 's from the end of tokens.
            minimum_length: 2            # The minimum number of characters a token should be.
        })
            .tokenize(I18n.transliterate(q))
            .map {|word| Search.keep_only_letters(word) }    
            .flatten
            .map {|word| Search.strip_sql_reserved_words(word) }
            .reject(&:blank?)
    end    


end
