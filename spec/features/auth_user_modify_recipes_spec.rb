require 'rails_helper'

feature 'auth user modify recipes' do
  scenario 'and create succesfully' do
    user = User.create(email: 'auth@auth.com', password: '12345678')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    
    recipe = Recipe.create(title: 'Torta de Morango', recipe_type: recipe_type, user: user, cuisine: cuisine, ingredients: 'Trigo e Morango', cook_time: 50, cook_method: 'Misture os ingredientes', difficulty: 'Média')

    expect(recipe.user).to eq user
  end
end

