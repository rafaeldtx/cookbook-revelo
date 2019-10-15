FactoryBot.define do
  factory :recipe do
    title { 'Bolo de Cenoura' }
    difficulty { 'Médio' }
    ingredients { 'Farinha, açucar, cenoura' }
    cook_time { 50 }
    cook_method { 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o
                   restante dos ingredientes' }
  end
end
