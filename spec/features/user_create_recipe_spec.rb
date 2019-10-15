require 'rails_helper'

feature 'user create recipe' do
  scenario 'successfully' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    user = create(:user)
    create(:recipe_type, name: 'Sobremesa')
    create(:recipe_type, name: 'Entrada')
    create(:cuisine, name: 'Árabe', description: 'Comida Tradicional Árabe')

    # simula a ação do usuário
    login_as(user, scope: :user)
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
    user = create(:user)
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    other_recipe_type = create(:recipe_type, name: 'Entrada')
    cuisine = create(:cuisine)
    other_cuisine = create(:cuisine, name: 'Árabe',
                                     description: 'Comida tradicional Árabe.')

    recipe = create(:recipe, user: user, recipe_type: recipe_type,
                             cuisine: cuisine)

    login_as(user, scope: :user)
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
    user = create(:user)
    create(:cuisine)

    # simula a ação do usuário
    login_as(user, scope: :user)
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
