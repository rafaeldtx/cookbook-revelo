require 'rails_helper'

feature 'visitor filter recipe by title' do
    context 'see search field' do
        scenario 'in root_path' do
            visit root_path
            expect(page).to have_css('input', id: 'title')            
        end
        
        scenario 'in list_path' do
            visit root_path
            click_on 'Receitas'
            expect(page).to have_css('input', id: 'title')
        end
    end
    
    context 'fill in search field' do
        scenario 'and get only one recipe filtered' do
            recipe_type = RecipeType.create!(name: 'Sobremesa')
            cuisine = Cuisine.create!(name: 'Brasileira', description: 'Comida tradicional Árabe')
            Recipe.create!(title: 'Bolo de Cenoura', difficulty: 'Médio',
                          recipe_type: recipe_type, cuisine: cuisine,
                          cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
            Recipe.create!(title: 'Bolo de Chocolate', difficulty: 'Médio',
                          recipe_type: recipe_type, cuisine: cuisine,
                          cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
            
            visit root_path
            fill_in "Buscar Receitas",	with: "Bolo de Cenoura"
            click_on 'Buscar'
            
            expect(page).to have_link('Bolo de Cenoura')
            expect(page).not_to have_link('Bolo de Chocolate')    
        end

        scenario 'and see recipes by partial title' do
            recipe_type = RecipeType.create!(name: 'Sobremesa')
            cuisine = Cuisine.create!(name: 'Brasileira', description: 'Comida tradicional Árabe')
            Recipe.create!(title: 'Bolo de Cenoura', difficulty: 'Médio',
                          recipe_type: recipe_type, cuisine: cuisine,
                          cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
            Recipe.create!(title: 'Bolo de Chocolate', difficulty: 'Médio',
                          recipe_type: recipe_type, cuisine: cuisine,
                          cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
                
            visit root_path
            fill_in 'Buscar Receitas',	with: 'Bolo'
            click_on 'Buscar'
            
            expect(page).to have_link('Bolo de Cenoura') 
            expect(page).to have_link('Bolo de Chocolate') 
        end
        
    end
end