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
    user = User.create(email: 'admin@admin.com', password: '12345678')

    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira',
                             description: 'Comida tradicional Árabe')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: cuisine,
                           user: user, cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços
                                         pequenos, misture com o restante dos
                                          ingredientes')

    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to have_css('h3', text: recipe.title)
    expect(page).to have_css('h4', text: recipe.recipe_type.name)
  end

  scenario 'and view recipes list' do
    #cria os dados necessários
    user = User.create(email: 'admin@admin.com', password: '12345678')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira',
                             description: 'Comida tradicional Árabe')
    another_recipe_type = RecipeType.create(name: 'Prato principal')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: cuisine,
                           user: user, cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em
                                         pedaços pequenos, misture com o
                                          restante dos ingredientes')

    another_recipe = Recipe.create(title: 'Feijoada',
                                   recipe_type: another_recipe_type, user: user,
                                   cuisine: cuisine, difficulty: 'Difícil',
                                   cook_time: 90,
                                   ingredients: 'Feijão e carnes',
                                   cook_method: 'Misture o feijão
                                                  com as carnes')

    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to have_css('h3', text: recipe.title)
    expect(page).to have_css('h4', text: recipe.recipe_type.name)

    expect(page).to have_css('h3', text: another_recipe.title)
    expect(page).to have_css('h4', text: another_recipe.recipe_type.name)
  end
end
