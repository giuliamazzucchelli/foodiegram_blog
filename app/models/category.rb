class Category < ApplicationRecord  
    validates :name, presence: true, length: {minimum: 3, maximum: 30}
    validates_uniqueness_of :name
    has_many :recipe_categories
    has_many :recipes, through: :recipe_categories

end