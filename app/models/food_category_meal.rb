class FoodCategoryMeal < ApplicationRecord
  belongs_to :food_category
  belongs_to :meal
end
