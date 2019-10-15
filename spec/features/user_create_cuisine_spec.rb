require 'rails_helper'

feature 'user create cuisine' do
  scenario 'successfully' do
    visit root_path

    click_on 'Cozinhas'
    click_on 'Criar nova cozinha'
    
    fill_in 'Nome', with: 'Árabe'
    fill_in 'Descrição', with: 'Comida tradicional Árabe.'
    click_on 'Enviar'
    
    expect(page).to have_css('h1', text: 'Árabe')
    expect(page).to have_css('p', text: 'Comida tradicional Árabe.')
  end
  
  scenario 'and edit' do
    cuisine = create(:cuisine, name: 'Árabe',
                               description: 'Comida tradicional Árabe.')
    
    visit root_path
    
    click_on 'Cozinhas'
    click_on 'Árabe'
    click_on 'Editar'
    
    fill_in 'Nome', with: 'Indiana'
    fill_in 'Descrição', with: 'Comida tradicional Indiana.'
    
    click_on 'Enviar'
    
    expect(page).to have_css('h1', text: 'Indiana')
    expect(page).to have_css('p', text: 'Comida tradicional Indiana.')
  end
  
  scenario 'and validate fields' do
    visit root_path
    click_on 'Cozinhas'
    click_on 'Criar nova cozinha'
    
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Enviar'
    
    expect(page).to have_content('Não foi possível salvar a cozinha')
  end
end