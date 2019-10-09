Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'

  resources :recipes, only: [:index, :show, :new, :create, :edit, :update]

  resources :recipe_types, only: [:index, :show, :new, :create]

  resources :cuisines, only: [:index, :new, :create, :show, :edit, :update]
end
