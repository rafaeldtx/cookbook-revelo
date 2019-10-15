require 'rails_helper'

feature 'User update recipe' do
  scenario 'successfully' do
    user = create(:user)
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    cuisine = create(:cuisine)
    create(:recipe_type, name: 'Entrada')

    create(:recipe, title: 'Bolodecenoura', recipe_type: recipe_type,
                    cuisine: cuisine, user: user)

    # simula a ação do usuário
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Bolodecenoura'
    click_on 'Editar'

    fill_in 'Título', with: 'Bolo de Cenoura'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Bolo de Cenoura')
  end

  scenario 'and must fill in all fields' do
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    create(:recipe, recipe_type: recipe_type, cuisine: cuisine, user: user,
                    title: 'Bolo de Cenoura')

    # simula a ação do usuário
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Bolo de Cenoura'
    click_on 'Editar'

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
