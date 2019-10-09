require 'rails_helper'

feature 'visitor view recipes' do
    scenario 'by recipes types' do
        recipe_type = RecipeType.create!(name: 'Sobremesa')
        other_recipe_type = RecipeType.create!(name: 'Entrada')
        cuisine = Cuisine.create!(name: 'Brasileira', description: 'Comida tradicional Árabe')
        Recipe.create!(title: 'Bolo de Cenoura', difficulty: 'Médio',
                        recipe_type: other_recipe_type, cuisine: cuisine,
                        cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                        cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
        Recipe.create!(title: 'Bolo de Chocolate', difficulty: 'Médio',
                        recipe_type: recipe_type, cuisine: cuisine,
                        cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                        cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
        visit root_path
        click_on 'Tipos de Receitas'
        click_on 'Sobremesa'

        expect(page).to have_css('h1', text:'Tipo de Receita: Sobremesa')
        expect(page).to have_css('h2', text:'Receitas')
        expect(page).to have_link('Bolo de Chocolate')
        expect(page).not_to have_link('Bolo de Cenoura')
    end
end