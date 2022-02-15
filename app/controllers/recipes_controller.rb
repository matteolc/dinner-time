class RecipesController < ApplicationController

  include Pagy::Backend

  # GET /recipes or /recipes.json
  def index 
    @pagy, @recipes = pagy(Recipe.search(with_ingredients)) 
    @count, @items, @pages, @page = pagy_metadata(@pagy).values_at(:count, :items, :pages, :page)
  end

  private

    def with_ingredients
      params.fetch(:with_ingredients, []).reject(&:blank?)
    end

end
