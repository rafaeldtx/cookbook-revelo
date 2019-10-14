class Cuisine < ApplicationRecord
    validates :name, :description, presence: true
    has_many :recipes, dependent: :nullify
end
