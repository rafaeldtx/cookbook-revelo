require 'rails_helper'

feature 'auth user see recipes list' do
  scenario 'by access my recipes' do
    user = create(:user)
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    cuisine = create(:cuisine)
    recipe = create(:recipe, recipe_type: recipe_type, user: user,
                             cuisine: cuisine, title: 'Bolo de Cenoura')
    other_recipe = create(:recipe, recipe_type: recipe_type, user: user,
                                   cuisine: cuisine, title: 'Torta de Morango')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Receitas'
    click_on 'Minhas Receitas'

    expect(page).to have_css('h1', text: 'Minhas Receitas')  
    expect(page).to have_css('h4', text: 'Tipo: Sobremesa')  
    expect(page).to have_link('Torta de Morango')  
    expect(page).to have_link('Bolo de Cenoura')
  end
end