FactoryBot.define do
  factory :user do
    email { 'admin@admin.com' }
    password { '123456' }
  end

  factory :cuisine do
    name { 'Brasileira' }
    description { 'Cozinha típica brasileira' }
  end

  factory :recipe_type do
    name { 'Sobremesa' }
  end

  factory :recipe do
    title { 'Torta de Morango' }
    difficulty { 'Média' }
    ingredients { 'Trigo e Morango' }
    cook_time { 50 }
    cook_method { 'Misture os ingredientes' }
  end
end
