class Category < ApplicationRecord
    validates :name, presence: true, uniqueness: true,  length: { minimum: 3, maximum: 25 }
    has_many :recipes, dependent: :destroy
end