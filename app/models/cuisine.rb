class Cuisine < ApplicationRecord
    validates :name, :description, presence: true
    has_many :recipes
end
