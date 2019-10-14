FactoryBot.define do
  factory :recipe do
    title { 'Torta de Morango' }
    difficulty { 'Média' }
    ingredients { 'Trigo e Morango' }
    cook_time { 50 }
    cook_method { 'Misture os ingredientes' }
  end
end
