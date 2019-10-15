require 'rails_helper'

feature 'Admin register recipe_type' do
    scenario 'successfully' do
        # Arrange
        user = create(:user)
        # Act
        login_as(user, scope: :user)
        visit root_path
        click_on 'Tipos de Receitas'
        click_on 'Enviar tipo de receita'
        
        fill_in 'Nome', with: 'Sobremesa'
        
        click_on 'Enviar'
        
        # Assert
        expect(page).to have_content('Sobremesa')
    end
    
    scenario 'and validate' do
        # Arrange
        user = create(:user)
        recipe_type = create(:recipe_type)
        # Act
        login_as(user, scope: :user)
        visit root_path
        click_on 'Tipos de Receitas'
        click_on 'Enviar tipo de receita'
        
        fill_in 'Nome', with: 'Sobremesa'
        
        click_on 'Enviar'
        
        # Assert
        expect(page).to have_content('Nome deve ser único')
        expect(RecipeType.count).to eq 1
    end
end