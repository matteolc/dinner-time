Rails.application.routes.draw do
  root 'application#index'  
  resources :recipes, only: :index
end
