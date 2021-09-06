class Meal < ApplicationRecord
  has_many :food_category_meals
  has_many :meals_ingredients, dependent: :destroy
  has_many :ingredients, through: :meals_ingredients
  has_many :food_categories, through: :food_category_meals
  has_many :order_meals, dependent: :destroy
  belongs_to :restaurant
  monetize :price_cents
  has_many :food_categories, through: :food_category_meals

end
