require 'rails_helper'

feature 'user signup app spec' do
    scenario 'successfully' do
        visit root_path
        
        click_on 'Cadastrar-se'
        
        fill_in 'Email', with: 'user@user.com'
        fill_in 'Password', with: '123456'
        fill_in 'Password confirmation', with: '123456'
        click_on 'Sign up'
        
        expect(page).to have_content('Logado como: user@user.com')
        expect(page).to have_link('Logout')
        expect(page).not_to have_link('Login')
    end

    scenario 'and logout' do
        User.create(email: 'user@user.com', password: '123456')

        visit root_path
        
        click_on 'Login'
        fill_in 'Email', with: 'user@user.com'
        fill_in 'Password', with: '123456'
        click_on 'Log in'

        click_on 'Logout'

        expect(page).to have_link('Login')
        expect(page).not_to have_link('Logout')
    end
end