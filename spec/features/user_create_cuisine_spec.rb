require 'rails_helper'

feature 'user create cuisine' do
    scenario 'register cuisine' do
        visit root_path

        click_on 'Criar nova cozinha'

        fill_in 'Nome', with: 'Árabe'
        fill_in 'Descrição', with: 'Originalmente, os árabes da península Arábica baseavam sua alimentação numa dieta de tâmaras, trigo, cevada, arroz e carne, com pouca variedade e uma ênfase em produtos similares ao iogurte, como o labneh (لبنة). À medida que os povos semitas indígenas da península se expandiram pelo Oriente Médio e pelas regiões vizinhas, seus gostos e ingredientes também se alteraram.'
        click_on 'Enviar'

        expect(page).to have_css('h1', text: 'Árabe')
        expect(page).to have_css('p', text: 'Originalmente, os árabes da península Arábica baseavam sua alimentação numa dieta de tâmaras, trigo, cevada, arroz e carne, com pouca variedade e uma ênfase em produtos similares ao iogurte, como o labneh (لبنة). À medida que os povos semitas indígenas da península se expandiram pelo Oriente Médio e pelas regiões vizinhas, seus gostos e ingredientes também se alteraram.')
    end
end