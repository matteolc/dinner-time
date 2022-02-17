# frozen_string_literal: true

Rails.application.routes.draw do
  root 'application#index'
  resources :recipes, only: :index
end
