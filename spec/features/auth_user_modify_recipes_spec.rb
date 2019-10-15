require 'rails_helper'

feature 'auth user modify recipes' do
  scenario 'and create succesfully' do
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)

    recipe = create(:recipe, user: user, recipe_type: recipe_type,
                             cuisine: cuisine)

    expect(recipe.user).to eq user
  end

  scenario 'and not auth failed' do    
    visit new_recipe_path

    expect(current_path).to eq new_user_session_path
  end

  context 'and only modify your own recipes' do
    scenario 'by navigate' do
      user = create(:user, email: 'admin@admin.com')
      other_user = create(:user, email: 'admin2@admin.com')
  
      recipe_type = create(:recipe_type)
      cuisine = create(:cuisine)
      recipe = create(:recipe, user: other_user, recipe_type: recipe_type,
                               cuisine: cuisine)
  
      visit root_path
      click_on 'Receitas'
      click_on recipe.title
  
      expect(page).not_to have_link('Editar')
    end

    scenario 'by direct path' do
      user = create(:user, email: 'admin@admin.com')
      other_user = create(:user, email: 'admin2@admin.com')
      recipe_type = create(:recipe_type)
      cuisine = create(:cuisine)
      recipe = create(:recipe, user: other_user, recipe_type: recipe_type,
                               cuisine: cuisine)

      login_as(user, :scope => :user)
      visit edit_recipe_path(recipe)
  
      expect(current_path).to eq root_path
    end
  end
end

