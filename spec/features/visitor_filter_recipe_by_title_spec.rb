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
      user = create(:user, email: 'admin@admin.com', password: '12345678')
      recipe_type = create(:recipe_type)
      cuisine = create(:cuisine)
      create(:recipe, recipe_type: recipe_type, cuisine: cuisine, user: user,
                      title: 'Bolo de Cenoura')
      create(:recipe, recipe_type: recipe_type, cuisine: cuisine, user: user,
                      title: 'Bolo de Chocolate')
      
      visit root_path
      fill_in "Buscar Receitas",	with: "Bolo de Cenoura"
      click_on 'Buscar'
      
      expect(page).to have_link('Bolo de Cenoura')
      expect(page).not_to have_link('Bolo de Chocolate')    
    end
        
    scenario 'and see recipes by partial title' do
      user = create(:user)
      recipe_type = create(:recipe_type)
      cuisine = create(:cuisine)
      create(:recipe, recipe_type: recipe_type, cuisine: cuisine, user: user)
      create(:recipe, recipe_type: recipe_type, cuisine: cuisine, user: user,
                      title: 'Bolo de Chocolate')
          
      visit root_path
      fill_in 'Buscar Receitas',	with: 'Bolo'
      click_on 'Buscar'
      
      expect(page).to have_link('Bolo de Cenoura') 
      expect(page).to have_link('Bolo de Chocolate') 
    end
  end
end