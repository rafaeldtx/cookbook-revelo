require 'rails_helper'

feature 'user create recipe' do
  scenario 'successfully' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    user = User.create(email: 'admin@admin.com', password: '12345678')
    RecipeType.create(name: 'Sobremesa')
    RecipeType.create(name: 'Entrada')
    Cuisine.create(name: 'Árabe', description: 'Comida Tradicional Árabe')

    # simula a ação do usuário
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Receitas'
    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Tabule'
    select 'Entrada', from: 'Tipo da Receita'
    select 'Árabe', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado,
                                   azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a
                                    gosto.'
    click_on 'Enviar'


    # expectativas
    expect(page).to have_css('h1', text: 'Tabule')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p',  text: 'Entrada')
    expect(page).to have_css('p',  text: 'Árabe')
    expect(page).to have_css('p',  text: 'Fácil')
    expect(page).to have_css('p',  text: '45 minutos')
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p',  text: 'Trigo para quibe, cebola, tomate
                                          picado, azeite, salsinha')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p',  text: 'Misturar tudo e servir. Adicione limão
                                          a gosto.')
  end

  scenario 'and edit' do
    user = User.create(email: 'admin@admin.com', password: '12345678')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    other_recipe_type = RecipeType.create(name: 'Entrada')
    cuisine = Cuisine.create(name: 'Brasileira',
                             description: 'Comida tradicional Brasileira.')
    other_cuisine = Cuisine.create(name: 'Árabe',
                                   description: 'Comida tradicional Árabe.')

    recipe = Recipe.create(title: 'Bolo de Cenoura', user: user,
                           recipe_type: recipe_type, cuisine: cuisine,
                           ingredients: 'Trigo, Ovos e Cenoura',
                           difficulty: 'Médio', cook_time: 50,
                           cook_method: 'Misture os ingredientes')

    login_as(user, :scope => :user)
    visit root_path

    click_on 'Receitas'
    click_on 'Bolo de Cenoura'
    click_on 'Editar'

    fill_in 'Título', with: 'Tabule'
    select other_recipe_type.name, from: 'Tipo da Receita'
    select other_cuisine.name, from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado,
                                   azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão
                                    a gosto.'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Tabule')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Árabe')
    expect(page).to have_css('p', text: 'Fácil')
    expect(page).to have_css('p', text: "45 minutos")
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: `Trigo para quibe, cebola, tomate
                                          picado, azeite, salsinha`)
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p',  text: `Misturar tudo e servir. Adicione limão
                                          a gosto.`)
  end

  scenario 'and validate fields' do
    user = User.create(email: 'admin@admin.com', password: '12345678')
    Cuisine.create(name: 'Árabe', description: 'Comida tradicional Árabe')

    # simula a ação do usuário
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: ''
    select '', from: 'Cozinha'
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível salvar a receita')
  end
end
