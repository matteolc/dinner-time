require 'rails_helper'

describe Recipe, type: :model do
    
    before do
        @recipes = 10.times.map { create(:recipe) } 
        print_banner
    end

    it 'should get no recipes when q is not a string' do
        search = Recipe.search([])
        expect(search.length).to eq(0)
    end

    it 'should get all recipes when q has SQL keywords' do
        search = Recipe.search(Search::RESERVED_SQL_WORDS.sample())
        expect(search.length).to eq(@recipes.length)
    end

    it 'should get all recipes' do
        search = Recipe.search('')
        expect(search.length).to eq(@recipes.length)
    end

    context 'search' do

        before do
            @recipe = @recipes.sample()
            @ingredients = get_recipe_ingredients(@recipe)
        end        

        it 'should search for recipes with an ingredient' do
            search_vector = @ingredients.sample()
            search = Recipe.search(search_vector)
            search_ids = search.map {|recipe| recipe.id}
            expect(search_ids.find { |id| id === @recipe.id }).to_not be_nil
        end   
        

        it 'should search for recipes with an ingredient, regardless of case' do
            search_vector = @ingredients.sample().upcase
            search = Recipe.search(search_vector)
            search_ids = search.map {|recipe| recipe.id}
            expect(search_ids.find { |id| id === @recipe.id }).to_not be_nil
        end        

        it 'should search for recipes with an ingredient, regardless of accent' do
            accented_recipe = create(:accented_recipe)
            search_vector = I18n.transliterate(get_recipe_ingredients(accented_recipe).sample())
            search = Recipe.search(search_vector)
            search_ids = search.map {|recipe| recipe.id}
            expect(search_ids.find { |id| id === accented_recipe.id }).to_not be_nil
        end    

        it 'should search for recipes with more ingredients' do
            search_vector = [@ingredients.sample(), @ingredients.sample()].join(' ')
            search = Recipe.search(search_vector)
            search_ids = search.map {|recipe| recipe.id}
            expect(search_ids.find { |id| id === @recipe.id }).to_not be_nil
        end    

    end

    def get_recipe_ingredients(recipe)
        recipe.ingredients.join(' ').split(' ')
    end

    def print_banner
        quote = @recipes.sample().author_tip
        puts "Testing can be tedious so here's a Chuck Norris quote: #{quote}"
    end

end