# frozen_string_literal: true

class RecipesController < ApplicationController
  include Pagy::Backend

  # GET /recipes or /recipes.json
  def index
    @pagy, @recipes = pagy(Recipe.search(q))
    @count, @items, @pages, @page = pagy_metadata(@pagy).values_at(:count, :items, :pages, :page)
  end

  private

  def q
    params.fetch(:q, '')
  end
end
