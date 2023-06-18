class Recipe < ApplicationRecord
    belongs_to :user
    belongs_to :category
    has_many :ratings, dependent: :destroy
    has_many :comments, dependent: :destroy
    validates :title, presence: true, length: {minimum: 6, maximum: 100}
    validates :description, presence: true, length: {minimum: 10, maximum: 300}
    validates :preparation_steps, presence: true, length: {minimum: 10, maximum: 300}
end
