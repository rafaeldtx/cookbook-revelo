require 'rails_helper'

feature 'auth user modify recipe_types' do
    context 'click on menu' do
        scenario 'before login failed' do
            visit root_path
    
            click_on 'Tipos de Receitas'
            click_on 'Enviar tipo de receita'

            expect(current_path).to eq new_user_session_path
        end
    end
end