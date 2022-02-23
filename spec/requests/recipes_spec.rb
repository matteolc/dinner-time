# frozen_string_literal: true

require 'rails_helper'
require 'net/http'

describe 'Recipes', type: :request do
  let!(:recipes) { 10.times.map { create(:recipe) } }

  describe 'GET /' do
    it 'redirects to recipes' do
      get root_path
      expect(response).to have_http_status(302)
    end
  end

  describe 'GET /recipes' do
    it 'responds without failing' do
      get recipes_path
      expect(response).to have_http_status(200)
      expect(response.body).to include(recipes.sample.name)
    end

    it 'responds with a search result' do
      recipe = recipes.sample
      ingredients = get_recipe_ingredients(recipe)
      params = URI.encode_www_form({ 'q': ingredients.sample })
      get "#{recipes_path}?#{params}"
      expect(response).to have_http_status(200)
      expect(response.body).to include(recipe.name)
    end
  end

  def get_recipe_ingredients(recipe)
    recipe.ingredients.join(' ').split(' ')
  end
end
