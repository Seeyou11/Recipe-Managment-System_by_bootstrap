class User < ApplicationRecord
  before_save { self.email = email.downcase if email }
  has_many :comments
  has_many :recipes, dependent: :destroy
  has_many :ratings, dependent: :destroy
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 105 }, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_secure_password

  def rated?(recipe)
    ratings.exists?(recipe_id: recipe.id)
  end
end
