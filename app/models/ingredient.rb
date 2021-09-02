class Ingredient < ApplicationRecord
  has_many :order_ingredients, dependent: :destroy
  has_many :meals_ingredients, dependent: :destroy
end
