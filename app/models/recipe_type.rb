class RecipeType < ApplicationRecord
    validates :name, presence: { message: "Nome é obrigatório" }
    validates :name, uniqueness: { message: "Nome deve ser único" }
    
    has_many :recipes
end
