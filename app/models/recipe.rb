class Recipe < ApplicationRecord
    belongs_to :recipe_type
    belongs_to :cuisine
    
    validates :title, :difficulty, :recipe_type_id, :cook_time, :ingredients, :cook_method, :cuisine, presence: true

    def cook_time_minutes
        "#{cook_time} minutos"        
    end
end
