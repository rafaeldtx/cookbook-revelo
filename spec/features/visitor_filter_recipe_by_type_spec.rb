require 'rails_helper'

feature 'visitor filter recipe by type' do
    context 'see search field' do
        scenario 'in root_path' do
            visit root_path
            expect(page).to have_css('input', id: 'search')            
        end

        scenario 'in list_path' do
            visit root_path
            click_on 'Receitas'
            expect(page).to have_css('input', id: 'search')
        end
    end
end