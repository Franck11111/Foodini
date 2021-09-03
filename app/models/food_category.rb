class FoodCategory < ApplicationRecord
  has_many :food_category_meals
  has_many :meals, through: :food_category_meals

  def allowed_food_types
    allowed_food_types = []
    meals.each do |meal|
      allowed_food_types << meal.food_categories.where.not(food_type: nil)
    end
    allowed_food_types.flatten.uniq
  end
end
