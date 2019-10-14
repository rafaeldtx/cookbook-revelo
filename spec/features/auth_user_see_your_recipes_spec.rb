require 'rails_helper'

feature 'auth user see recipes list' do
  scenario 'by access my recipes' do
    user = User.create!(email: 'admin@admin.com', password: '12345678')
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    cuisine = Cuisine.create!(name: 'Brasileira', description: 'Comida típica brasileira')
    recipe = Recipe.create!(title: 'Torta de Morango', recipe_type: recipe_type, user: user, cuisine: cuisine, ingredients: 'Trigo e Morango', cook_time: 50, cook_method: 'Misture os ingredientes', difficulty: 'Média')
    recipe = Recipe.create!(title: 'Bolo de Cenoura', recipe_type: recipe_type, user: user, cuisine: cuisine, difficulty: 'Difícil', ingredients: 'Trigo, Cenoura', cook_method: 'Misture os ingredientes', cook_time: 80)

    login_as(user, :scope => :user)
    visit root_path
    click_on 'Receitas'
    click_on 'Minhas Receitas'

    expect(page).to have_css('h1', text: 'Minhas Receitas')  
    expect(page).to have_link('Torta de Morango')  
    expect(page).to have_css('h4', text: 'Tipo: Sobremesa')  
    expect(page).to have_link('Bolo de Cenoura')  
    expect(page).to have_css('h4', text: 'Tipo: Sobremesa')
  end
end