require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'CookBook')
    expect(page).to have_css('p', text: `Bem-vindo ao maior livro de
                                          receitas online`)
  end

  scenario 'and view recipe' do
    #cria os dados necessários
    user = create(:user)

    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipe = create(:recipe, recipe_type: recipe_type, cuisine: cuisine,
                             user: user)

    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to have_css('h3', text: recipe.title)
    expect(page).to have_css('h4', text: recipe.recipe_type.name)
  end

  scenario 'and view recipes list' do
    #cria os dados necessários
    user = create(:user)
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    other_recipe_type = create(:recipe_type, name: 'Prato principal')
    recipe = create(:recipe, recipe_type: recipe_type, cuisine: cuisine,
                             user: user)

    other_recipe = Recipe.create(:recipe, recipe_type: other_recipe_type,
                                          user: user, title: 'Feijoada',
                                          cuisine: cuisine, cook_time: 90,
                                          difficulty: 'Difícil',
                                          ingredients: 'Feijão e carnes',
                                          cook_method: 'Misture o feijão com as
                                                        carnes')

    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to have_css('h3', text: recipe.title)
    expect(page).to have_css('h4', text: recipe.recipe_type.name)

    expect(page).to have_css('h3', text: another_recipe.title)
    expect(page).to have_css('h4', text: another_recipe.recipe_type.name)
  end
end
