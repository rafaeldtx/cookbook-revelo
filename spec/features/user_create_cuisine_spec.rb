require 'rails_helper'

feature 'user create cuisine' do
    scenario 'register cuisine' do
        visit root_path

        click_on 'Cozinhas'
        click_on 'Criar nova cozinha'

        fill_in 'Nome', with: 'Árabe'
        fill_in 'Descrição', with: 'Comida tradicional Árabe.'
        click_on 'Enviar'

        expect(page).to have_css('h1', text: 'Árabe')
        expect(page).to have_css('p', text: 'Comida tradicional Árabe.')
    end

    scenario 'show cuisine' do
        cuisine = Cuisine.create(name: 'Árabe', description: 'Comida tradicional Árabe.')

        visit root_path

        click_on 'Cozinhas'
        click_on 'Árabe'

        expect(page).to have_css('h1', text: 'Cozinha: Árabe')
        expect(page).to have_css('p', text: 'Comida tradicional Árabe.')
    end

    scenario 'edit cuisine' do
        cuisine = Cuisine.create(name: 'Árabe', description: 'Comida tradicional Árabe.')

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
end