class FoodCategory < ApplicationRecord
  has_many :food_category_meals
  has_many :meals, through: :food_categories_meals
end
