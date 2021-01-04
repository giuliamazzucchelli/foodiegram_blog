class Recipe < ApplicationRecord
    belongs_to :user
    has_one_attached :picture
    has_many :recipe_categories
    has_many :categories, through: :recipe_categories
    acts_as_votable

    scope :of_followed_users, -> (following_users) { where user_id: following_users }

    
    validates :title,   presence: true,
                        length: {minimum: 5, maximum: 40}
    
    validates :prep_time,   presence: true,
                            numericality: { only_integer: true, greater_than: 0}
    
    validates :cook_time, numericality: {only_integer: true, allow_nil: true,greater_than: 0}

    validates :servings, numericality: {only_integer:true, greater_than: 0, allow_nil:true}

    validates :ingredients, presence:true,
                            length: {minimum: 10, maximum: 500} 

    validates :directions,  presence:true,
                            length: {minimum: 50, maximum: 1000}

    validates :notes, length: {maximum:100}

    def picture_thumbnail
        picture.variant(resize: "300x300!").processed
    end

    def self.search_by(search_term)
        where("lower(title) LIKE :search_term", search_term: "%#{search_term.downcase}%")
    end





end