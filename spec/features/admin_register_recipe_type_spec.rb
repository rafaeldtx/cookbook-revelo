require 'rails_helper'

feature 'Admin register recipe_type' do
    scenario 'successfully' do
        # Arrange
        # Act
        visit root_path
        click_on 'Enviar tipo de receita'

        fill_in 'Nome', with: 'Sobremesa'

        click_on 'Enviar'

        # Assert
        expect(page).to have_content('Nome')
        expect(page).to have_content('Sobremesa')
    end

    scenario 'and validate' do
        # Arrange
        recipe_type = RecipeType.create!(name: 'Sobremesa')
        # Act
        visit root_path
        click_on 'Enviar tipo de receita'

        fill_in 'Nome', with: 'Sobremesa'

        click_on 'Enviar'

        # Assert
        expect(page).to have_content('Nome deve ser único')
        expect(RecipeType.count).to eq 1
      end
end