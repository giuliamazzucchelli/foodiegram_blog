class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_many :recipes, dependent: :destroy
  acts_as_voter
  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users
  

  
  validates :username,  presence: true,
                          uniqueness: {case_sensitive: false},
                          length: {minimum:3, maximum:25}
  validates :bio, length: {maximum:160}
  
  def avatar_thumbnail
    avatar.variant(resize: "250x250",gravity: "center").processed
  end
  
end