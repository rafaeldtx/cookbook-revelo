require 'rails_helper'

feature 'visitor view recipes' do
    scenario 'by recipes types' do
        user = create(:user)

        recipe_type = create(:recipe_type, name: 'Sobremesa')
        other_recipe_type = create(:recipe_type, name: 'Entrada')
        cuisine = create(:cuisine)
        create(:recipe, recipe_type: other_recipe_type, cuisine: cuisine,
                        user: user)
        create(:recipe, recipe_type: recipe_type, cuisine: cuisine, user: user,
                        title: 'Bolo de Chocolate')

        visit root_path
        click_on 'Tipos de Receitas'
        click_on 'Todos os Tipos'
        click_on 'Sobremesa'

        expect(page).to have_css('h1', text:'Tipo de Receita: Sobremesa')
        expect(page).to have_css('h2', text:'Receitas')
        expect(page).to have_link('Bolo de Chocolate')
        expect(page).not_to have_link('Bolo de Cenoura')
    end
end