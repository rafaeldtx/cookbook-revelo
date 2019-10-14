require 'rails_helper'

feature 'auth user modify recipes' do
  scenario 'and create succesfully' do
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)

    recipe = create(:recipe, user: user, recipe_type: recipe_type,
                             cuisine: cuisine)

    expect(recipe.user).to eq user
  end

  scenario 'and not auth failed' do
    user = User.create(email: 'auth@auth.com', password: '12345678')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    
    visit new_recipe_path

    expect(current_path).to eq new_user_session_path
  end

  context 'and only modify your own recipes' do
    scenario 'by navigate' do
      user = User.create(email: 'admin@admin.com', password: '123456')
      other_user = User.create(email: 'admin2@admin.com', password: '123456')
  
      recipe_type = RecipeType.create(name: 'Sobremesa')
      cuisine = Cuisine.create(name: 'Brasileira',
                               description: 'Cozinha Típica Brasileira')
      recipe = Recipe.create(title: 'Bolo de Chocolate', user: other_user,
                             recipe_type: recipe_type, cuisine: cuisine,
                             ingredients: 'Chocolate e bolo',
                             difficulty: 'Díficil', cook_time: 40,
                             cook_method: 'Misture os ingredientes')
  
      visit root_path
      click_on 'Receitas'
      click_on 'Bolo de Chocolate'
  
      expect(page).not_to have_link('Editar')
    end

    scenario 'by direct path' do
      user = User.create!(email: 'admin@admin.com', password: '123456')
      other_user = User.create!(email: 'admin2@admin.com', password: '123456')
  
      recipe_type = RecipeType.create!(name: 'Sobremesa')
      cuisine = Cuisine.create!(name: 'Brasileira',
                                description: 'Cozinha Típica Brasileira')
      recipe = Recipe.create!(title: 'Bolo de Chocolate', user: other_user,
                              recipe_type: recipe_type, cuisine: cuisine,
                              ingredients: 'Chocolate e bolo',
                              difficulty: 'Díficil', cook_time: 40,
                              cook_method: 'Misture os ingredientes')

      login_as(user, :scope => :user)
      visit edit_recipe_path(recipe)
  
      expect(current_path).to eq root_path
    end
  end
end

